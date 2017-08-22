<!--Local customization file for "teiPreFilter.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:parse="http://cdlib.org/xtf/parse"
                xmlns:xtf="http://cdlib.org/xtf"
                xmlns:FileUtils="java:org.cdlib.xtf.xslt.FileUtils"
                version="2.0"
                extension-element-prefixes="date FileUtils"
                exclude-result-prefixes="#all">
   <xsl:import href="../../../../style/textIndexer/tei/teiPreFilter.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->
   <xsl:import href="../common/preFilterCommon.xsl"/>
   <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
   
   
  <!-- RB. SETIS.  30/03/10.  Supplied by Richard Padley, XTF user group, Dec 9, 2008  -->
  <!-- TODO ensure that input texts all do have a /*/@xml:id since XTF requires this, and generate-id() will not generate a stable value -->
  <!-- TODO find out if /*/@xml:id is required to be unique throughout the corpus, or just within the document -->
   <xsl:template match="/*">
      <xsl:copy>
         <xsl:namespace name="xtf" select="'http://cdlib.org/xtf'"/>
         <xsl:copy-of select="@*"/>
         <xsl:if test="not(@xml:id)">
             <xsl:attribute name="xml:id" select="generate-id()"/>
          </xsl:if>
         <xsl:call-template name="get-meta"/>
         <xsl:apply-templates/>
      </xsl:copy>
   </xsl:template>
   
    <!-- RB. SETIS.  30/03/10.  Supplied by Richard Padley, XTF user group, Dec 9, 2008  -->
    <!-- add id to important elements if not present -->
    <!-- Modified Conal Tuohy 2017-08-22 to create a hierarchical id instead of using generate-id(), for better stability -->
    <xsl:template match="*:div | *:figure | *:table | *:note">
       <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:call-template name="generate-id"/>
          <xsl:apply-templates/>
       </xsl:copy>
    </xsl:template>    
    

<xsl:template name="generate-id">
          <xsl:if test="not(@xml:id)">
             <xsl:attribute name="xml:id" select="
             	string-join(
		  for $e in (ancestor-or-self::*[self::*:div | self::*:figure | self::*:table | self::*:note]) return concat(
			 name($e), 
			 count($e/preceding-sibling::*[name() = name($e)])+1
		   ),
		   '-'
	   )"/>
          </xsl:if>
</xsl:template>

<xsl:template match="*[local-name()='bibl']">
        <xsl:copy>
           <xsl:copy-of select="@*"/>
           <xsl:call-template name="generate-id"/>
           <xsl:attribute name="xtf:sectionType" select="'citation'"/>
           <xsl:attribute name="xtf:wordBoost" select="2.0"/>
           <xsl:apply-templates/>
        </xsl:copy>
   </xsl:template>       
    
	<!-- first line of poem -->
    <xsl:template match="*:l[number(@n) = 1]">
       <xsl:copy>
          <xsl:copy-of select="@*"/>
          <xsl:attribute name="xtf:sectionType" select="'firstline'"/>
          <xsl:attribute name="xtf:wordBoost" select="2.0"/>
          <xsl:apply-templates/>
       </xsl:copy>
     </xsl:template>
     
    <!--  RB. SETIS. 30/03/10.  SETIS uses titleStmt\title, rather than titlePage\titlePart -->
    <xsl:template match="*:titleStmt//*:title">
        <xsl:copy>
           <xsl:copy-of select="@*"/>
           <xsl:attribute name="xtf:wordBoost" select="100.0"/>
        </xsl:copy>
     </xsl:template>     
     
   <!-- ====================================================================== -->
   <!-- Metadata Indexing                                                      -->
   <!-- ====================================================================== -->
   
   <xsl:template name="get-meta">
      <!-- Access Dublin Core Record (if present) -->
      <xsl:variable name="dcMeta">
         <xsl:call-template name="get-dc-meta"/>
      </xsl:variable>
      
      <!-- If no Dublin Core present, then extract meta-data from the TEI -->
      <xsl:variable name="meta">
         <xsl:choose>
            <xsl:when test="$dcMeta/*">
               <xsl:copy-of select="$dcMeta"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="check-pdf-status"/>
               <xsl:call-template name="get-tei-title"/>
               <xsl:call-template name="get-tei-creator"/>
               <xsl:call-template name="get-tei-subject"/>
               <xsl:call-template name="get-tei-description"/>
               <xsl:call-template name="get-tei-publisher"/>
               <xsl:call-template name="get-tei-contributor"/>
               <xsl:call-template name="get-tei-date"/>
               <xsl:call-template name="get-tei-type"/>
               <xsl:call-template name="get-tei-format"/>
               <xsl:call-template name="get-tei-identifier"/>
               <xsl:call-template name="get-tei-source"/>
               <xsl:call-template name="get-tei-language"/>
               <xsl:call-template name="get-tei-relation"/>
               <xsl:call-template name="get-tei-coverage"/>
               <xsl:call-template name="get-tei-rights"/>
               <xsl:call-template name="get-tei-gender"/>
               <!-- special values for OAI -->
               <xsl:call-template name="oai-datestamp"/>
               <xsl:call-template name="oai-set"/>
               <xsl:call-template name="get-tei-facet-subject"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <!-- Add doc kind and sort fields to the data, and output the result. -->
      <xsl:call-template name="add-fields">
         <xsl:with-param name="display" select="'dynaxml'"/>
         <xsl:with-param name="meta" select="$meta"/>
      </xsl:call-template>    
   </xsl:template>     


   
    <!-- If there's a pdf for this doc, add metadata for use during brief record display.  
         Assumes that a matching pdf will be based on the SETIS type identifier (if noted within the XML).  RB. 15/04/11   -->
         <!-- TODO check for ../../../data-2/ folder - is this code just a relic? -->
   <xsl:template name="check-pdf-status">
      <xsl:variable name="pdflocation">
         <xsl:choose>
            <xsl:when test="//*:fileDesc/*:publicationStmt/*:idno[contains(@type, 'setis')]">
               <xsl:text>../../../data-2/</xsl:text>
               <xsl:value-of select="//*[local-name()='fileDesc']/*[local-name()='publicationStmt']/*[local-name()='idno'][contains(@type, 'setis')][1]"/>
               <xsl:text>.pdf</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>no-id-no-pdf</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable> 
