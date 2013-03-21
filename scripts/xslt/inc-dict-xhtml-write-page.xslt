<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">
      <xsl:variable name="copyright" select="'2013 SIL Philippines'"/>
      <!-- 
SILP Dictionary creator script
Written by Ian McQuay
Date: 2012-07-20

Updated 2012-08-15 added copyright line
Updated 2012-08-16 added time stamp UTC to metadata

-->
      <xsl:template name="writehtmlpage">
            <xsl:param name="filename"/>
            <xsl:param name="lxno" as="xs:double"/>
            <xsl:value-of select="$filename"/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="$groupsdivs//element[1]"/>
            <xsl:text>
</xsl:text>
            <xsl:result-document href="{$filename}" format="xhtml">
                  <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
                        <head>
                              <meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8"/>
                              <meta name="generator" content="PLB Dictionary Generator"/>
                              <xsl:element name="meta">
                                    <xsl:attribute name="name">
                                          <xsl:text>created</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="content">
                                          <xsl:value-of select="current-dateTime()"/>
                                    </xsl:attribute>
                              </xsl:element>
                              <title><xsl:value-of select="$labelname" /> - <xsl:value-of select="lx" /></title>
                              <link rel="stylesheet" href="../common/silpdict.css" type="text/css"/>
                              <link rel="stylesheet" href="../common/labels.css" type="text/css"/>
                              <script type="text/javascript">var _gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-20037946-13']); _gaq.push(['_trackPageview']);  (function() {var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();</script>
                        </head>
                        <body class="lx{format-number($lxno,'00000')}">
                              <div class="recnav">
                                    <xsl:call-template name="navigation">
                                          <xsl:with-param name="lxid" select="$lxno"/>
                                    </xsl:call-template>
                              </div>
                              <div class="{name(.)}">
                                    <xsl:apply-templates/>
                              </div>
                              <div class="recnavbot">
                                    <xsl:call-template name="navigation">
                                          <xsl:with-param name="lxid" select="$lxno"/>
                                    </xsl:call-template>
                                    <DIV class="copyright">
                                          <xsl:text>© </xsl:text>
                                          <xsl:value-of select="$copyright"/>
                                    </DIV>
                              </div>
                        </body>
                  </html>
            </xsl:result-document>
      </xsl:template>
</xsl:stylesheet>
