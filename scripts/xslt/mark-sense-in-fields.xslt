<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:output method="xml" indent="yes" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"/>
      <xsl:param name="findsenseinelementlist"/>
      <xsl:variable name="findsense">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$findsenseinelementlist"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:strip-space elements="*"/>
      <xsl:include href='inc-list2xml.xslt'/>
      <xsl:include href="inc-copy-anything.xslt"/>
      <xsl:template match="*[local-name() = $findsense/element/text()]">
            <xsl:copy>
                  <xsl:analyze-string select="." regex="(.+)\s(\d)$">
                        <xsl:matching-substring>
                              <xsl:value-of select="regex-group(1)"/>
                              <xsl:text> </xsl:text>
                              <sense>
                                    <xsl:value-of select="regex-group(2)"/>
                              </sense>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                              <xsl:value-of select="."/>
                        </xsl:non-matching-substring>
                  </xsl:analyze-string>
            </xsl:copy >
      </xsl:template>
</xsl:stylesheet>
