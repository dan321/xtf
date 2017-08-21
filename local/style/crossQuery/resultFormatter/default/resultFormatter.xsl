<!--Local customization file for "resultFormatter.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:session="java:org.cdlib.xtf.xslt.Session"
                xmlns:editURL="http://cdlib.org/xtf/editURL"
                xmlns="http://www.w3.org/1999/xhtml"
                extension-element-prefixes="session"
                exclude-result-prefixes="#all"
                version="2.0">
   <xsl:import href="../../../../../style/crossQuery/resultFormatter/default/resultFormatter.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->
   <xsl:import href="../common/resultFormatterCommon.xsl"/>
   <xsl:import href="rss.xsl"/>
   <xsl:include href="searchForms.xsl"/>
   <xsl:output method="xhtml"
               indent="no"
               encoding="UTF-8"
               media-type="text/html; charset=UTF-8"
               doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
               doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
               omit-xml-declaration="yes"
               exclude-result-prefixes="#all"/>


               
               <!-- the following template was copied from the SETIS-customised XTF 2 resultFormatter.xsl stylesheet -->
               
   <!-- ====================================================================== -->
   <!--   Replacement results template.                                        -->
   <!--   RB. SETIS. 07/07/10                                                  -->
   <!-- ====================================================================== -->
   <xsl:template match="crossQueryResult" mode="results" exclude-result-prefixes="#all">
      
      <!-- modify query URL -->
      <xsl:variable name="modify" select="if(matches($smode,'simple')) then 'simple-modify' else 'advanced-modify'"/>
      <xsl:variable name="modifyString" select="editURL:set($queryString, 'smode', $modify)"/>
      
      <html xml:lang="eng" xmlns="http://www.w3.org/1999/xhtml" lang="eng">
         <head>
            
            <!--            <script src="script/popup.js" type="text/javascript"/>-->
            <title>
               <xsl:value-of select="$brand.title"/>
            </title>
            <xsl:copy-of select="$brand.links"/>
            <!-- AJAX support -->
            <script src="script/yui/yahoo-dom-event.js" type="text/javascript"/>
            <script src="script/yui/connection-min.js" type="text/javascript"/>
         </head>
         <body class="splash">
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-PHK72C"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script type="text/javascript">(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&amp;l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-PHK72C');</script>
<!-- End Google Tag Manager -->
            <div id="topheader" class="topheader"><div id="topheader" class="topheader"><ul><li><a href="http://www.library.usyd.edu.au/" title="Library">Library</a></li><li><a href="https://myuni.sydney.edu.au" title="My Uni">My Uni</a></li><li><a href="http://intranet.sydney.edu.au" title="Staff Intranet">Staff Intranet</a></li></ul></div></div>
            <div id="w1">
               <div id="w2">
                  <div id="w3">
                  	<!-- TODO ozlit-header 
                     <xsl:call-template name="ozlit-header"/>
                     -->
                     <div id="head">

			<xsl:call-template name="masthead"/>
			<xsl:call-template name="collection-selector"/>
			</div>
			<div class="breadcrumb moved">
                        <xsl:call-template name="setis-breadcrumb"/>
                        <!-- result header -->
                        <div class="resultsHeader">
                           <table>
                              <tr>
                                 <td colspan="2" class="right">
                                    <xsl:if test="$smode != 'showBag'">
                                       <xsl:variable name="bag" select="session:getData('bag')"/>
                                       <strong><a href="{$xtfURL}{$crossqueryPath}?smode=showBag;database={$brand}">My citations</a></strong> (<span
                                          id="bagCount"><xsl:value-of select="count($bag/bag/savedDoc)"/></span>) </xsl:if>
                                 </td>
                              </tr>
                              <tr>
                                 <td>
                                    <xsl:choose>
                                       <xsl:when test="$smode='showBag'">
                                          <a>
                                             <xsl:attribute name="href">javascript://</xsl:attribute>
                                             <xsl:attribute name="onclick">
                                                <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$xtfURL"
                                                />search?smode=getAddress<xsl:text>','popup','width=850,height=300,resizable=no,scrollbars=no')</xsl:text>
                                             </xsl:attribute>
                                             <xsl:text>E-mail My Citations</xsl:text>
                                          </a>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <div class="query">
                                             <div class="label">
                                                <b><xsl:value-of select="if($browse-all) then 'Browse by' else 'Search'"/>:</b>
                                             </div>
                                             <xsl:call-template name="format-query"/>
                                          </div>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                                 <!--<td class="right">
                                    <xsl:if test="$smode != 'showBag'">
                                       
                                       <a href="{$xtfURL}{$crossqueryPath}?{$modifyString}">
                                          <xsl:text>Modify Search</xsl:text>
                                       </a>
                                       <xsl:text>&#160;|&#160;</xsl:text>
                                    </xsl:if>
                                    <a href="{$xtfURL}{$crossqueryPath}?database={$brand}">
                                       <xsl:text>New Search</xsl:text>
                                    </a>
                                    <xsl:if test="$smode = 'showBag'">
                                       <xsl:text>&#160;|&#160;</xsl:text>
                                       <a href="{session:getData('queryURL')}">
                                          <xsl:text>Return to Search Results</xsl:text>
                                       </a>
                                    </xsl:if>
                                 </td>-->
                              </tr>
                              <xsl:if test="//spelling">
                                 <tr>
                                    <td>
                                       <xsl:call-template name="did-you-mean">
                                          <xsl:with-param name="baseURL" select="concat($xtfURL, $crossqueryPath, '?', $queryString)"/>
                                          <xsl:with-param name="spelling" select="//spelling"/>
                                       </xsl:call-template>
                                    </td>
                                    <td class="right">&#160;</td>
                                 </tr>
                              </xsl:if>
                              <tr>
                                 <td>
                                    <b><xsl:value-of select="if($smode='showBag') then 'My citations' else 'Results'"/>:</b>&#160; <xsl:variable
                                       name="items" select="@totalDocs"/>
                                    <xsl:choose>
                                       <xsl:when test="$items = 1">
                                          <span id="itemCount">1</span>
                                          <xsl:text> Item</xsl:text>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <span id="itemCount">
                                             <xsl:value-of select="$items"/>
                                          </span>
                                          <xsl:text> Items</xsl:text>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </td>
                                 <!--<td class="right">
                                    <strong>
                                       <xsl:text>Browse by </xsl:text>
                                    </strong>
                                    <xsl:call-template name="browseLinks"/>
                                 </td>-->
                              </tr>
                              <xsl:if test="docHit">
                                 <tr>
                                    <td>
                                       <form method="get" action="{$xtfURL}{$crossqueryPath}">
                                          <b>Sorted by:&#160;</b>
                                          <xsl:call-template name="sort.options"/>
                                          <xsl:call-template name="hidden.query">
                                             <xsl:with-param name="queryString" select="editURL:remove($queryString, 'sort')"/>
                                          </xsl:call-template>
                                          <xsl:text>&#160;</xsl:text>
                                          <input type="submit" value="Go!"/>
                                       </form>
                                    </td>
                                    <td class="right">
                                       <xsl:call-template name="pages"/>
                                    </td>
                                 </tr>
                              </xsl:if>
                           </table>
                        </div>
                     </div>
                     <!-- ( end tabs pane) -->
                     <div id="mid" class="clearfix">
                        <!-- results -->
                        <xsl:choose>
                           <xsl:when test="docHit">
                              <xsl:if test="not($smode='showBag')">
                                 <!-- start menu -->
                                 <div id="menu">
                                    <dl>
                                       <dt/>
                                       <dd>
                                          <!--   Don't display facet headings if there are no results.  RB.  SETIS.  4/08/10     -->
                                          <xsl:choose>
                                             <xsl:when test="facet[@field='facet-genre'][@totalDocs='0']"></xsl:when>
                                             <xsl:otherwise> <xsl:apply-templates select="facet[@field='facet-genre']"/></xsl:otherwise>
                                          </xsl:choose>
                                          <xsl:choose>
                                             <xsl:when test="//facet[@field='facet-subject'][@totalDocs='0']"></xsl:when>
                                             <xsl:otherwise><xsl:apply-templates select="facet[@field='facet-subject']"/></xsl:otherwise>
                                          </xsl:choose>
                                          <xsl:choose>
                                             <xsl:when test="//facet[@field='facet-collection'][@totalDocs='0']"></xsl:when>
                                             <xsl:otherwise><xsl:apply-templates select="facet[@field='facet-collection']"/></xsl:otherwise>
                                          </xsl:choose>
                                          <xsl:choose>
                                             <xsl:when test="//facet[@field='facet-date'][@totalDocs='0']"></xsl:when>
                                             <xsl:otherwise><xsl:apply-templates select="facet[@field='facet-date']"/></xsl:otherwise>
                                          </xsl:choose>
                                          <hr/>
                                       </dd>
                                    </dl>
                                 </div>
                              </xsl:if>
                              <div id="content" class="withtoutabs nofeature">
                                 <div id="w4">
                                    <!-- start content here-->
                                    <xsl:apply-templates select="docHit"/>
                                    <xsl:if test="@totalDocs > $docsPerPage">
                                       <xsl:call-template name="pages"/>
                                    </xsl:if>
                                 </div>
                              </div>
                           </xsl:when>
                           <xsl:otherwise>
                              <div id="content" class="withtoutabs nofeature">
                                 <div id="w4">
                                    <!-- start content here-->
                                    <div id="main_1" class="docHit">
                                       <table class="tabledata_blue2">
                                          <tbody>
                                             <tr>
                                                <td>
                                                   <xsl:choose>
                                                      <xsl:when test="$smode = 'showBag'">
                                                         <p>Your Citation list is empty.</p>
                                                         <p>Click on the 'Add' link next to one or more items in your <a
                                                            href="{session:getData('queryURL')}">Search Results</a>.</p>
                                                      </xsl:when>
                                                      <xsl:otherwise>
                                                         <p>Sorry, no results...</p>
                                                         <p>Try modifying your search:</p>
                                                         <div class="forms">
                                                            <xsl:choose>
                                                               <xsl:when test="matches($smode,'advanced')">
                                                                  <xsl:call-template name="advancedForm"/>
                                                               </xsl:when>
                                                               <xsl:otherwise>
                                                                  <xsl:call-template name="simpleForm"/>
                                                               </xsl:otherwise>
                                                            </xsl:choose>
                                                         </div>
                                                      </xsl:otherwise>
                                                   </xsl:choose>
                                                </td>
                                             </tr>
                                          </tbody>
                                       </table>
                                    </div>
                                 </div>
                              </div>
                           </xsl:otherwise>
                        </xsl:choose>
                     </div>
                     <!--   Footer     -->
                     <xsl:copy-of select="$brand.footer"/>
                  </div>
               </div>
            </div>
            <div style="display: none;" id="lbOverlay"/>
            <div style="display: none;" id="lbCenter">
               <div id="lbImage">
                  <div style="position: relative;"/>
               </div>
            </div>
            <div style="display: none;" id="lbBottomContainer">
               <div id="lbBottom">
                  <div style="clear: both;"/>
               </div>
            </div>
         </body>
      </html>
   </xsl:template>               

   <xsl:template name="setis-breadcrumb">
         <span class="prefix">You are here: </span>
         <a href="search?page=home">Australian Digital Collections</a>
         <xsl:if test="$brand">
         	<xsl:text> / </xsl:text>
         	<a href="search?database={$brand}&amp;page=home">
         		<xsl:value-of select="$brand.title"/>
         	</a>
         </xsl:if>
         <!--
         <xsl:choose>
            <xsl:when test="$brand = 'ozlit'"></xsl:when>
            <xsl:when test="$brand = 'acdp'">
               
               <a href="{$xtfURL}index.jsp?database=acdp&amp;page=home">The Australian Cooperative Digitisation Project</a>
            </xsl:when>
            <xsl:when test="$brand = 'ozfed'">
               <xsl:text> / </xsl:text>
               <a href="{$xtfURL}index.jsp?database=ozfed&amp;page=home">Australian Federation Full Text Database</a>
            </xsl:when>
            <xsl:when test="$brand = 'ozpoets'">
               <xsl:text> / </xsl:text>
               <a href="{$xtfURL}index.jsp?database=ozpoets&amp;page=home">Australian Poets. Brennan, Harford, Slessor</a>
            </xsl:when>
            <xsl:when test="$brand = 'ozlaw'">
               <xsl:text> / </xsl:text>
               <a href="{$xtfURL}index.jsp?database=ozlaw&amp;page=home">Classic Texts in Australian and International Taxation Law</a>
            </xsl:when>
            <xsl:when test="$brand = 'ozfleet'">
               <xsl:text> / </xsl:text>
               <a href="{$xtfURL}index.jsp?database=ozfleet&amp;page=home">First Fleet and Early Settlement</a>
            </xsl:when>
            <xsl:when test="$brand = 'anderson'">
               <xsl:text> / </xsl:text>
               <a href="{$xtfURL}index.jsp?database=anderson&amp;page=home">The John Anderson Archive</a>
            </xsl:when>
            <xsl:when test="$brand = 'maiden'">
               <xsl:text> / </xsl:text>
               <a href="{$xtfURL}index.jsp?database=maiden&amp;page=home">Joseph Henry Maiden Botanical Texts</a>
            </xsl:when>
            <xsl:when test="$brand = 'ozexplore'">
               <xsl:text> / </xsl:text>
               <a href="{$xtfURL}index.jsp?database=ozexplore&amp;page=home">Journals of Inland Exploration</a>
            </xsl:when>
            <xsl:otherwise>             
            </xsl:otherwise>
         </xsl:choose>
         -->
      
   </xsl:template>
   
   
   <!-- TODO the ozlit-header template is currently unused - remove it? -->
   <!-- ====================================================================== -->
   <!--   SETIS header.  RB, 07/07/10                                          -->
   <!-- ====================================================================== -->
   <xsl:template name="ozlit-header">
   <!-- TODO sort out what's the diff between $database (now replaced with $brand) and $collection? -->
   <!-- in the meantime; I am making them the same -->
   <xsl:variable name="collection" select="$brand"/>
      <div id="head">
         <div id="masthead">
            <a href="#content" class="skip-nav">Skip to main content</a>
            <h1>
               <a id="logo" href="http://sydney.edu.au/">The University of Sydney</a>
               <span id="separator">-</span>
               <span id="tag-line">
                  <xsl:value-of select="$brand.header"/>
               </span>
            </h1>
         </div>
         <!-- start global nav -->
         
         <!-- Following empty form needed to avoid javascript error 
         <form id="search" action="search/result">
            <input type="hidden" name="query" class="field" title="Enter search terms" value="Library"/>
            </form> -->
         
         
         <form id="search" action="search">
            <input type="hidden" name="page" value="home" />
            <!--            <label for="target" class="hide_text">Collections:</label>-->
            <select name="database">
               <option value="">Select a collection</option>
               <option value="acdp" label="The Australian Cooperative Digitisation Project">The Australian Cooperative Digitisation Project</option>
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
         
         
         
         <ul id="nav-global">
            <!-- use the "active" class to define an active item (highlighted text and nav indicator) -->
            <li class="active"><a href="{$xtfURL}">Home</a></li>
            <li><a href="http://sydney.edu.au/library/digital/">Digital Collections</a></li>
            <li><a href="http://escholarship.usyd.edu.au">Sydney eScholarship</a></li>
            <li><a href="http://sydney.edu.au/library">Library</a></li>
            <li><a href="http://sydney.edu.au/">University Home</a></li>
         </ul>
         <!-- end global nav -->
      </div>
