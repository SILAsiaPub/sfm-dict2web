<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
      <xsl:output method="html" version="4.0" encoding="utf-8"/>
      
      <xsl:param name="field"/>
      <xsl:param name="idlink"/>
      <xsl:param name="showvalue" select="'yes'"/>
      <xsl:param name="css" select="'../common/silpdict.css'"/>
      <xsl:template match="/*">
            <html xmlns="http://www.w3.org/1999/xhtml">
                  <head>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                        <link rel="stylesheet" href="{$css}" type="text/css"/>
                  </head>
                  <body>
                        <div id="results"/>
                        <div class="list">
                              <xsl:apply-templates select="*[name() = $field]"/>
                        </div>
                  </body>
            </html>
      </xsl:template>
      <xsl:template match="*">
       
      </xsl:template>
      <xsl:template match="*[name() = $field]">
            <div class="row">
                  <span class="c1">
                        <xsl:element name="a">
                              <xsl:attribute name="href">
                                    <xsl:text>../lexicon/lx</xsl:text>
                                    <xsl:number value="@lxid" format="00001"/>
                                    <xsl:text>.html</xsl:text>
                                    <xsl:if test="$idlink ne ''">
                                          <xsl:value-of select="concat('#',$idlink)"/>
                                    </xsl:if>
                              </xsl:attribute>
                              <xsl:attribute name="target">
                                    <xsl:text>lexicon</xsl:text>
                              </xsl:attribute>
                              <xsl:value-of select="@lx"/>
                        </xsl:element>
                  </span>
                  <xsl:if test="lower-case($showvalue) = 'yes'">
                        <xsl:text> \</xsl:text>
                        <xsl:value-of select="$field"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="@value"/>
                  </xsl:if>
            </div>
      </xsl:template>
</xsl:stylesheet>
