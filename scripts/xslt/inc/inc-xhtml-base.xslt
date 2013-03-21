<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:param name="usenamed"/>
      <xsl:param name="css"/>
      <xsl:param name="css2"/>
      <xsl:param name="divclass"/>
      <xsl:template name="xhtml">
            <xsl:param name="title"/>
            <xsl:param name="rec"/>
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
                        <title>
                              <xsl:value-of select="$title"/>
                        </title>
                        <xsl:if test="$css != ''">
                              <link rel="stylesheet" href="{$css}" type="text/css"/>
                        </xsl:if>
                        <xsl:if test="$css2 != ''">
                              <link rel="stylesheet" href="{$css2}" type="text/css"/>
                        </xsl:if>
                  </head>
                  <body>
                        <xsl:call-template name="bodyhead">
                              <xsl:with-param name="rec" select="$rec"/>
                        </xsl:call-template>
                        <div class="{$divclass}">
                              <xsl:choose>
                                    <xsl:when test="$usenamed = ''">
                                          <xsl:apply-templates/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                          <xsl:call-template name="content"/>
                                    </xsl:otherwise>
                              </xsl:choose>
                        </div>
                        <xsl:call-template name="bodytail">
                              <xsl:with-param name="rec" select="$rec"/>
                        </xsl:call-template>
                        <xsl:call-template name="copyright"/>
                  </body>
            </html>
      </xsl:template>
</xsl:stylesheet>