<!--      <div id="tabbaroz">-->
         <div id="tabbar">   
         <!-- You add your tabbar items here if you want to there is an edited out example below -->
         <!-- 
            <ul id="tabs" class="horizontal">
            <li class="active"> <span><a href="/">ozlit</a></span> </li>
            </ul>
         -->
            
            
            <!--  RB. 08-02-11          -->
            <xsl:variable name="modify" select="if(matches($smode,'simple')) then 'simple-modify' else 'advanced-modify'"/>
            <xsl:variable name="modifyString" select="editURL:set($queryString, 'smode', $modify)"/>
            
            <ul id="tabs" class="horizontal">
               <xsl:if test="$smode = 'showBag'">
                  <li><span><a href="{session:getData('queryURL')}">Results</a></span></li>
               </xsl:if>
               
               <xsl:if test="$smode != 'showBag'">
                  <li><span><a href="{$xtfURL}{$crossqueryPath}?{$modifyString}">Modify Search</a></span></li>
               </xsl:if>
               
               <li><span><a href="{$xtfURL}search?database={$brand}"><span>Keyword search</span></a></span></li>
               <li><span><a href="{$xtfURL}search?smode=advanced&amp;database={$brand}"><span>Advanced search</span></a></span></li>
               <li><span><a href="{$xtfURL}search?database={$brand}&amp;collection={$collection}&amp;browse-all=yes&amp;sort=title"><span>Browse</span></a></span>
                  <ul>
                     <li><a href="{$xtfURL}search?database={$brand}&amp;collection={$collection}&amp;browse-creator=first&amp;sort=creator">Author</a></li>
                     <li><a href="{$xtfURL}search?database={$brand}&amp;collection={$collection}&amp;browse-title=first&amp;sort=title">Title</a></li>
                     <li><a href="{$xtfURL}search?database={$brand}&amp;collection={$collection}&amp;browse-all=yes&amp;sort=title">All</a></li>
                  </ul> 
               </li>
               <li><span><a href="{$xtfURL}index.jsp?database={$brand}&amp;collection={$collection}&amp;page=home"><span>Home</span></a></span></li>
               <li><span><a href="{$xtfURL}index.jsp?database=&amp;content=collections%2fozlit%2ftext%2fcontact.html"><span>Contact</span></a></span></li>
            </ul>
            
            
      </div>
      <br/>      
      
   </xsl:template>
   
</xsl:stylesheet>

