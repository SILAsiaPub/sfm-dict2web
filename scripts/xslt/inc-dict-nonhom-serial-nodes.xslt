<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
      <xsl:template match="*[local-name() = $serialnodes//element/text()">
            <!-- like sens hom but can't use that as it has numbers. But needs the last class added -->
            <xsl:element name="span">
                  <xsl:attribute name="class">
                        <xsl:value-of select="name()"/>
                        <xsl:if test="position() + 1 = last()">
                              <xsl:text> last</xsl:text>
                        </xsl:if>
                  </xsl:attribute>
                  <xsl:choose>
                        <xsl:when test="child::link">
                              <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                              <xsl:apply-templates/>
                        </xsl:otherwise>
                  </xsl:choose>
            </xsl:element>
      </xsl:template>
</xsl:stylesheet>