<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:silp="silp.org.ph/ns" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="silp">
      <xsl:import href="inc-nav-none.xslt"/>
      <xsl:param name="copyright" select="'2012 SIL Philippines'"/>
      <xsl:param name="navtop"/>
      <xsl:param name="navbot"/>
      <xsl:param name="target"/>
      <xsl:template name="bodyhead">
            <xsl:param name="rec"/>
            <xsl:if test="$navtop != ''">
                  <xsl:call-template name="navigation">
                        <xsl:with-param name="rec" select="$rec"/>
                        <xsl:with-param name="class" select="'recnavtop'"/>
                  </xsl:call-template>
            </xsl:if>
      </xsl:template>
      <xsl:template name="bodytail">
            <xsl:param name="rec"/>
            <xsl:if test="$navbot != ''">
                  <xsl:call-template name="navigation">
                        <xsl:with-param name="rec" select="$rec"/>
                        <xsl:with-param name="class" select="'recnavbot'"/>
                  </xsl:call-template>
            </xsl:if>
      </xsl:template>
      <xsl:template name="copyright">
            <xsl:if test="$copyright != ''">
                  <div class="copyright">
                        <xsl:text>©</xsl:text>
                        <xsl:value-of select="$copyright"/>
                  </div>
            </xsl:if>
      </xsl:template>
</xsl:stylesheet>
