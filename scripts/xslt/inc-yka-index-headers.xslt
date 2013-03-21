<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">
      <!-- 
SILP Dictionary creator script
Written by Ian McQuay
Date: 2012-11-02

Template for classified word list as found in Yakan Dictionary
-->
      <xsl:param name="copyright" select="'2012 SIL Philippines'"/>
      <xsl:template name="htmltemplate">
            <xsl:param name="content"/>
            <xsl:param name="header2"/>
            <xsl:param name="header1"/>
            <xsl:param name="header3"/>
            <xsl:text disable-output-escaping="yes">
<![CDATA[<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">]]>
</xsl:text>
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
                        <title><xsl:value-of select="$langname" /> - <xsl:value-of select="lx" /></title>
                        <link rel="stylesheet" href="../common/silpdict.css" type="text/css"/>
                        <link rel="stylesheet" href="../common/labels.css" type="text/css"/>
                  </head>
                  <body>
                        <xsl:if test="$header1 != ''">
                              <h1>
                                    <xsl:value-of select="$header1"/>
                              </h1>
                        </xsl:if>
                        <xsl:if test="$header2 != ''">
                              <h2>
                                    <xsl:value-of select="$header2"/>
                              </h2>
                        </xsl:if>
                        <xsl:if test="$header3 != ''">
                              <h3>
                                    <xsl:value-of select="$header3"/>
                              </h3>
                        </xsl:if>
                        <table>
                              <xsl:apply-templates/>
                        </table>
                        <div class="recnavbot copyright">
                              <xsl:text>© </xsl:text>
                              <xsl:value-of select="$copyright"/>
                        </div>
                  </body>
            </html>
      </xsl:template>
</xsl:stylesheet>
