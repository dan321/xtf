<!--Local customization file for "searchForms.xsl"-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:editURL="http://cdlib.org/xtf/editURL" 
                version="2.0">
   <xsl:import href="../../../../../style/crossQuery/resultFormatter/default/searchForms.xsl"/>

   <!--Any declarations in this file take precedence over those in the stylesheet imported above.-->
   <xsl:param name="http.URL"/>
   <!-- template below is copied and modified from SETIS-customised XTF 2 searchForms.xsl -->
   
   
   <xsl:param name="brand.search-examples" select="($brand.file//search-examples, $default-brand.file//search-examples)[1]/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
   <xsl:param name="brand.collection-title" select="if ($brand.file//title='') then '' else $brand.file//title" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
   
   <!-- main form page -->
   <xsl:template match="crossQueryResult" mode="form" exclude-result-prefixes="#all">
      <html xml:lang="eng" xmlns="http://www.w3.org/1999/xhtml" lang="eng">
         <head>
            <title>Australian Digital Collections </title>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <xsl:copy-of select="$brand.links"/>
         </head>
         <body>
         <div id="topheader" class="topheader"><div id="topheader" class="topheader"><ul><li><a href="http://www.library.usyd.edu.au/" title="Library">Library</a></li><li><a href="https://myuni.sydney.edu.au" title="My Uni">My Uni</a></li><li><a href="http://intranet.sydney.edu.au" title="Staff Intranet">Staff Intranet</a></li></ul></div></div>
            
            <div id="w1">
               <div id="w2">
                  <div id="w3">
                     <div id="head">
                        <div id="masthead">
                           <a href="#content" class="skip-nav">Skip to main content</a>
                           <h1>
                              <a id="logo" href="http://sydney.edu.au/">The University of Sydney</a>
                              <span id="separator">-</span>
                              <span id="tag-line"><xsl:value-of select="$brand.title"/></span>
                           </h1>
                        </div>
                        <!-- start global nav -->         
                        <xsl:call-template name="collection-selector"/>
                        
                        <ul id="nav-global">
                           <!-- use the "active" class to define an active item (highlighted text and nav indicator) -->
                           <li class="active"><a href="/">Home</a></li>
                           <li><a href="http://sydney.edu.au/library/digital/">Digital Collections</a></li>
                           <li><a href="http://escholarship.usyd.edu.au">Sydney eScholarship</a></li>
                           <li><a href="http://sydney.edu.au/library">Library</a></li>
                           <li><a href="http://sydney.edu.au/">University Home</a></li>
                        </ul>
                        <!-- end global nav -->
                     </div>
                     <div id="tabbar">
                        <ul id="tabs" class="horizontal">
                           <xsl:if test="matches($smode,'simple')">
                              <li class="active">
                                 <span>
                                    <a href="search?">
                                       <span>Keyword search</span>
                                    </a>
                                 </span>
                              </li>
                           </xsl:if>
                           <xsl:if test="not(matches($smode,'simple'))">
                              <li>
                                 <span>
                                    <a href="search?">
                                       <span>Keyword search</span>
                                    </a>
                                 </span>
                              </li>
                           </xsl:if>
                           <xsl:if test="matches($smode,'advanced')">
                              <li class="active">
                                 <span>
                                    <a href="search?smode=advanced">
                                       <span>Advanced search</span>
                                    </a>
                                 </span>
                              </li>
                           </xsl:if>
                           <xsl:if test="not(matches($smode,'advanced'))">
                              <li>
                                 <span>
                                    <a href="search?smode=advanced">
                                       <span>Advanced search</span>
                                    </a>
                                 </span>
                              </li>
                           </xsl:if>
                           <li>
                              <span>
                                 <a href="search?browse-all=yes&amp;sort=title">
                                    <span>Browse</span>
                                 </a>
                              </span>
                              <ul>
                                 <li>
                                    <a href="search?browse-creator=first&amp;sort=creator"> Author </a>
                                 </li>
                                 <li>
                                    <a href="search?browse-title=first&amp;sort=title"> Title </a>
                                 </li>
                                 <li>
                                    <a href="search?browse-all=yes&amp;sort=title"> All </a>
                                 </li>
                              </ul>
                           </li>
                           <li><span><a href="search?page=home"><span>Home</span></a></span></li>
                           <li><span><a href="search?page=contact"><span>Contact</span></a></span></li>
                        </ul>
                     </div>
                     <br/>
                     <div class="breadcrumb moved">
                     	<xsl:call-template name="setis-breadcrumb"/>
                     </div>
                     <!-- ( end tabs pane) -->
                     <div id="mid" class="clearfix">
                        <!-- when you add a side menu you will need to remove the nomenu class from the content id div -->
                        <div id="content" class="withtoutabs nofeature nomenu">
                           <!-- you can have different classes here, such as nomenu nofeeature withtabs, all within the class, what this does is change the 
                              dimension of the body dev, e.g. if nomenu it means the body div will start from extreme right and not leave a space for the left 
                              side menu -->
                           <div id="w4">
                              <!-- start content here-->
                              <xsl:choose>
                                 <xsl:when test="matches($smode,'simple')">
                                    <xsl:call-template name="simpleForm"/>
                                 </xsl:when>
                                 <xsl:when test="matches($smode,'advanced')">
                                    <xsl:call-template name="advancedForm"/>
                                 </xsl:when>
                              </xsl:choose>
                              <!-- End content here-->
                              <!-- start footer -->
                           </div>
                        </div>
                     </div>
                     <!--   Footer     -->
                     <xsl:copy-of select="$brand.footer"/>
                  </div>
               </div>
            </div>
            <!--   Included in Gaith's html         -->
            <div style="display: none;" id="lbOverlay"> </div>
            <div style="display: none;" id="lbCenter">
               <div id="lbImage">
                  <div style="position: relative;">
                     <a href="#" id="lbPrevLink"/>
                     <a href="#" id="lbNextLink"/>
                  </div>
               </div>
            </div>
            <div style="display: none;" id="lbBottomContainer">
               <div id="lbBottom">
                  <a href="#" id="lbCloseLink"/>
                  <div id="lbCaption"/>
                  <div id="lbNumber"/>
                  <div style="clear: both;"/>
               </div>
            </div>
            <!--   Above included in Gaith's html         -->
         </body>
      </html>
   </xsl:template>
   
   <xsl:template name="simpleForm" exclude-result-prefixes="#all">
      
      <form class="boxed noprint" method="get" action="{$crossqueryPath}">
         <input type="hidden" name="smode" value="simple"/>
         <!--   Inclusion of database parameter prevents return to default display.  RB.  SETIS.  09/03/10    -->
         <input type="hidden" name="collection" value='"{$brand.collection-title}"'/>
         <input type="text" name="keyword" size="50" value="{$keyword}"/>
         <!--   All searches will be confined to the required collection.  RB.  SETIS. 04/03/10    -->
         
         <xsl:text>&#160;</xsl:text>
         <input type="submit" class="button" value="Search"/>
         <!--   Inclusion of database parameter prevents return to default display.  RB.  SETIS.  09/03/10    -->
         <!--<input type="reset" onclick="location.href='{$crossqueryPath}" value="Clear"/>-->
         <input type="reset" onclick="location.href='{$crossqueryPath}'" class="button" value="Clear"/>
      </form>
      <xsl:copy-of select="$brand.search-examples"/>
   </xsl:template>
   
   <!-- advanced form -->
   <xsl:template name="advancedForm" exclude-result-prefixes="#all">
      <!-- For checking url parameters for making dropdowns sticky.  Relies on editURL namespace (see above) RB.  05/02/10     -->
      <xsl:variable name="urlParams" select="editURL:remove(replace($http.URL, '.+search\?|.+oai\?', ''),'startDoc')"/>

      <!--   RB SETIS. 05/03/10.  Database and collection parameters added.   -->
      <form class="boxed noprint" method="get" action="{$crossqueryPath}">
         <table class="tabledata_blue">
            <tbody>
               <tr>
                  <td valign="top">
                     <table class="tabledata_blue">
                        <tbody>
                           <tr>
                              <td colspan="2">
                                 <h4>Entire Text</h4>
                              </td>
                           </tr>
                           <tr>
                              <td colspan="2">
                                 <input name="text" size="30" type="text" value="{$text}"/>
                              </td>
                           </tr>
                           <tr>
                              <td colspan="2">
                                 <xsl:choose>
                                    <xsl:when test="$text-join = 'or'">
                                       <input type="radio" name="text-join" value=""/>
                                       <xsl:text> all of </xsl:text>
                                       <input type="radio" name="text-join" value="or" checked="checked"/>
                                       <xsl:text> any of </xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <input type="radio" name="text-join" value="" checked="checked"/>
                                       <xsl:text> all of </xsl:text>
                                       <input type="radio" name="text-join" value="or"/>
                                       <xsl:text> any of </xsl:text>
                                    </xsl:otherwise>
                                 </xsl:choose>
                                 <xsl:text>these words</xsl:text>
                              </td>
                           </tr>
                           <tr>
                              <th width="29%">
                                 <b>Exclude</b>
                              </th>
                              <td width="65%">
                                 <input type="text" name="text-exclude" size="20" value="{$text-exclude}"/>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Proximity</b>
                              </th>
                              <td>
                                 <select size="1" name="text-prox">
                                    <xsl:for-each select="('', '1', '2', '3', '4', '5', '10', '20')">
                                    	<option value="{.}">
                                    		<xsl:if test=". = $text-prox">
                                    			<xsl:attribute name="selected">selected</xsl:attribute>
                                    		</xsl:if>
                                    		<xsl:value-of select="."/>
                                    	</option>
                                    </xsl:for-each>
                                 </select>
                                 <xsl:text> word(s)</xsl:text>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Section</b>
                              </th>
                              <td>
                                 <xsl:choose>
                                    <xsl:when test="$sectionType = 'head'">
                                       <input type="radio" name="sectionType" value=""/>
                                       <xsl:text> any </xsl:text>
                                       <br/>
                                       <input type="radio" name="sectionType" value="head" checked="checked"/>
                                       <xsl:text> headings </xsl:text>
                                       <br/>
                                       <!-- <input type="radio" name="sectionType" value="citation"/><xsl:text> citations </xsl:text>-->
                                       <!-- <input type="radio" name="sectionType" value="firstline"/><xsl:text> first line of verse</xsl:text>-->
                                    </xsl:when>
                                    <!--<xsl:when test="$sectionType = 'note'"> 
                                       <input type="radio" name="sectionType" value=""/><xsl:text> any </xsl:text><br/>
                                       <input type="radio" name="sectionType" value="head"/><xsl:text> headings </xsl:text><br/>
                                       <input type="radio" name="sectionType" value="citation" checked="checked"/><xsl:text> citations </xsl:text><br/>
                                       <input type="radio" name="sectionType" value="firstline"/><xsl:text> first line of verse</xsl:text>
                                       </xsl:when>-->
                                    <!--   First line search.  SETIS. RB 18/02/10   -->
                                    <xsl:when test="$sectionType = 'firstLine'">
                                       <input type="radio" name="sectionType" value=""/>
                                       <xsl:text> any </xsl:text>
                                       <br/>
                                       <input type="radio" name="sectionType" value="head"/>
                                       <xsl:text> headings </xsl:text>
                                       <br/>
