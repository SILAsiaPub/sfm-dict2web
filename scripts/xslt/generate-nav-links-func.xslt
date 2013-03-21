<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gen="dummy-namespace-for-the-generated-xslt" xmlns:silp="http://silp.org.ph/ns" exclude-result-prefixes="xsl">
      <xsl:output method="xml" indent="yes"/>
      <xsl:namespace-alias stylesheet-prefix="gen" result-prefix="xsl"/>
      <xsl:template match="/*">
            <gen:stylesheet version="2.0" xmlns:silp="http://silp.org.ph/ns">
                  <gen:function name="silp:first">
                        <gen:param name="test"/>
                        <gen:text>
                              <xsl:text>cwl</xsl:text>
                              <xsl:value-of select="/data/*[1]"/>
                              <xsl:text>.html</xsl:text>
                        </gen:text>
                  </gen:function>
                  <gen:function name="silp:last">
                        <gen:param name="test"/>
                        <xsl:text>cwl</xsl:text>
                        <xsl:value-of select="/data/rec[last()]"/>
                        <xsl:text>.html</xsl:text>
                  </gen:function>
                  <gen:function name="silp:prev">
                        <gen:param name="test"/>
                        <gen:choose>
                              <!-- Generate the structure of the XSL stylesheet -->
                              <xsl:for-each select="rec">
                                    <gen:when test="$test = '{text()}'">
                                          <gen:text>
                                                <xsl:choose>
                                                      <xsl:when test="name(preceding-sibling::*[1]) = 'rec'">
                                                            <xsl:text>cwl</xsl:text>
                                                            <xsl:value-of select="preceding-sibling::*[1]"/>
                                                            <xsl:text>.html</xsl:text>
                                                      </xsl:when>
                                                      <xsl:otherwise>
                                                            <xsl:text>cwl</xsl:text>
                                                            <xsl:value-of select="self::*"/>
                                                            <xsl:text>.html</xsl:text>
                                                      </xsl:otherwise>
                                                </xsl:choose>
                                          </gen:text>
                                    </gen:when>
                              </xsl:for-each>
                              <!-- put the logic for the generated XSLT here -->
                        </gen:choose>
                  </gen:function>
                  <gen:function name="silp:next">
                        <gen:param name="test"/>
                        <gen:choose>
                              <!-- Generate the structure of the XSL stylesheet -->
                              <xsl:for-each select="rec">
                                    <gen:when test="$test = '{text()}'">
                                          <gen:text>
                                                <xsl:choose>
                                                      <xsl:when test="name(following-sibling::*[1]) = 'rec'">
                                                            <xsl:text>cwl</xsl:text>
                                                            <xsl:value-of select="following-sibling::rec[1]"/>
                                                            <xsl:text>.html</xsl:text>
                                                      </xsl:when>
                                                      <xsl:otherwise>
                                                            <xsl:text>cwl</xsl:text>
                                                            <xsl:value-of select="self::*"/>
                                                            <xsl:text>.html</xsl:text>
                                                      </xsl:otherwise>
                                                </xsl:choose>
                                          </gen:text>
                                    </gen:when>
                              </xsl:for-each>
                              <!-- put the logic for the generated XSLT here
                              <gen:otherwise>div</gen:otherwise> -->
                        </gen:choose>
                  </gen:function>
            </gen:stylesheet>
      </xsl:template>
</xsl:stylesheet>
