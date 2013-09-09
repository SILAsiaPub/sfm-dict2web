<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:silp="silp.org.ph/ns" exclude-result-prefixes="xs silp">
      <!-- Changed cell handling to include c1 c2 cell names. -->
      <xsl:variable name="squote">
            <xsl:text>'</xsl:text>
      </xsl:variable>
      <xsl:template match="tb">
            <xsl:variable name="tbpos" select="count(preceding-sibling::tb) +1"/>
            <xsl:element name="table">
                  <xsl:attribute name="class">
                        <xsl:choose>
                              <xsl:when test="string-length(tabletitle) > 0">
                                    <xsl:value-of select="concat('tb_',translate(tabletitle,$transfrom,$transto))"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="concat('tb_',$tbpos,'_',preceding::lx[1])"/>
                              </xsl:when>
                              <xsl:when test="string-length(tablesubtitle) > 0">
                                    <xsl:value-of select="concat('tb_',translate(tablesubtitle,$transfrom,$transto))"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="concat('tb_',$tbpos,'_',preceding::lx[1])"/>
                              </xsl:when>
                              <xsl:otherwise>
                                    <xsl:value-of select="concat('tb_',$tbpos,'_',preceding::lx[1])"/>
                              </xsl:otherwise>
                        </xsl:choose>
                  </xsl:attribute>
                  <!-- <xsl:if test="lxGroup//tb[1]"> </xsl:if> -->
                  <xsl:attribute name="id">
                        <xsl:text>table</xsl:text>
                  </xsl:attribute>
                  <thead>
                        <xsl:apply-templates select="tabletitle"/>
                        <xsl:apply-templates select="tablesubtitle"/>
                  </thead>
                  <tbody>
                        <xsl:apply-templates select="trow|headrow"/>
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
                  <xsl:choose>
                        <xsl:when test="*">
                              <xsl:apply-templates/>
                        </xsl:when>
                        <xsl:otherwise>
                              <xsl:variable name="find" select="concat('^&#96;(.+)',$squote,'\s*$')"/>
                              <xsl:value-of select="replace(.,$find,'&#8216;$1&#8217;')"/>
                        </xsl:otherwise>
                  </xsl:choose>
            </xsl:element>
      </xsl:template>
      <xsl:template match="headrow">
            <xsl:element name="tr">
                  <xsl:attribute name="class">
                        <xsl:choose>
                              <xsl:when test="name() = 'th'">
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
      <xsl:template match="tablesubtitle|tabletitle">
            <caption>
                  <xsl:attribute name="class">
                        <xsl:value-of select="name()"/>
                  </xsl:attribute>
                  <xsl:apply-templates/>
            </caption>
      </xsl:template>
</xsl:stylesheet>
