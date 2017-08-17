
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="2.0">
   
	<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- Query result formatter stylesheet                                      -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->


   
	<!-- ====================================================================== -->
	<!-- Import Common Templates                                                -->
	<!-- ====================================================================== -->

	<xsl:import href="../common/resultFormatterCommon.xsl"/>
   
	<!-- ====================================================================== -->
	<!-- Output                                                                 -->
	<!-- ====================================================================== -->

	<xsl:output method="xhtml" indent="no" encoding="UTF-8" media-type="text/html; charset=UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" omit-xml-declaration="yes" exclude-result-prefixes="#all"/>
   
	<!-- ====================================================================== -->
	<!-- Local Parameters                                                       -->
	<!-- ====================================================================== -->

	<xsl:param name="css.path" select="concat($xtfURL, 'css/default/')"/>
	<xsl:param name="icon.path" select="concat($xtfURL, 'icons/default/')"/>
	<xsl:param name="docHits" select="/crossQueryResult/docHit"/>
	<xsl:param name="email"/>
	<xsl:variable name="page" select="/crossQueryResult/parameters/param[@name='page']/@value"/>
   
   
	<!-- ====================================================================== -->
	<!-- Results Template                                                       -->
	<!-- ====================================================================== -->

	<xsl:template match="crossQueryResult" exclude-result-prefixes="#all">
		<xsl:variable name="page-content" select="$brand.file//html:page[@name=$page]"/>
		<html xml:lang="en" lang="en">
			<head>
				<title>
					<xsl:value-of select="$page-content/@title"/>
				</title>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
				<xsl:copy-of select="$brand.links"/>
				<!-- AJAX support -->
				<script src="//code.jquery.com/jquery-latest.min.js" type="text/javascript"/>
			</head>
			<body>
				<xsl:copy-of select="$brand.header"/><!-- QAZ is this actually a global header? i.e. site-wide, across all brands? -->
				<div id="w1">
					<div id="w2">
						<div id="w3">
							<div id="head">
								<div id="masthead">
									<a href="#content" class="skip-nav">Skip to main content</a>
									<h1>
										<a id="logo" href="http://sydney.edu.au/">The University of Sydney</a>
										<span id="separator">-</span>
										<span id="tag-line">Australian Digital Collections</span>
									</h1>
								</div>
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
								
								<!-- breadcrumbs -->
								<ul id="nav-global">
									<!-- use the "active" class to define an active item (highlighted text and nav indicator) -->
									<li class="active">
										<a href="http://adc.library.usyd.edu.au/">Home</a>
									</li>
									<li>
										<a href="https://library.sydney.edu.au/">Library</a>
									</li>
									<li>
										<a href="https://library.sydney.edu.au/collections/digital-collections.html">Digital Collections</a>
									</li>
								</ul>
							</div>
							<div id="tabbar"> <!-- You add your tabbar items here if you want to there is an edited out example below -->
							 <!-- 
							  <ul id="tabs" class="horizontal">
							  <li class="active"> <span><a href="/">ozlit</a></span> </li>
							</ul>
							 --></div>
							<br />	
							<div class="breadcrumb moved">
								<span class="prefix">You are here: </span>
								<a href="search?page=home">Australian Digital Collections</a>
							</div>		
							
							<div id="mid" class="clearfix">
								<!-- start menu -->
								<div id="menu" class="withouttabs">
									<dl>
										<dt>Australian Digital Collections</dt>
										<dd>
											<ul>
												<li class="static">
													<a href="#">Browse</a>
													<ul>
														<li>
															<a href="search?database=&amp;collection=&amp;browse-creator=first&amp;sort=creator">Author</a>
														</li>
														<li>
															<a href="search?database=&amp;collection=&amp;browse-title=first&amp;sort=title">Title</a>
														</li>
														
														<li>
															<a href="search?database=&amp;collection=&amp;browse-all=yes&amp;sort=title">All</a>
														</li>
													</ul>
												</li>
												<li class="static">
													<a href="#">Search</a>
													<ul>
														<li>
															<a href="search?database=">Keywords</a>
														</li>
														<li>
															<a href="search?smode=advanced&amp;database=">Advanced</a>
														</li>
													</ul>
												</li>
												<li>
													<a href="search?page=about">About</a>
												</li>
												<li>
													<a href="search?page=contact">Contact</a>
												</li>
											</ul>
										</dd>
									</dl>
								</div>
								<div id="content" class="withtoutabs nofeature">
									<div id="w4">
										<xsl:copy-of select="$page-content/node()"/>
									</div>
								</div>
							</div>
							<xsl:copy-of select="$brand.footer"/>
						</div>
					</div>
				</div>

	
			</body>
		</html>
	</xsl:template>


</xsl:stylesheet>
