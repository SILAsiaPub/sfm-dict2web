<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:saxon="http://saxon.sf.net/">
  <xsl:output method="text" omit-xml-declaration="yes" />
  <xsl:param name="reporttype"/>
  <xsl:template match="/*">
    <xsl:for-each select="*">
      <xsl:choose>
        <xsl:when test="$reporttype = 'fieldcount'">
          <xsl:value-of select="name()" />
          <xsl:text>	</xsl:text>
          <xsl:value-of select="@count" />
          <xsl:text>
</xsl:text>
        </xsl:when>
        <xsl:when test="$reporttype = 'fieldlist'">
          <xsl:value-of select="name()" />
          <xsl:text>
</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="name()" />
          <xsl:text>	</xsl:text>
          <xsl:value-of select="@count" />
          <xsl:text>	</xsl:text>
          <xsl:value-of select="name()" />
          <xsl:text>	</xsl:text>
          <xsl:value-of select="@value" />
          <xsl:text>	</xsl:text>
          <xsl:value-of select="@lx" />
          <xsl:text>	</xsl:text>
          <xsl:value-of select="@display_word" />           <xsl:text>
</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>