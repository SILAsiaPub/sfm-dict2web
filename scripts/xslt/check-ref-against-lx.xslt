<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" version="1.0" encoding="utf-8" indent="yes" />
<!--        -->
   <xsl:param name="lx">
    <xsl:for-each select="//lx">
      <xsl:element name="element">
        <xsl:value-of select="normalize-space(.)" />
      </xsl:element>
    </xsl:for-each>
</xsl:param>
 <!-- <xsl:param name="check">
      <xsl:analyze-string select="'ra re rf ro rs'" regex="\s">
        <xsl:matching-substring />
        <xsl:non-matching-substring>
          <xsl:element name="element">
            <xsl:value-of select="." />
          </xsl:element>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
  </xsl:param> -->

  <xsl:template match="/">
  <!--  <xsl:for-each select="//*[local-name() = $check/element]"> -->
     <xsl:for-each select="//ra|//re|//rf|//ro|//rs">

       <xsl:choose>

         <xsl:when test="$lx/* = normalize-space(.)">
<!--         <xsl:value-of select="preceding-sibling::lx[1]" />
          <xsl:text>  match \</xsl:text>
          <xsl:value-of select="local-name()" />
          <xsl:text>  </xsl:text>
          <xsl:value-of select="." /><xsl:text>
</xsl:text>
-->
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="preceding-sibling::lx[1]" />
          <xsl:text>  \</xsl:text>
          <xsl:value-of select="local-name()" />
          <xsl:text>  </xsl:text>
          <xsl:value-of select="." /><xsl:text>
</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
 </xsl:for-each>   
  </xsl:template>
</xsl:stylesheet>