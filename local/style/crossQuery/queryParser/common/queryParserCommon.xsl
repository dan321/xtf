<!--Local customization file for "queryParserCommon.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:session="java:org.cdlib.xtf.xslt.Session"
                extension-element-prefixes="session"
                exclude-result-prefixes="#all"
                version="2.0">
   <xsl:import href="../../../../../style/crossQuery/queryParser/common/queryParserCommon.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->
   
   <!-- list of fields to search in 'keyword' search; generally these should
        be the same fields shown in the search result listing, so the user
        can see all the matching words. -->
   <xsl:param name="fieldList" select="'text title creator subject '"/>
</xsl:stylesheet>

