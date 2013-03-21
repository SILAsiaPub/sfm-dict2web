<?xml version="1.0" encoding="windows-1250"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes" />

<xsl:include href='inc-list2xml-2elevalue.xslt' />
<xsl:param name="sourcetexturi"/>
<xsl:param name="root"/>
<xsl:param name="rootclass"/>



 <xsl:template match="/*">
<xsl:element name="{$root}">
<xsl:if test="$rootclass != ''">
 <xsl:attribute name="class">
<xsl:value-of select="$rootclass" />
</xsl:attribute>
</xsl:if>
              <xsl:call-template name="textlist2xml">
                  <xsl:with-param name="text" select="unparsed-text($sourcetexturi)"/>
            </xsl:call-template>
</xsl:element>
 </xsl:template>
</xsl:stylesheet>
