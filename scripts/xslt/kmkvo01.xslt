<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:template match="/*">
 <body>
 <xsl:apply-templates/></body>
</xsl:template>
<xsl:template match="c">
 <h2>
 <xsl:apply-templates/>
 </h2>
</xsl:template>
<xsl:template match="om|os">
<xsl:element name="div">
  <xsl:attribute name="class">
   <xsl:value-of select="local-name()" />
  </xsl:attribute>
  <xsl:apply-templates/>
</xsl:element>
</xsl:template>
<xsl:template match="o|e|t|k">
<xsl:element name="td">
  <xsl:attribute name="class">
   <xsl:value-of select="local-name()" />
  </xsl:attribute>
  <xsl:apply-templates/>
</xsl:element>
</xsl:template>
<xsl:template match="oGroup">
 <table>  <tr>
 <xsl:apply-templates/>
 </tr>
 </table>
</xsl:template>
</xsl:stylesheet>