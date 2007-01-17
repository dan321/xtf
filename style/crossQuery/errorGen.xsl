<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- Error page generation stylesheet                                       -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<!--
   Copyright (c) 2005, Regents of the University of California
   All rights reserved.
 
   Redistribution and use in source and binary forms, with or without 
   modification, are permitted provided that the following conditions are 
   met:

   - Redistributions of source code must retain the above copyright notice, 
     this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright 
     notice, this list of conditions and the following disclaimer in the 
     documentation and/or other materials provided with the distribution.
   - Neither the name of the University of California nor the names of its
     contributors may be used to endorse or promote products derived from 
     this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
   POSSIBILITY OF SUCH DAMAGE.
-->

<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:dc="http://purl.org/dc/elements/1.1/">

<xsl:output method="html"
            indent="yes"
            encoding="utf-8"
            media-type="text/html"
            doctype-public="-//W3C//DTD HTML 4.0//EN"/>

<!-- =====================================================================
    
    When an error occurs (either authorization or an internal error),
    a stylesheet is used to produce a nicely formatted page for the
    requester. This tag specifies the path to the stylesheet, relative
    to the servlet base directory.

    The stylesheet receives one of the following mini-documents as input:

        <UnsupporedQuery>
          <message>error message</message>
        </UnsupportedQuery>

    or

        <QueryFormat>
            <message>error message</message>
        </QueryFormat>
        
    or

        <TermLimit>
            <message>error message</message>
        </TermLimit>

    or

        <ExcessiveWork>
            <message>error message</message>
        </ExcessiveWork>

    or

        <some general exception>
            <message>a descriptive error message (if any)</message>
            <stackTrace>HTML-formatted Java stack trace</stackTrace>
        </some general exception>

    For convenience, all of this information is also made available in XSLT
    parameters:

        $exception    Name of the exception that occurred - "TermLimit",
                      "QueryFormat", or other names.

        $message      More descriptive details about what occurred

        $stackTrace   JAVA stack trace for non-standard exceptions.

======================================================================= -->


<!-- ====================================================================== -->
<!-- Parameters                                                             -->
<!-- ====================================================================== -->

<xsl:param name="exception"/>
<xsl:param name="message"/>
<xsl:param name="stackTrace" select="''"/>
<xsl:param name="http.URL"/>

<!-- ====================================================================== -->
<!-- Root Template                                                          -->
<!-- ====================================================================== -->

<!-- ======================================================================
    For this sample error generation stylesheet, we use the input mini-
    document instead of the parameters.
-->

<xsl:variable name="reason">
  <xsl:choose>
    <xsl:when test="//QueryFormat">
      <xsl:text>crossQuery Error: Query Format</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>crossQuery Error: Servlet Error</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

   <xsl:template match="/">
      
      <xsl:choose>
         <xsl:when test="matches(string(QueryFormat/message),'^OAI::')">
            <xsl:call-template name="oaiError">
               <xsl:with-param name="message" select="replace(string(QueryFormat/message),'^OAI::','')"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <html>
               <head>
                  <title><xsl:value-of select="$reason"/></title>
                  <link type="text/css" rel="stylesheet" href="css/default/content.css"/>
               </head>
               
               <body>
                  
                  <div class="content">
                     <xsl:choose>
                        <xsl:when test="QueryFormat 
                           or TermLimit
                           or ExcessiveWork
                           or UnsupportedQuery">
                           <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:for-each select="*">
                              <xsl:call-template name="GeneralError"/>
                           </xsl:for-each>
                        </xsl:otherwise>
                     </xsl:choose>
                     
                  </div>
                  
               </body>
            </html>
         </xsl:otherwise>
      </xsl:choose>
      
   </xsl:template>


<!-- For a UnsupportedQuery exception, the message is irrelevant. -->
<xsl:template match="UnsupportedQuery">
    <h1>Unsupported Query</h1>
    <p>Queries cannot be performed on content that isn't pre-indexed
    (for instance from a URL.)</p>
    <xsl:apply-templates/>
</xsl:template>


<!-- For a QueryFormat exception, the message is relevant. -->
<xsl:template match="QueryFormat">
  <h1>Query format error</h1>
  <p>Your query was not understood.</p>
  <xsl:apply-templates/>
</xsl:template>


<!-- For a TermLimit exception, the message contains the first 50 matches. -->
<xsl:template match="TermLimit">
    <h1>Term limit exceeded</h1>
    <p>Your query matched too many terms. Try using a smaller range, 
       eliminating wildcards, or making them more specific.</p>
    <xsl:apply-templates/>
</xsl:template>


<!-- For a ExcessiveWork exception, the message is not relevant. -->
<xsl:template match="ExcessiveWork">
    <h1>Vague Query</h1>
    <p>Your query was too vague and produced only low-quality matches.
       Try making it more specific.</p>
</xsl:template>


<!-- For all other exceptions, output all the information we can. -->
<xsl:template name="GeneralError">
  <h1>Servlet Error: <xsl:value-of select="name()"/></h1>
  <h3>An unexpected servlet error has occurred.</h3>
  <xsl:apply-templates/>
  <p>If you have questions, need further technical assistance, or believe that you have reached this page in error, send email to the CDL (<a href="mailto:cdl@www.cdlib.org?subject=Access denied - {$reason}">cdl@www.cdlib.org</a>) or call the CDL Helpline (510.987.0555). Be sure to include the above message and/or stack trace in your communication.</p>
</xsl:template>


<!-- If a message was passed in, format it. -->
<xsl:template match="message">
  <p><b>Message:</b><br/><br/><span style="font-family: Courier"><xsl:apply-templates/></span></p>
</xsl:template>


<!-- If stack trace was specified, format it. Note that it already contains internal <br/> tags to separate lines. -->
<xsl:template match="stackTrace">
  <p><b>Stack Trace:</b><br/><br/><xsl:apply-templates/></p>
</xsl:template>


<!-- Pass <br> tags through untouched. -->
<xsl:template match="br">
    <br/>
</xsl:template>
   
   <!-- OAI Error Template -->
   
<xsl:template name="oaiError">
   
   <xsl:param name="message"/>
   <xsl:variable name="responseDate" select="FileUtils:curDateTime('yyyy-MM-dd:HH:mm:ss')" xmlns:FileUtils="java:org.cdlib.xtf.xslt.FileUtils"/>
   <xsl:variable name="request" select="$http.URL"/>
   <xsl:variable name="verb" select="replace($message,'(.+)::.+::.+','$1')"/>
   <xsl:variable name="code" select="replace($message,'.+::(.+)::.+','$1')"/>
   <xsl:variable name="messageText" select="replace($message,'.+::.+::(.+)','$1')"/>
   
   <xsl:result-document method="xml" encoding="UTF-8" exclude-result-prefixes="#all">
      <OAI-PMH xmlns="http://www.openarchives.org/OAI/2.0/" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd">
         <responseDate><xsl:value-of select="replace(string($responseDate),'\n','')"/></responseDate>
         <request verb="{$verb}"><xsl:value-of select="$request"/></request>
         <error code="{$code}"><xsl:value-of select="$messageText"/></error>
      </OAI-PMH>
   </xsl:result-document>
   
</xsl:template>


</xsl:stylesheet>

