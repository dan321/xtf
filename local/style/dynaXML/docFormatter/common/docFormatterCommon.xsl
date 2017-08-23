<!--Local customization file for "docFormatterCommon.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xtf="http://cdlib.org/xtf"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:session="java:org.cdlib.xtf.xslt.Session"
                version="2.0"
                extension-element-prefixes="session"
                exclude-result-prefixes="#all">
   <xsl:import href="../../../../../style/dynaXML/docFormatter/common/docFormatterCommon.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->
   <xsl:import href="../../../xtfCommon/xtfCommon.xsl"/>

	<!-- param copied from style/dynaXML/docFormatter/common/docFormatterCommon.xsl and modified to remove $xtfURL prefix -->
      <xsl:param name="doc.path"><xsl:value-of select="$dynaxmlPath"/>?<xsl:value-of select="$query.string"/></xsl:param>

</xsl:stylesheet>

