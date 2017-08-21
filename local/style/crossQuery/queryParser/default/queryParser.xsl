<!--Local customization file for "queryParser.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:session="java:org.cdlib.xtf.xslt.Session"
                xmlns:freeformQuery="java:org.cdlib.xtf.xslt.FreeformQuery"
                extension-element-prefixes="session freeformQuery"
                exclude-result-prefixes="#all"
                version="2.0">
   <xsl:import href="../../../../../style/crossQuery/queryParser/default/queryParser.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->
   <xsl:import href="../common/queryParserCommon.xsl"/>
   <xsl:output method="xml" indent="yes" encoding="utf-8"/>
   <xsl:strip-space elements="*"/>
   
   <!-- template below imported simply to change $stylesheet variable to point to local resultFormatter.xsl -->
   <!-- TODO change core resultFormatter so that this variable is declared as top-level variable, so it can be over-ridden without over-riding the entire template -->
   <xsl:template match="/">
      
      <xsl:variable name="stylesheet" select="'local/style/crossQuery/resultFormatter/default/resultFormatter.xsl'"/>
      
      <!-- The top-level query element tells what stylesheet will be used to
         format the results, which document to start on, and how many documents
         to display on this page. -->
      <query indexPath="index" termLimit="1000" workLimit="1000000" style="{$stylesheet}" startDoc="{$startDoc}" maxDocs="{$docsPerPage}">
         
         <!-- sort attribute -->
         <xsl:if test="$sort">
            <xsl:attribute name="sortMetaFields">
               <xsl:choose>
                  <xsl:when test="$sort='title'">
                     <xsl:value-of select="'sort-title,sort-creator,sort-publisher,sort-year'"/>
                  </xsl:when>
                  <xsl:when test="$sort='year'">
                     <xsl:value-of select="'sort-year,sort-title,sort-creator,sort-publisher'"/>
                  </xsl:when>              
                  <xsl:when test="$sort='reverse-year'">
                     <xsl:value-of select="'-sort-year,sort-title,sort-creator,sort-publisher'"/>
                  </xsl:when>              
                  <xsl:when test="$sort='creator'">
                     <xsl:value-of select="'sort-creator,sort-year,sort-title'"/>
                  </xsl:when>
                  <xsl:when test="$sort='publisher'">
                     <xsl:value-of select="'sort-publisher,sort-title,sort-year'"/>
                  </xsl:when>     
                  <xsl:when test="$sort='rss'">
                     <xsl:value-of select="'-sort-date,sort-title'"/>
                  </xsl:when>         
               </xsl:choose>
            </xsl:attribute>
         </xsl:if>
         
         <!-- score normalization and explanation -->
         <xsl:if test="$normalizeScores">
            <xsl:attribute name="normalizeScores" select="$normalizeScores"/>
         </xsl:if>
         <xsl:if test="$explainScores">
            <xsl:attribute name="explainScores" select="$explainScores"/>
         </xsl:if>
         
         <!-- subject facet, normally shows top 10 sorted by count, but user can select 'more' 
              to see all sorted by subject. 
         -->
         <xsl:call-template name="facet">
            <xsl:with-param name="field" select="'facet-subject'"/>
            <xsl:with-param name="topGroups" select="'*[1-5]'"/>
            <xsl:with-param name="sort" select="'totalDocs'"/>
         </xsl:call-template>
         
         <!-- hierarchical date facet, shows most recent years first -->
         <xsl:call-template name="facet">
            <xsl:with-param name="field" select="'facet-date'"/>
            <xsl:with-param name="topGroups" select="'*'"/>
            <xsl:with-param name="sort" select="'reverseValue'"/>
         </xsl:call-template>
         
         <!-- to support title browse pages -->
         <xsl:if test="//param[@name='browse-title']">
            <xsl:variable name="page" select="//param[@name='browse-title']/@value"/>
            <xsl:variable name="pageSel" select="if ($page = 'first') then '*[1]' else $page"/>
            <facet field="browse-title" sortGroupsBy="value" sortDocsBy="sort-title,sort-creator,sort-publisher,sort-year" select="{concat('*|',$pageSel,'#all')}"/>
         </xsl:if>
         
         <!-- to support author browse pages -->
         <xsl:if test="//param[matches(@name,'browse-creator')]">
            <xsl:variable name="page" select="//param[matches(@name,'browse-creator')]/@value"/> 
            <xsl:variable name="pageSel" select="if ($page = 'first') then '*[1]' else $page"/>
            <facet field="browse-creator" sortGroupsBy="value" sortDocsBy="sort-creator,sort-title,sort-publisher,sort-year" select="{concat('*|',$pageSel,'#all')}"/>
         </xsl:if>
         
         <!-- process query -->
         <xsl:choose>
            <xsl:when test="matches($http.user-agent,$robots)">
               <xsl:call-template name="robot"/>
            </xsl:when>
            <xsl:when test="$smode = 'addToBag'">
               <xsl:call-template name="addToBag"/>
            </xsl:when>
            <xsl:when test="$smode = 'removeFromBag'">
               <xsl:call-template name="removeFromBag"/>
            </xsl:when>
            <xsl:when test="matches($smode,'showBag|emailFolder')">
               <xsl:call-template name="showBag"/>
            </xsl:when>
            <xsl:when test="$smode = 'moreLike'">
               <xsl:call-template name="moreLike"/>
            </xsl:when>
            <xsl:otherwise>
               <spellcheck/>
               <xsl:apply-templates/>
            </xsl:otherwise>
         </xsl:choose>
         
      </query>
   </xsl:template>   
   
</xsl:stylesheet>

