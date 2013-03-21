<?xml version="1.0" encoding="windows-1250"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:output method="xhtml" version="1.0" encoding="utf-8" indent="yes"/>
      <xsl:param name="level"/>
      <xsl:param name="ancestors"/>
      <xsl:param name="siblings"/>
      <xsl:param name="children"/>
      <xsl:variable name="ancestorslist">
            <xsl:call-template name="list2xmlele3value">
                  <xsl:with-param name="text" select="unparsed-text($ancestors)"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="siblingslist">
            <xsl:call-template name="list2xmlelevalue">
                  <xsl:with-param name="text" select="unparsed-text($siblings)"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="childrenlist">
            <xsl:call-template name="list2xmlelevalue">
                  <xsl:with-param name="text" select="unparsed-text($children)"/>
            </xsl:call-template>
      </xsl:variable>
                  <xsl:include href='inc-list2xml-elevalue.xslt'/>
      <xsl:template match="/*">
            
            <xsl:text disable-output-escaping="yes">
            &lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
            </xsl:text>
            <html xmlns="http://www.w3.org/1999/xhtml">
                  <head>
                        <meta http-equiv="Content-type" content="text/html" charset="utf-8"/>
                        <meta name="generator" content="Open Site Builder, http://opensb.sourceforge.net/"/>
                        <meta name="Description" lang="en-US" content=
    "SIL is a volunteer, non-profit organization that has worked in 
the Philippines since 1953. In cooperation with the Philippines Department of 
Education, SIL members carry out linguistic research and documentation of 
Philippine indigenous languages. As appropriate to the language community, SIL 
also promotes literacy, health, and community development projects among 
speakers of those languages, as well as translation of materials of high moral 
value into the vernacular."/>
                        <meta name="Keywords" lang="en-US" content=
    ", Philippines, SIL, Summer Institute of Linguistics, linguistics, language, research, library, literacy, indigenous, people groups, multinational, intercultural, book, essays, culture, world view, archive, publications"/>
                        <meta name="Updated-date" content="Oct, 2010"/>
                        <meta name="version" content="Version 1.1013"/>
                        <title>
                              <xsl:value-of select="title"/>
                        </title>
                        <link rel="stylesheet" href="../../../styles/silp.css" type="text/css"/>
                        <link rel="stylesheet" href="../ifk-gram.css" type="text/css"/>
                        <!-- <link rel="stylesheet" href="../src/styles/silp2.css" type="text/css"> -->
                        <style type="text/css">
/*<![CDATA[*/
    <!--
     <xsl:value-of select="css" />
    // -->
    /*]]>*/
    </style>
                        <script type="text/javascript">
                        var _gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-20037946-13']); _gaq.push(['_trackPageview']);  (function() {var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);  })();
                        </script>
                  </head>
                  <body>
                        <div class="page works-a-b">
                        <div class="logo bar">
                              
                        </div>
                        <div class="ptitle">
                              <h1>
                                    <a name="Top"></a>
                                    <a href="index.html">SIL Philippines</a>
                              </h1>
                              <h2>
         <xsl:value-of select="title"/>
        </h2>
                        </div>
                        <div class="contact">
                              <a target="_blank" href="http://www.sil.org" class="nav1">SIL International</a>
                              <a href="links.html" class="nav1">Links</a>
                              <a href="search.html" class="nav1">Search</a>
                              <a href="plb_contact.html" class="nav1">Contact Us</a>
                              <a href="site_map.html" class="nav1">Site Map</a>
                        </div>
                        <div class="picrib"></div>
                        <div class="picribbdr">
                              <p>
          Serving Language Communities through Linguistics, Literacy and Translation
        </p>
                        </div>
                        <div class="picribtrans"></div>
                        <div class="menu bar">
                              <a href="index.html" class="nav1">Home</a>
                              <xsl:for-each select="$ancestorslist/*">
                                                <a href="{local-name()}.html" class="nav{@level}">
                                                      <xsl:value-of select="."/>
                                                </a>
                              </xsl:for-each>
                              <xsl:for-each select="$siblingslist/*">
                                    <xsl:choose>
                                          <xsl:when test="local-name() = @pid">
                                                <div class="nav{$level">
                                                      <xsl:value-of select="."/>
                                                </div>
                                                <xsl:call-template name="children">
                                                  
                                                </xsl:call-template>
                                          </xsl:when>
                                          <xsl:otherwise>
                                                <a href="{local-name()}.html" class="nav{$level}">
                                                      <xsl:value-of select="."/>
                                                </a>
                                          </xsl:otherwise>
                                    </xsl:choose>
                              </xsl:for-each>                              

                              <a href="conditions_of_use.html" class="nav2">Conditions Of Use</a>
                              <div class="spacer">
                                    <br/>
                                    <br/>
                              </div>
                              <a href="plb_whats_new.html" class="nav1">What's New</a>
                              <a href="philippine_language_map.html" class="nav1">Philippines Language Map</a>
                              <a target="_blank" href="http://www.ethnologue.com/show_country.asp?name=PH" class="nav1">Ethnologue Philippines</a>
                        </div>
                        <div class="lower">
                              

<xsl:apply-templates select="div" />



                                    <div class="footer">
          <a class="returntop" href="#Top" title="Return to top">[ top ]</a>&#8195;&#169; SIL Philippines
        </div>
                              </div>
                        </div>
                  </body>
            </html>
      </xsl:template>
            <xsl:template match="@*|node()">
            <xsl:copy>
                  <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
      </xsl:template>
      <xsl:template name="children">
                              <xsl:for-each select="$childrenlist/*">
                                                <a href="{local-name()}.html" class="nav{$level + 1">
                                                      <xsl:value-of select="."/>
                                                </a>
                              </xsl:for-each>
      </xsl:template>
</xsl:stylesheet>
