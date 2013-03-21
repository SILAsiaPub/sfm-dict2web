<?xml version="1.0" encoding="windows-1250"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <!-- Part of the SILP Dictionary Creator
Used to generate css code from the limited set fields like \ps.

For use with SIL Philippines SFM code converted to XML. 

Written by Ian McQuay
Created: 5/08/2012
Modified: 21/08/2012

 -->
      <xsl:output method="text"/>
      <xsl:param name="position" select="'before'"/>
      <xsl:include href="inc-css-common-param.xslt"/>
      <xsl:template match="/*">
            <xsl:apply-templates select="*"/>
      </xsl:template>
      <xsl:template match="*">
            <xsl:text>.</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>_</xsl:text>
          <xsl:value-of select="translate(@value,$transfrom,$transto)"/>
            <xsl:text>:</xsl:text>
            <xsl:value-of select="$position"/>
            <xsl:text> { content: '</xsl:text>
            <xsl:if test="$position = 'after'">
                  <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:choose>
                  <xsl:when test="@display_word = ''">
                        <xsl:value-of select="@value"/>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:value-of select="@display_word"/>
                  </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$position = 'before'">
                  <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:text> ' ; font-size: 100% ;}
</xsl:text>
      </xsl:template>
</xsl:stylesheet>
