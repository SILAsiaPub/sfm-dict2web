<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs">
      <!-- 
SILP Dictionary creator script
Written by Ian McQuay
Date: 2012-11-02

Extracted from inc-dict-write-html.xslt

-->
      <xsl:template name="writefile">
            <xsl:param name="tableref"/>
            <xsl:param name="content"/>
            <xsl:param name="header1"/>
            <xsl:param name="header2"/>
            <xsl:param name="header3"/>
            <xsl:param name="title"/>
            <xsl:param name="seqno" as="xs:double"/>
            <xsl:param name="rec"/>
            <xsl:variable name="filename" select="concat($path,$prefile,$rec,$posturl)"/>
            <xsl:value-of select="$filename"/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="$rec"/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="$seqno"/>
            <xsl:text>
</xsl:text>
            <xsl:result-document href="{$filename}" format="xhtml">
                  <xsl:call-template name="xhtml">
                        <xsl:with-param name="title" select="$title"/>
                        <xsl:with-param name="rec" select="$rec"/>
                  </xsl:call-template>
            </xsl:result-document>
      </xsl:template>
</xsl:stylesheet>