<!--                                         <input type="radio" name="sectionType" value="citation" /><xsl:text> citations </xsl:text><br/>-->
                                         <input type="radio" name="sectionType" value="firstline" checked="checked"/><xsl:text> first line of verse</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                       <input type="radio" name="sectionType" value="" checked="checked"/>
                                       <xsl:text> any </xsl:text>
                                       <br/>
                                       <input type="radio" name="sectionType" value="head"/>
                                       <xsl:text> headings </xsl:text>
                                       <br/>
<!--                                         <input type="radio" name="sectionType" value="citation"/><xsl:text> citations </xsl:text><br/>-->
                                         <input type="radio" name="sectionType" value="firstline"/><xsl:text> first line of verse</xsl:text>
                                    </xsl:otherwise>
                                 </xsl:choose>
                              </td>
                           </tr>
                        </tbody>
                     </table>
                  </td>
                  <td valign="top">
                     <table class="tabledata_blue">
                        <tbody>
                           <tr>
                              <td colspan="2">
                                 <h4>Metadata</h4>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Title</b>
                              </th>
                              <td>
                                 <input type="text" name="title" size="40" value="{$title}"/>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Author</b>
                              </th>
                              <td>
                                 <input type="text" name="creator" size="40" value="{$creator}"/>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Author gender</b>
                              </th>
                              <td>
                                 <select size="1" name="gender">
                                    <option value="">any</option>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'male')">
                                          <option value="male" selected="yes">male</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="male">male</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'female')">
                                          <option value="female" selected="yes">female</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="female">female</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </select>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Subject</b>
                              </th>
                              <td>
                                 <select size="1" name="subject">
                                    <option value="">any</option>
                                    <xsl:for-each select="('anthropology', 'botany', 'early settlement', 'exploration', 'federation', 'food', 'labour history', 'life sciences', 'mining', 'politics', 'religion', 'travel', 'university')">
                                    	<option value="{.}">
                                    		<xsl:if test="contains($urlParams, .)">
                                    			<xsl:attribute name="selected">selected</xsl:attribute>
                                    		</xsl:if>
                                    		<xsl:value-of select="."/>
                                    	</option>
                                    </xsl:for-each>
                                    <!--
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'anthropology')">
                                          <option value="anthropology" selected="yes">anthropology</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="anthropology">anthropology</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'botany')">
                                          <option value="botany" selected="yes">botany</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="botany">botany</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'early settlement')">
                                          <option value="early settlement" selected="yes">early settlement</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="early settlement">early settlement</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'exploration')">
                                          <option value="exploration" selected="yes">exploration</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="exploration">exploration</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'federation')">
                                          <option value="federation" selected="yes">federation</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="federation">federation</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'food')">
                                          <option value="food" selected="yes">food</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="food">food</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'labour history')">
                                          <option value="labour history" selected="yes">labour history</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="labour history">labour history</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'life sciences')">
                                          <option value="life sciences" selected="yes">life sciences</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="life sciences">life sciences</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'mining')">
                                          <option value="mining" selected="yes">mining</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="mining">mining</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'politics')">
                                          <option value="politics" selected="yes">politics</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="politics">politics</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'religion')">
                                          <option value="religion" selected="yes">religion</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="religion">religion</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'travel')">
                                          <option value="travel" selected="yes">travel</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="travel">travel</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'university')">
                                          <option value="university" selected="yes">university</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="university">university</option>
                                       </xsl:otherwise>
                                    </xsl:choose>                    
                                    -->
                                 </select>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Genre</b>
                              </th>
                              <td>
                                 <select size="1" name="genre">
                                    <option value="">any</option>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'biographies')">
                                          <option value="biographies" selected="yes">biographies</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="biographies">biographies</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'criticism')">
                                          <option value="criticism" selected="yes">criticism</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="criticism">criticism</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'debates')">
                                          <option value="debates" selected="yes">debates</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="debates">debates</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'diaries')">
                                          <option value="diaries" selected="yes">diaries</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="diaries">diaries</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'dictionaries')">
                                          <option value="dictionaries" selected="yes">dictionaries</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="dictionaries">dictionaries</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'drama')">
                                          <option value="drama" selected="yes">drama</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="drama">drama</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'essays')">
                                          <option value="essays" selected="yes">essays</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="essays">essays</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'letters')">
                                          <option value="letters" selected="yes">letters</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="letters">letters</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'literature for children')">
                                          <option value="literature for children" selected="yes">literature for children</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="literature for children">literature for children</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'novels')">
                                          <option value="novels" selected="yes">novels</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="novels">novels</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'short stories')">
                                          <option value="short stories" selected="yes">short stories</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="short stories">short stories</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'verse')">
                                          <option value="verse" selected="yes">verse</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="verse">verse</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                 </select>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Collection</b>
                              </th>
                              <td>
                                 <select size="1" name="collection">
                                    <option value="">any</option>
                                    <xsl:for-each select="(
                                    	'The Australian Cooperative Digitisation Project', 
                                    	'Australian Federation Full Text Database', 
                                    	'Australian Poets. Brennan, Harford, Slessor',
                                    	'Classic Texts in Australian and International Taxation Law',
                                    	'First Fleet and Early Settlement',
                                    	'Joseph Henry Maiden Botanical Texts',
                                    	'Journals of Inland Exploration',
                                    	'The John Anderson Archive'
                                    )">
                                    	<option value='"{.}"'>
                                    		<xsl:if test="$brand.collection-title = .">
                                    			<xsl:attribute name="selected">selected</xsl:attribute>
                                    		</xsl:if>
                                    		<xsl:value-of select="."/>
                                    	</option>
                                    </xsl:for-each>
                                    <!--
                                 </select>
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'Australian Cooperative Digitisation Project')">
                                          <option value="The Australian Cooperative Digitisation Project" selected="yes">The Australian Cooperative Digitisation Project</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="The Australian Cooperative Digitisation Project">The Australian Cooperative Digitisation Project</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'Australian Federation Full Text Database')">
                                          <option value="" selected="yes">Australian Federation Full Text Database</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="Australian Federation Full Text Database">Australian Federation Full Text Database</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'Australian Poets')">
                                          <option value="Australian Poets. Brennan, Harford, Slessor" selected="yes">Australian Poets. Brennan, Harford, Slessor</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="Australian Poets. Brennan, Harford, Slessor">Australian Poets. Brennan, Harford, Slessor</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'Classic Texts in Australian and International Taxation Law')">
                                          <option value="Classic Texts in Australian Taxation Law" selected="yes">Classic Texts in Australian and International Taxation Law</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="Classic Texts in Australian Taxation Law">Classic Texts in Australian and International Taxation Law</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'First Fleet and Early Settlement')">
                                          <option value="First Fleet and Early Settlement" selected="yes">First Fleet and Early Settlement</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="First Fleet and Early Settlement">First Fleet and Early Settlement</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'Joseph Henry Maiden Botanical Texts')">
                                          <option value="Joseph Henry Maiden Botanical Texts" selected="yes">Joseph Henry Maiden Botanical Texts</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="Joseph Henry Maiden Botanical Texts">Joseph Henry Maiden Botanical Texts</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    
                                    <xsl:choose>
                                       <xsl:when test="contains($urlParams,'Journals of Inland Exploration')">
                                          <option value="Journals of Inland Exploration" selected="yes">Journals of Inland Exploration</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="Journals of Inland Exploration">Journals of Inland Exploration</option>
                                       </xsl:otherwise>
                                    </xsl:choose>
                                    
                                    <xsl:choose>                                 
                                       <xsl:when test="contains($urlParams,'The John Anderson Archive')">
                                          <option value="The John Anderson Archive" selected="yes">The John Anderson Archive</option>
                                       </xsl:when>
                                       <xsl:otherwise>
                                          <option value="The John Anderson Archive">The John Anderson Archive</option>
                                       </xsl:otherwise>
                                    </xsl:choose>-->
                                 </select>
                              </td>
                           </tr>
                           <tr>
                              <th>
                                 <b>Year(s)</b>
                              </th>
                              <td>
                                 <xsl:text>From </xsl:text>
                                 <input type="text" name="year" size="4" value="{$year}"/>
                                 <xsl:text> to </xsl:text>
                                 <input type="text" name="year-max" size="4" value="{$year-max}"/>
                              </td>
                           </tr>
                           <tr>
                              <td/>
                              <td>
                                 <input name="smode" value="advanced" type="hidden"/>
                                 <input class="button" value="Search" type="submit"/>
                                 <xsl:text>&#x20;</xsl:text>
                                 <input class="button" onclick="location.href='/search?smode=advanced'"
                                    value="Clear" type="reset"/>
                              </td>
                           </tr>
                        </tbody>
                     </table>
                  </td>
               </tr>
            </tbody>
         </table>
      </form>
   </xsl:template>

   <!-- free-form form -->
   <xsl:template name="freeformForm" exclude-result-prefixes="#all">
      <form method="get" action="{$crossqueryPath}">
         <table>
            <tr>
               <td>
                  <p><i>Experimental feature:</i> "Freeform" complex query supporting -/NOT, |/OR, &amp;/AND, field names, and parentheses.</p>
                  <input type="text" name="freeformQuery" size="40" value="{$freeformQuery}"/>
                  <xsl:text>&#160;</xsl:text>
                  <input type="submit" value="Search"/>
                  <input type="reset" onclick="location.href='{$crossqueryPath}'" value="Clear"/>
               </td>
            </tr>
            <tr>
               <td>
                  <table class="sampleTable">
                     <tr>
                        <td colspan="2">Examples:</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">africa</td>
                        <td class="sampleDescrip">Search keywords (full text and metadata) for 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south africa</td>
                        <td class="sampleDescrip">Search keywords for 'south' AND 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south &amp; africa</td>
                        <td class="sampleDescrip">(same)</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south AND africa</td>
                        <td class="sampleDescrip">(same; note 'AND' must be capitalized)</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">title:south africa</td>
                        <td class="sampleDescrip">Search title for 'south' AND 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">creator:moodley title:africa</td>
                        <td class="sampleDescrip">Search creator for 'moodley' AND title for 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south | africa</td>
                        <td class="sampleDescrip">Search keywords for 'south' OR 'africa'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south OR africa</td>
                        <td class="sampleDescrip">(same; note 'OR' must be capitalized)</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">africa -south</td>
                        <td class="sampleDescrip">Search keywords for 'africa' not near 'south'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">africa NOT south</td>
                        <td class="sampleDescrip">(same; note 'NOT' must be capitalized)</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">title:africa -south</td>
                        <td class="sampleDescrip">Search title for 'africa' not near 'south'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">title:africa subject:-politics</td>
                        <td class="sampleDescrip"> Search items with 'africa' in title but not 'politics' in subject. Note '-' must follow ':' </td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">title:-south</td>
                        <td class="sampleDescrip">Match all items without 'south' in title</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">-africa</td>
                        <td class="sampleDescrip">Match all items without 'africa' in keywords</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south (africa OR america)</td>
                        <td class="sampleDescrip">Search keywords for 'south' AND either 'africa' OR 'america'</td>
                     </tr>
                     <tr>
                        <td class="sampleQuery">south africa OR america</td>
                        <td class="sampleDescrip">(same, due to precedence)</td>
                     </tr>
                  </table>
               </td>
            </tr>
         </table>
      </form>
   </xsl:template>   
</xsl:stylesheet>

