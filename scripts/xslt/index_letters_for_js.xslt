<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
      <xsl:output method="text" omit-xml-declaration="yes" use-character-maps="silp"/>
      <xsl:param name="spacedlist"/>
      <xsl:variable name="control">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$spacedlist"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:include href='inc-list2xml.xslt'/>
      <xsl:include href='../../scripts/xslt/inc-char-map-silp.xslt'/>
      <!-- <xsl:include href='../../scripts/xslt/inc-control-list-spaced.xslt'/> -->
      <xsl:template match="/data">
            <xsl:text>// JavaScript Document 

</xsl:text>
            <xsl:for-each select="$cotrol//element">
                  <xsl:call-template name="jsbuild">
                        <xsl:with-param name="curlang" select="current()"/>
                  </xsl:call-template>
            </xsl:for-each>
      </xsl:template>
      <xsl:template match="alphagroup|alpha">
            <xsl:param name="curlang"/>
            <xsl:text>'&lt;a target="index" href="../index/</xsl:text>
            <xsl:value-of select="$curlang"/>
            <xsl:number value="position()" format="01"/>
            <xsl:text>.html" &gt;</xsl:text>
            <xsl:value-of select="@*"/>
            <xsl:choose>
                  <xsl:when test="position() eq last()">
                        <xsl:text>&lt;/a&gt;' &#59;</xsl:text>
                  </xsl:when>
                  <xsl:when test="@key eq 'n'">
                        <xsl:text>&lt;/a&gt; ' +</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:text>&lt;/a&gt;&amp;nbsp&#59;' +</xsl:text>
                  </xsl:otherwise>
            </xsl:choose>
            <xsl:text>
</xsl:text>
      </xsl:template>
      <xsl:template name="jsbuild">
            <xsl:param name="curlang"/>
            <xsl:text>

var </xsl:text>
            <xsl:value-of select="$curlang"/>
            <xsl:text>_alpha = </xsl:text>
            <xsl:apply-templates select="alphagroup|alpha">
                  <xsl:with-param name="curlang" select="$curlang"/>
            </xsl:apply-templates>
      </xsl:template>
</xsl:stylesheet>