<!--      <xsl:message><xsl:value-of select="$pdflocation"></xsl:value-of></xsl:message>-->
      <xsl:choose>
         <xsl:when test="FileUtils:exists($pdflocation)">
<!--            <xsl:message><xsl:text>pdf found</xsl:text></xsl:message>-->
            <pdf-status xtf:meta="true">
               <xsl:text>true</xsl:text>
            </pdf-status>
         </xsl:when>
         <xsl:otherwise>
<!--            <xsl:message><xsl:text>not found</xsl:text></xsl:message>-->
            <pdf-status xtf:meta="true">
               <xsl:text>false</xsl:text>
            </pdf-status>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
	<!-- author gender.  RB 18/02/10 --> 
	<!-- revised Conal Tuohy 2017-08-22 to allow for multiple authors and hence genders -->
	<xsl:template name="get-tei-gender">
		<xsl:variable name="authors" select="//*:profileDesc/*:particDesc/*:person[@role = 'author']"/>
		<xsl:if test="$authors[@sex = '1']">
			<gender xtf:meta="true">male</gender>
      		</xsl:if>
      		<xsl:if test="$authors[@sex = '2']">
      			<gender xtf:meta="true">female</gender>
		</xsl:if>
	</xsl:template>

	
   <!-- subject. Altered for SETIS.  Used with differentiated keywords.  RB 18/02/10-->   
   <!-- TODO move classification codes out of XSLT into the TEI -->
   <xsl:template name="get-tei-facet-subject">
      <xsl:choose>
         <xsl:when test="//*[local-name()='keywords'][@scheme = 'setis-genre']/*[local-name()='term']">
            <xsl:for-each select="//*[local-name()='keywords'][@scheme = 'setis-genre']/*[local-name()='term']">
               <xsl:if test="string-length(.) &gt; 0">
                  <facet-genre xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                     <xsl:value-of select="."/>
                  </facet-genre>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>      
      <xsl:choose>
         <xsl:when test="//*[local-name()='keywords'][@scheme = 'setis-subject']/*[local-name()='term']">
            <xsl:for-each select="//*[local-name()='keywords'][@scheme = 'setis-subject']/*[local-name()='term']">
               <xsl:if test="string-length(.) &gt; 0">
                  <facet-subject xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                     <xsl:value-of select="."/>
                  </facet-subject>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="//*[local-name()='keywords'][@scheme = 'setis-collection']/*[local-name()='term']">
            <xsl:for-each select="//*[local-name()='keywords'][@scheme = 'setis-collection']/*[local-name()='term']">
               <xsl:if test="string-length(.) &gt; 0">
                  <xsl:choose>
                     <xsl:when test="contains(., 'acdp')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'The Australian Cooperative Digitisation Project'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'anderson')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'The John Anderson Archive'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'early settlement')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'First Fleet and Early Settlement'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'exploration')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'Journals of Inland Exploration'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'federation')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'Australian Federation Full Text Database'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'law')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'Classic Texts in Australian and International Taxation Law'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'maiden')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'Joseph Henry Maiden Botanical Texts'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'ozlit')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'Australian Digital Collections'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'ozpoets')">
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="'Australian Poets. Brennan, Harford, Slessor'"/>
                        </facet-collection>
                     </xsl:when>
                     <xsl:otherwise>
                        <facet-collection xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                           <xsl:value-of select="."/>
                        </facet-collection>                        
                     </xsl:otherwise>
                  </xsl:choose>      
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="//*[local-name()='keywords'][@scheme = 'setis-unlisted']/*[local-name()='term']">
            <xsl:for-each select="//*[local-name()='keywords'][@scheme = 'setis-unlisted']/*[local-name()='term']">
               <xsl:if test="string-length(.) &gt; 0">
                  <facet-unlisted xtf:meta="true" xtf:indexOnly="yes" xtf:tokenize="no">
                     <xsl:value-of select="."/>
                  </facet-unlisted>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
      
   </xsl:template>

   <!-- subject. Altered for SETIS.  Used with differentiated keywords.  RB 18/02/10-->   
   <xsl:template name="get-tei-subject">
      <xsl:choose>
         <xsl:when test="//*[local-name()='keywords'][@scheme = 'setis-genre']/*[local-name()='term']">
            <xsl:for-each select="//*[local-name()='keywords'][@scheme = 'setis-genre']/*[local-name()='term']">
               <xsl:if test="string-length(.) &gt; 0">
                  <genre xtf:meta="true">
                     <xsl:value-of select="."/>
                  </genre>
               </xsl:if>
               </xsl:for-each>
         </xsl:when>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="//*[local-name()='keywords'][@scheme = 'setis-subject']/*[local-name()='term']">
            <xsl:for-each select="//*[local-name()='keywords'][@scheme = 'setis-subject']/*[local-name()='term']">
               <xsl:if test="string-length(.) &gt; 0">
                  <subject xtf:meta="true">
                     <xsl:value-of select="."/>
                  </subject>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="//*[local-name()='keywords'][@scheme = 'setis-collection']/*[local-name()='term']">
            <xsl:for-each select="//*[local-name()='keywords'][@scheme = 'setis-collection']/*[local-name()='term']">
               <xsl:if test="string-length(.) &gt; 0">
                  <xsl:choose>
                     <xsl:when test="contains(., 'acdp')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'The Australian Cooperative Digitisation Project'"/>
                        </collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'anderson')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'The John Anderson Archive'"/>
                        </collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'early settlement')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'First Fleet and Early Settlement'"/>
                        </collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'exploration')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'Journals of Inland Exploration'"/>
                        </collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'federation')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'Australian Federation Full Text Database'"/>
                        </collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'law')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'Classic Texts in Australian and International Taxation Law'"/>
                        </collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'maiden')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'Joseph Henry Maiden Botanical Texts'"/>
                        </collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'ozlit')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'Australian Digital Collections'"/>
                        </collection>
                     </xsl:when>
                     <xsl:when test="contains(., 'ozpoets')">
                        <collection xtf:meta="true">
                           <xsl:value-of select="'Australian Poets. Brennan, Harford, Slessor'"/>
                        </collection>
                     </xsl:when>
                     <xsl:otherwise>
                        <collection xtf:meta="true">
                           <xsl:value-of select="."/>
                        </collection>                        
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
      <xsl:choose>
         <xsl:when test="//*[local-name()='keywords'][@scheme = 'setis-unlisted']/*[local-name()='term']">
            <xsl:for-each select="//*[local-name()='keywords'][@scheme = 'setis-unlisted']/*[local-name()='term']">
               <xsl:if test="string-length(.) &gt; 0">
                  <unlisted xtf:meta="true">
                     <xsl:value-of select="."/>
                  </unlisted>                  
               </xsl:if>               
            </xsl:for-each>
         </xsl:when>
      </xsl:choose>
      
   </xsl:template>   

    <!-- date.  Altered for SETIS, so that creation date is preferred.  -->
    <!-- refactored Conal Tuohy 2017-08-22 -->
    <xsl:template name="get-tei-date">
    	<xsl:variable name="date" select="//*:teiHeader/*:profileDesc/*:creation/*:date"/>
    	<xsl:if test="$date">
             <date xtf:meta="true">
                <xsl:value-of select="$date"/>
             </date>
         </xsl:if>
    </xsl:template>   
</xsl:stylesheet>

