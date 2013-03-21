<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
      <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
      <xsl:strip-space elements="*"/>
      <xsl:param name="fieldlist"/>
      <xsl:variable name="fields">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$fieldlist"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:include href='inc-list2xml.xslt'/>
      <xsl:template match="/*">
            <data>
                  <xsl:for-each-group select="//*[local-name() = $fields/*/text()]" group-by="normalize-space(.)">
                        <xsl:sort select="."/>
                        <xsl:element name="field">
                              <xsl:attribute name="name">
                                    <xsl:value-of select="name()"/>
                              </xsl:attribute>
                              <xsl:attribute name="value">
                                    <xsl:value-of select="current-group()[1]"/>
                              </xsl:attribute>
                              <xsl:attribute name="count">
                                    <xsl:value-of select="count(current-group())"/>
                              </xsl:attribute>
                        </xsl:element>
                  </xsl:for-each-group>
            </data>
      </xsl:template>
</xsl:stylesheet>
