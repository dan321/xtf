<!--Local customization file for "teiDocFormatter.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xtf="http://cdlib.org/xtf"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:session="java:org.cdlib.xtf.xslt.Session"
                version="2.0"
                extension-element-prefixes="session"
                exclude-result-prefixes="#all">
   <xsl:import href="../../../../../style/dynaXML/docFormatter/tei/teiDocFormatter.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->
   <xsl:import href="../common/docFormatterCommon.xsl"/>
   <xsl:output method="xhtml"
               indent="no"
               encoding="UTF-8"
               media-type="text/html; charset=UTF-8"
               doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
               doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
               exclude-result-prefixes="#all"
               omit-xml-declaration="yes"/>
   <xsl:output name="frameset"
               method="xhtml"
               indent="no"
               encoding="UTF-8"
               media-type="text/html; charset=UTF-8"
               doctype-public="-//W3C//DTD XHTML 1.0 Frameset//EN"
               doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"
               omit-xml-declaration="yes"
               exclude-result-prefixes="#all"/>
   <xsl:strip-space elements="*"/>
   <xsl:include href="autotoc.xsl"/>
   <xsl:include href="component.xsl"/>
   <xsl:include href="search.xsl"/>
   <xsl:include href="parameter.xsl"/>
   <xsl:include href="structure.xsl"/>
   <xsl:include href="table.xsl"/>
   <xsl:include href="titlepage.xsl"/>
   
   	<!-- frameset template copied from style/dynaXML/docFormatter/teiDocFormatter.xsl and modified to use relative URIs for the individual frames -->
   	<!-- i.e. by removing <xsl:value-of select="$xtfURL"/> as the prefix of the @src attribute of each frame -->
    <xsl:template name="frames" exclude-result-prefixes="#all">
      
      <xsl:variable name="bbar.href"><xsl:value-of select="$query.string"/>&#038;doc.view=bbar&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/></xsl:variable> 
      <xsl:variable name="toc.href"><xsl:value-of select="$query.string"/>&#038;doc.view=toc&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;toc.id=<xsl:value-of select="$toc.id"/><xsl:value-of select="$search"/>#X</xsl:variable>
      <xsl:variable name="content.href"><xsl:value-of select="$query.string"/>&#038;doc.view=content&#038;chunk.id=<xsl:value-of select="$chunk.id"/>&#038;toc.depth=<xsl:value-of select="$toc.depth"/>&#038;brand=<xsl:value-of select="$brand"/>&#038;anchor.id=<xsl:value-of select="$anchor.id"/><xsl:value-of select="$search"/><xsl:call-template name="create.anchor"/></xsl:variable>  
      <xsl:result-document format="frameset" exclude-result-prefixes="#all">
         <html xml:lang="en" lang="en">
            <head>
               <title>
                  <xsl:value-of select="$doc.title"/>
               </title>
               <link rel="shortcut icon" href="icons/default/favicon.ico" />
            </head>
            <frameset rows="120,*">
               <frame frameborder="1" scrolling="no" title="Navigation Bar">
                  <xsl:attribute name="name">bbar</xsl:attribute>
                  <xsl:attribute name="src">view?<xsl:value-of select="$bbar.href"/></xsl:attribute>
               </frame>
               <frameset cols="35%,65%">
                  <frame frameborder="1" title="Table of Contents">
                     <xsl:attribute name="name">toc</xsl:attribute>
                     <xsl:attribute name="src">view?<xsl:value-of select="$toc.href"/></xsl:attribute>
                  </frame>
                  <frame frameborder="1" title="Content">
                     <xsl:attribute name="name">content</xsl:attribute>
                     <xsl:attribute name="src">view?<xsl:value-of select="$content.href"/></xsl:attribute>
                  </frame>
               </frameset>
               <noframes>
                  <body>
                     <h1>Sorry, your browser doesn't support frames...</h1>
                  </body>
               </noframes>
            </frameset>
         </html>
      </xsl:result-document>
   </xsl:template>   
</xsl:stylesheet>

