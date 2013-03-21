<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
      <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>
      <xsl:template match="/*">
            <data type="">
                  <xsl:for-each-group select="//*" group-by="name()">
                        <xsl:sort select="string-length(name())" order="descending" />
<xsl:sort select="name()"/>
                        
                                    <xsl:element name="{name()}">
                                          <xsl:attribute name="count">
                                                <xsl:value-of select="count(current-group())"/>
                                          </xsl:attribute>
                                    </xsl:element>
                  </xsl:for-each-group>
            </data>
      </xsl:template>
</xsl:stylesheet>
