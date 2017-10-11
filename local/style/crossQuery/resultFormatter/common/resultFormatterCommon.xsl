<!--Local customization file for "resultFormatterCommon.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:xtf="http://cdlib.org/xtf"
                xmlns:editURL="http://cdlib.org/xtf/editURL"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="#all"
                version="2.0">
   <xsl:import href="../../../../../style/crossQuery/resultFormatter/common/resultFormatterCommon.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->
   <xsl:import href="../../../xtfCommon/xtfCommon.xsl"/>
   <xsl:import href="format-query.xsl"/>
   <xsl:import href="spelling.xsl"/>
   
   <xsl:param name="brand.title" select="$brand.file//title/node()" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
   
   
	<!-- local stylesheet overrides the XTF default to alter the behaviour of loading the "brand" xml file -->
	<!-- In the base implementation, the 'default.xml' brand file is loaded when no "brand" parameter in the request URI -->
	<!-- In this implementation, the 'default.xml' brand file also provides fallback values for links, header and footer,
		if the named brand doesn't supply them (i.e. the named brands inherit links, header, and footer from default.xml) -->
	<xsl:variable name="default-brand.file" select="document('../../../../../brand/default.xml')"/>
	<xsl:variable name="brand.file">
		<xsl:choose>
			<xsl:when test="$brand != ''">
				<xsl:copy-of select="document(concat('../../../../../brand/',$brand,'.xml'))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$default-brand.file"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:param name="brand.links" select="($brand.file//links, $default-brand.file//links)[1]/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
	<xsl:param name="brand.header" select="($brand.file//header, $default-brand.file//header)[1]/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
	<xsl:param name="brand.footer" select="($brand.file//footer, $default-brand.file//footer)[1]/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
   

	<xsl:template name="masthead">
		<div id="masthead">
			<a href="#content" class="skip-nav">Skip to main content</a>
			<h1>
				<a id="logo" href="http://sydney.edu.au/">The University of Sydney</a>
				<span id="separator">-</span>
				<span id="tag-line">Australian Digital Collections</span>
			</h1>
		</div>
	</xsl:template>

	<xsl:template name="collection-selector">	
		<!-- Start global nav -->
		<form id="search" action="">
			<input type="hidden" name="page" value="home" />
			<select name="brand">
				<option value="ozlit">Select a collection</option>
				<option value="acdp" label="Australian Cooperative Digitisation Project">The Australian Cooperative Digitisation Project</option>
				<option value="ozfed" label="Australian Federation Full Text Database">Australian Federation Full Text Database</option>
				<option value="ozpoets" label="Australian Poets. Brennan, Harford, Slessor">Australian Poets. Brennan, Harford, Slessor</option>
				<option value="ozlaw" label="Classic Texts in Australian and International Taxation Law">Classic Texts in Australian and International Taxation Law&#160;&#160;&#160;&#160;&#160;&#160;</option>
				<option value="ozfleet" label="First Fleet and Early Settlement">First Fleet and Early Settlement</option>
				<option value="anderson" label="The John Anderson Archive">The John Anderson Archive</option>
				<option value="maiden" label="Joseph Henry Maiden Botanical Texts">Joseph Henry Maiden Botanical Texts</option>
				<option value="ozexplore" label="Journals of Inland Exploration">Journals of Inland Exploration</option>
			</select>
			<input type="submit" value="Go" class="button"/>
		</form>
	</xsl:template>
   
</xsl:stylesheet>

