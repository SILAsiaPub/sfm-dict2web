<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
      <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
      <xsl:param name="sourcetextstring"/>
      <xsl:variable name="list">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$sourcetextstring"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:include href='inc-list2xml.xslt'/>
      <xsl:template match="/*">
            <xsl:element name="data">
                  <xsl:attribute name="field1">
                        <xsl:value-of select="$sourcetextstring"/>
                  </xsl:attribute>
                  <xsl:apply-templates select="lxGroup"/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="lxGroup">
            <xsl:call-template name="ieTemplate">
                  <xsl:with-param name="lxGroup" select="."/>
                  <xsl:with-param name="counter" select="position()"/>
            </xsl:call-template>
      </xsl:template>
      <xsl:template name="line">
            <xsl:param name="ie"/>
            <xsl:param name="lx"/>
            <xsl:param name="count"/>
            <xsl:if test="$ie ne ''">
                    <record>
                        <ie>
                              <xsl:value-of select="normalize-space($ie)"/>
                        </ie>
                        <lx>
                              <xsl:value-of select="normalize-space($lx)"/>
                        </lx>
                        <counter>
                              <xsl:value-of select="$count"/>
                        </counter>
                  </record>
            </xsl:if>
      </xsl:template>
      <xsl:template name="ieTemplate">
            <xsl:param name="lxGroup"/>
            <xsl:param name="counter"/>
            <xsl:for-each select="$lxGroup//*[name()=$list//*/text()]">
                  <xsl:call-template name="line">
                        <xsl:with-param name="ie" select="."/>
                        <xsl:with-param name="lx" select="$lxGroup/lx"/>
                        <xsl:with-param name="count" select="$counter"/>
                  </xsl:call-template>
            </xsl:for-each>
      </xsl:template>
</xsl:stylesheet>
