<!--Local customization file for "preFilterCommon.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:expand="http://cdlib.org/xtf/expand"
                xmlns:parse="http://cdlib.org/xtf/parse"
                xmlns:xtf="http://cdlib.org/xtf"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:FileUtils="java:org.cdlib.xtf.xslt.FileUtils"
                xmlns:CharUtils="java:org.cdlib.xtf.xslt.CharUtils"
                version="2.0"
                extension-element-prefixes="saxon FileUtils"
                exclude-result-prefixes="#all">
   <xsl:import href="../../../../style/textIndexer/common/preFilterCommon.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->

   <!-- template copied from style/textIndexer/common/preFilterCommon.xsl and over-ridden to add SETIS facets (at end) -->
   <!-- Add sort fields to DC meta-data -->
   <xsl:template name="add-fields">
      <xsl:param name="meta"/>
      <xsl:param name="display"/>
      
      <xtf:meta>
         <!-- Copy all the original fields -->
         <xsl:copy-of select="$meta/*"/>
         
         <!-- Add a field to record the document kind -->
         <display xtf:meta="true" xtf:tokenize="no">
            <xsl:value-of select="$display"/>
         </display>
         
         <!-- Parse the date field to create a year (or range of years) -->
         <xsl:apply-templates select="$meta/*:date" mode="year"/>
         
         <!-- Create sort fields -->
         <xsl:apply-templates select="$meta/*:title[1]" mode="sort"/>    
         <xsl:apply-templates select="$meta/*:creator[1]" mode="sort"/>
         <xsl:apply-templates select="$meta/*:date[1]" mode="sort"/>
         
         <!-- Create facets -->
         <xsl:apply-templates select="$meta/*:date" mode="facet"/>
         <xsl:apply-templates select="$meta/*:subject" mode="facet"/>
         
         <xsl:apply-templates select="$meta/*:title[1]" mode="browse"/>    
         <xsl:apply-templates select="$meta/*:creator[1]" mode="browse"/>
         
          <!-- Additional SETIS facets.  -->
          <xsl:apply-templates select="$meta/*:genre" mode="facet"/>
          <xsl:apply-templates select="$meta/*:subject" mode="facet"/>
          <xsl:apply-templates select="$meta/*:period" mode="facet"/>
          <xsl:apply-templates select="$meta/*:collection" mode="facet"/>
          <!--   Temporary addition for discovering unaccounted-for subject terms.  RB 18/02/10      -->
          <xsl:apply-templates select="$meta/*:unlisted" mode="facet"/>
          
	</xtf:meta>
   </xsl:template>
   
    <!-- Altered to ensure that only numerics are annotated with facet notation, & that each year facet in a range
          is given its own facet-date entry.  RB. SETIS.  02/06/10 -->
          <!-- revised by Conal Tuohy 2017-08-22 -->
  <xsl:template match="*:date" mode="facet">
          <xsl:choose>
          	<!-- 06-28-1886 -->
             <xsl:when test="matches(.,'[0-9]{2}-[0-9]{2}-[0-9]{4}')">
                <facet-date>
                   <xsl:attribute name="xtf:meta" select="'true'"/>
                   <xsl:attribute name="xtf:facet" select="'yes'"/>
                   <xsl:value-of select="replace(.,'([0-9]{2})-([0-9]{2})-([0-9]{4})','$3::$2::$1')"/>
                </facet-date>
             </xsl:when>
          	<!-- 1886-06-28 -->
             <xsl:when test="matches(.,'[0-9]{4}-[0-9]{2}-[0-9]{2}')">
                <facet-date>
                   <xsl:attribute name="xtf:meta" select="'true'"/>
                   <xsl:attribute name="xtf:facet" select="'yes'"/>
                   <xsl:value-of select="replace(.,'-','::')"/>
                </facet-date>
             </xsl:when>
             <xsl:otherwise>
                <xsl:for-each select="parse:year(string(.))">
                   <!--  Only wrap numeric in hierarchical facet notation.   -->
                   <xsl:if test= "string(number(.))!='NaN'">
                      <facet-date>
                         <xsl:attribute name="xtf:meta" select="'true'"/>
                         <xsl:attribute name="xtf:facet" select="'yes'"/>
                         <xsl:choose>
                            <xsl:when test="starts-with(.,'202')">
                               <xsl:value-of select="concat('2020s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'201')">
                               <xsl:value-of select="concat('2010s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'200')">
                               <xsl:value-of select="concat('2000s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'199')">
                               <xsl:value-of select="concat('1990s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'198')">
                               <xsl:value-of select="concat('1980s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'197')">
                               <xsl:value-of select="concat('1970s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'196')">
                               <xsl:value-of select="concat('1960s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'195')">
                               <xsl:value-of select="concat('1950s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'194')">
                               <xsl:value-of select="concat('1940s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'193')">
                               <xsl:value-of select="concat('1930s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'192')">
                               <xsl:value-of select="concat('1920s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'191')">
                               <xsl:value-of select="concat('1910s::',.,'::01::01')"/>
                            </xsl:when> 
                            <xsl:when test="starts-with(.,'190')">
                               <xsl:value-of select="concat('1900s::',.,'::01::01')"/>
                            </xsl:when> 
                            <xsl:when test="starts-with(.,'189')">
                               <xsl:value-of select="concat('1890s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'188')">
                               <xsl:value-of select="concat('1880s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'187')">
                               <xsl:value-of select="concat('1870s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'186')">
                               <xsl:value-of select="concat('1860s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'185')">
                               <xsl:value-of select="concat('1850s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'184')">
                               <xsl:value-of select="concat('1840s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'183')">
                               <xsl:value-of select="concat('1830s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'182')">
                               <xsl:value-of select="concat('1820s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'181')">
                               <xsl:value-of select="concat('1810s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'180')">
                               <xsl:value-of select="concat('1800s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'179')">
                               <xsl:value-of select="concat('1790s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'178')">
                               <xsl:value-of select="concat('1780s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'177')">
                               <xsl:value-of select="concat('1770s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'176')">
                               <xsl:value-of select="concat('1760s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'175')">
                               <xsl:value-of select="concat('1750s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'174')">
                               <xsl:value-of select="concat('1740s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'173')">
                               <xsl:value-of select="concat('1730s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'172')">
                               <xsl:value-of select="concat('1720s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'171')">
                               <xsl:value-of select="concat('1710s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'170')">
                               <xsl:value-of select="concat('1700s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'169')">
                               <xsl:value-of select="concat('1690s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'168')">
                               <xsl:value-of select="concat('1680s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'167')">
                               <xsl:value-of select="concat('1670s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'166')">
                               <xsl:value-of select="concat('1660s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'165')">
                               <xsl:value-of select="concat('1650s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'164')">
                               <xsl:value-of select="concat('1640s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'163')">
                               <xsl:value-of select="concat('1630s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'162')">
                               <xsl:value-of select="concat('1620s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'161')">
                               <xsl:value-of select="concat('1610s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:when test="starts-with(.,'160')">
                               <xsl:value-of select="concat('1600s::',.,'::01::01')"/>
                            </xsl:when>
                            <xsl:otherwise>
                               <xsl:value-of select="concat(.,'::01::01')"/>                        
                            </xsl:otherwise>
                         </xsl:choose>
                      </facet-date>
                   </xsl:if>
                </xsl:for-each>
             </xsl:otherwise>
          </xsl:choose>
     </xsl:template>
     
    <!-- Generate facet-genre. RB 03/02/10 -->
    <xsl:template match="*:genre" mode="facet">
       <facet-genre>
          <xsl:attribute name="xtf:meta" select="'true'"/>
          <xsl:attribute name="xtf:facet" select="'yes'"/>
          <xsl:value-of select="string(.)"/>
       </facet-genre>
    </xsl:template>
    
    <!-- Generate facet-period  RB 03/02/10 -->
    <xsl:template match="*:period" mode="facet">
       <facet-period>
          <xsl:attribute name="xtf:meta" select="'true'"/>
          <xsl:attribute name="xtf:facet" select="'yes'"/>
          <xsl:value-of select="string(.)"/>
       </facet-period>
    </xsl:template>
    
    <!-- Generate facet-collection  RB 23/02/10 -->
    <xsl:template match="*:collection" mode="facet">
       <facet-collection>
          <xsl:attribute name="xtf:meta" select="'true'"/>
          <xsl:attribute name="xtf:facet" select="'yes'"/>
          <xsl:value-of select="string(.)"/>
       </facet-collection>
    </xsl:template>

</xsl:stylesheet>
