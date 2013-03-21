<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" />
    <xsl:template match="co|ec|gl|ie|tr">
        <xsl:value-of select="text()" />
        <xsl:text></xsl:text>
    </xsl:template>
    <xsl:template match="/*">
        <xsl:apply-templates select="co|ec|gl|ie|tr"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="*" />
</xsl:stylesheet>