<!-- 
This stylesheet routes requests which contain a "page" URI parameter to a "static page" queryParser
which does not perform a search but simply returns a page corresponding to that parameter.
e.g. page could equal "home" or "about" or "contact".
-->

<!--Local customization file for "queryRouter.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all"
                version="2.0">
   <xsl:import href="../../../style/crossQuery/queryRouter.xsl"/>

   <!--declarations in this file take precedence over those in the stylesheet imported above.-->
   <xsl:output method="xml" indent="yes" encoding="utf-8"/>
   <xsl:strip-space elements="*"/>
   <xsl:param name="page"/>
   
   <xsl:template match="/">
   	<xsl:choose>
   		<xsl:when test="$page">
   			<route>
   				<queryParser path="local/style/crossQuery/queryParser/page/queryParser.xsl"/>
   			</route>
   		</xsl:when>
   		<xsl:otherwise>
   			<xsl:apply-imports/>
   		</xsl:otherwise>
   	</xsl:choose>
   </xsl:template>
   
</xsl:stylesheet>


