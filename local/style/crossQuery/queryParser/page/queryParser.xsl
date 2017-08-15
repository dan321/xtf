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
   <xsl:template match="/">
         <query indexPath="index" termLimit="1000" workLimit="1000000" style="local/style/crossQuery/resultFormatter/page/resultFormatter.xsl" startDoc="1" maxDocs="1"/>
</xsl:template>
</xsl:stylesheet>

