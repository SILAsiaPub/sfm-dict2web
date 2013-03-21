<?xml version="1.0" encoding="windows-1250"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:character-map name="xul">
            <xsl:output-character character="&#38;" string='&amp;'/>
      </xsl:character-map>
      <xsl:param name="decchar2remove" select="'39 34 32'"/>
      <xsl:param name="amper" select="'39 34 32'"/>
      <xsl:variable name="entities">
            <xsl:analyze-string select="$decchar2remove" regex="\s+">
                  <xsl:matching-substring/>
                  <xsl:non-matching-substring>
                        <xsl:value-of select="concat('&#38;#',.,';')"/>
                  </xsl:non-matching-substring>
            </xsl:analyze-string>
      </xsl:variable>
</xsl:stylesheet>
