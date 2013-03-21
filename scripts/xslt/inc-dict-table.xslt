<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:silp="silp.org.ph/ns" exclude-result-prefixes="xs silp">
      <!-- Changed cell handling to include c1 c2 cell names. -->
      <xsl:template match="tb">
            <xsl:element name="table">
                  <xsl:attribute name="class">
                        <xsl:value-of select="concat('tb_',translate(tabletitle,$transfrom,$transto))"/>
                  </xsl:attribute>
                  <!-- <xsl:if test="lxGroup//tb[1]"> </xsl:if> -->
                  <xsl:attribute name="id">
                        <xsl:text>table</xsl:text>
                  </xsl:attribute>
                  <thead>
                        <caption class="tabletitle">
                              <xsl:apply-templates select="tabletitle"/>
                              <xsl:apply-templates select="tablesubtitle"/>
                        </caption>
                  </thead>
                  <tbody>
                        <xsl:apply-templates select="trow"/>
                  </tbody>
            </xsl:element>
      </xsl:template>
      <xsl:template match="c1|c2|c3|c4|c5|c6|c7|c8|c9|c10|td">
            <xsl:element name="td">
                  <xsl:attribute name="class">
                        <xsl:choose>
                              <xsl:when test="name() = 'td'">
                                    <xsl:value-of select="concat('c',(position() +1) div 2)"/>
                              </xsl:when>
                              <xsl:otherwise>
                                    <xsl:value-of select="name()"/>
                              </xsl:otherwise>
                        </xsl:choose>
                  </xsl:attribute>
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="trow">
            <xsl:element name="tr">
                  <xsl:attribute name="class">
                        <xsl:value-of select="concat('r',position())"/>
                  </xsl:attribute>
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="tablesubtitle">
            <br/>
            <xsl:element name="span">
                  <xsl:attribute name="class">
                        <xsl:value-of select="name()"/>
                  </xsl:attribute>
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="tabletitle">
            <br/>
            <xsl:apply-templates/>
      </xsl:template>
</xsl:stylesheet>
