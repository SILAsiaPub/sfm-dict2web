<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">
      <!-- 
SILP Dictionary creator script
Written by Ian McQuay
Date: 2012-11-02
	
Extracted from inc-dict-html-css.xslt

-->
      <xsl:param name="foreachgroup"/>
      <xsl:param name="path"/>
      <xsl:param name="prefile" select="'/cwl'"/>
      <xsl:param name="posturl" select="'.html'"/>
      <xsl:template match="/*">
            <xsl:for-each select="//*[name() = $foreachgroup]">
                  <xsl:call-template name="writefile">
                        <xsl:with-param name="rec" select="preceding-sibling::*[1]/b"/>
                        <xsl:with-param name="seqno" as="xs:double" select="position()"/>
                        <xsl:with-param name="content" select="."/>
                        <xsl:with-param name="header1">
                              <xsl:value-of select="preceding-sibling::h[1]"/>
                        </xsl:with-param>
                        <xsl:with-param name="header2">
                              <xsl:if test="name(preceding-sibling::*[1]) != 'h' ">
                                    <xsl:value-of select="preceding-sibling::h2[1]"/>
                              </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="header3">
                              <xsl:if test="name(preceding-sibling::*[1]) = 'h3'">
                                    <xsl:value-of select="preceding-sibling::h3[1]"/>
                              </xsl:if>
                        </xsl:with-param>
                        <xsl:with-param name="title">
                              <xsl:value-of select="preceding-sibling::*[1]"/>
                        </xsl:with-param>
                  </xsl:call-template>
            </xsl:for-each>
      </xsl:template>
</xsl:stylesheet>
