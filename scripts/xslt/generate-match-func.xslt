<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>
      <xsl:param name="fieldlist"/>
      <xsl:variable name="fields">
            <xsl:call-template name="eleattb">
                  <xsl:with-param name="text" select="$fieldlist"/>
                  <xsl:with-param name="attbname" select="'html'"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:include href='inc-list2xml-1ele2attb.xslt'/>
      <xsl:template match="/*">
            <xsl:element name="xsl:stylesheet">
                  <xsl:attribute name="version">
                        <xsl:text>2.0</xsl:text>
                  </xsl:attribute>
                  <xsl:attribute name="silp" namespace="http://silp.org.ph/ns"/>
                  <xsl:element name="xsl:function">
                        <xsl:attribute name="name">
                              <xsl:text>silp:match</xsl:text>
                        </xsl:attribute>
                        <xsl:element name="xsl:choose">
                              <xsl:for-each select="$fields/item">
                                    <xsl:element name="xsl:when">
                                          <xsl:attribute name="test">
                                                <xsl:text>$test = '</xsl:text>
                                                <xsl:value-of select="text()"/>
                                                <xsl:text>'</xsl:text>
                                          </xsl:attribute>
                                          <xsl:element name="text">
                                                <xsl:value-of select="child::match"/>
                                          </xsl:element>
                                    </xsl:element>
                              </xsl:for-each>
                              <xsl:element name="xsl:otherwise">
                                    <xsl:text>div</xsl:text>
                              </xsl:element>
                        </xsl:element>
                  </xsl:element>
            </xsl:element>
      </xsl:template>
</xsl:stylesheet>
