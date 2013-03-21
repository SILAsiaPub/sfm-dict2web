<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:silp="silp.org.ph/ns" exclude-result-prefixes="xs silp" >
      <xsl:param name="last" as="xs:double" select="count(//lxGroup)"/>
       <xsl:template name="navigation">
            <xsl:param name="lxid" as="xs:double"/>
            <a href="lx00001.html">|&lt;&#160;First</a>
            <xsl:element name="a">
                  <xsl:attribute name="href">
                        <xsl:value-of select="$preurl"/>
                        <xsl:choose>
                              <xsl:when test="number($lxid) gt 1">
                                    <xsl:value-of select="format-number($lxid - 1,'00000')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                    <xsl:value-of select="format-number(1,'00000')"/>
                              </xsl:otherwise>
                        </xsl:choose>
                        <xsl:value-of select="$posturl"/>
                  </xsl:attribute>
                  <xsl:text>&lt;&#160;Previous</xsl:text>
            </xsl:element>
            <xsl:call-template name="next">
                  <xsl:with-param name="lxid" select="$lxid"/>
            </xsl:call-template>
            <xsl:call-template name="last">
            </xsl:call-template>
      </xsl:template>
      <xsl:template name="next">
            <xsl:param name="lxid" as="xs:double"/>
            <xsl:element name="a">
                  <xsl:attribute name="href">
                        <xsl:value-of select="$preurl"/>
                        <xsl:choose>
                              <xsl:when test="$lxid = $last">
                                    <xsl:value-of select="format-number( $last ,'00000')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                    <xsl:value-of select="format-number( $lxid  + 1 ,'00000')"/>
                              </xsl:otherwise>
                        </xsl:choose>
                        <xsl:value-of select="$posturl"/>
                  </xsl:attribute>
                  <xsl:text>Next&#160;&gt;</xsl:text>
            </xsl:element>
      </xsl:template>
      <xsl:template name="last">
            <xsl:element name="a">
                  <xsl:attribute name="href">
                        <xsl:value-of select="$preurl"/>
                        <xsl:value-of select="format-number( $last ,'00000')"/>
                        <xsl:value-of select="$posturl"/>
                  </xsl:attribute>
                  <xsl:text>Last&#160;&gt;|</xsl:text>
            </xsl:element>
      </xsl:template>
</xsl:stylesheet>