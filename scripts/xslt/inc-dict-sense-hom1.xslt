<xsl:stylesheet version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:silp="silp.org.ph/ns" exclude-result-prefixes="xs silp">
      <xsl:param name="spacebeforehom"/>
      <xsl:variable name="em1" select="m1-"/>
      <xsl:variable name="em2" select="m2-"/>
      <xsl:variable name="em3" select="m3-"/>
      <xsl:variable name="em4" select="m4-"/>
      <xsl:variable name="em5" select="nonumb-"/>
      <xsl:template name="senseorhom">
            <xsl:param name="string"/>
            <xsl:choose>
                  <xsl:when test="matches($string,'\d$')">
                        <!-- determenis if string ends in a number -->
<xsl:text>TM1</xsl:text>
                        <xsl:call-template name="test2homandsense">
                              <!-- string does end in a number, test more -->
                              <xsl:with-param name="string" select="$string"/>
                        </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise><xsl:text>T1</xsl:text>
                        <!-- string does not end in a number, return string -->
                        <xsl:value-of select="$string"/>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>
      <xsl:template name="test2homandsense">
            <xsl:param name="string"/>
            <xsl:choose>
                  <xsl:when test="matches($string,'\d\s\d$')"><xsl:text>TM2</xsl:text>
                        <!-- determenis if string ends in a number space number sequence-->
                        <xsl:call-template name="test3hassenseandhom">
                              <!-- send to sense and hom handling -->
                              <xsl:with-param name="string" select="$string"/>
                        </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise><xsl:text>T2</xsl:text>
                        <xsl:call-template name="test4hashomorsense">
                              <!-- could have sense and hom, so check which to handle for -->
                              <xsl:with-param name="string" select="$string"/>
                        </xsl:call-template>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>
      <xsl:template name="test3hassenseandhom">
            <xsl:param name="string"/>
            <xsl:variable name="len" select="string-length($string)"/>
            <xsl:variable name="word" select="substring($string,1,$len - 3)"/>
            <xsl:variable name="wordshort" select="substring($string,1,$len - 4)"/>
            <xsl:variable name="homnumb" select="substring($string,$len - 2,1)"/>
            <xsl:variable name="sensenumb" select="substring($string,$len,1)"/>
            <xsl:choose>
                  <xsl:when test="matches($string,'\s\d\s\d$')"><xsl:text>TM3</xsl:text>
                        <!-- check if space before hom number -->
                        <xsl:call-template name="hom">
                              <xsl:with-param name="string" select="concat($em1,$wordshort,$homnumb)"/>
                        </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                        <!-- attached hom number --><xsl:text>T3</xsl:text>
                        <xsl:call-template name="hom">
                              <xsl:with-param name="string" select="concat($em1,$word,$homnumb)"/>
                        </xsl:call-template>
                  </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="sense">
                  <xsl:with-param name="sense" select="$sensenumb"/>
            </xsl:call-template>
      </xsl:template>
      <xsl:template name="test4hashomorsense">
            <xsl:param name="string"/>
            <xsl:variable name="len" select="string-length($string)"/>
            <xsl:variable name="word" select="substring($string,1,$len - 3)"/>
            <xsl:variable name="wordshort" select="substring($string,1,$len - 4)"/>
            <xsl:variable name="homnumb" select="substring($string,$len - 2,1)"/>
            <xsl:variable name="sensenumb" select="substring($string,$len,1)"/>
            <xsl:choose>
                  <xsl:when test="matches($string,'\s\d$')"><xsl:text>TM4</xsl:text>
                        <xsl:call-template name="test5homorsenseafterspace">
                              <xsl:with-param name="string" select="$string"/>
                        </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise><xsl:text>T4</xsl:text>
<xsl:value-of select="concat($em3,$word)"/><xsl:text> </xsl:text>
                        <xsl:call-template name="sense">
                              <xsl:with-param name="sense" select="$sensenumb"/>
                        </xsl:call-template>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>
      <xsl:template name="test5homorsenseafterspace">

            <xsl:param name="string"/>
            <xsl:variable name="len" select="string-length($string)"/>
            <xsl:variable name="word" select="substring($string,1,$len - 2)"/>
            <xsl:variable name="lastnumb" select="substring($string,$len,1)"/>
            <xsl:choose>
                  <xsl:when test="$spacebeforehom = 'true'"><xsl:text>TM5</xsl:text>
                        <!-- check if space before hom number param is set -->
                        <xsl:call-template name="hom">
                              <!-- when space before hom number param is set, remove space -->
                              <xsl:with-param name="string" select="concat($em3,$word,$lastnumb)"/>
                        </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise><xsl:text>T5</xsl:text>
                        <!-- when no space before hom number param is set, process as word and sense -->
                        <xsl:value-of select="concat($em3,$word)"/>
                        <xsl:text> </xsl:text>
                        <xsl:call-template name="sense">
                              <xsl:with-param name="sense" select="$lastnumb"/>
                        </xsl:call-template>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>
      <xsl:template name="sense">
            <xsl:param name="sense"/>
            <xsl:element name="span">
                  <xsl:attribute name="class">
                        <xsl:text>sense</xsl:text>
                  </xsl:attribute>
                  <xsl:value-of select="$sense"/>
            </xsl:element>
      </xsl:template>
      <xsl:template name="hom">
            <xsl:param name="string"/>
            <xsl:variable name="len" select="string-length($string)"/>
            <xsl:variable name="word" select="substring($string,1,$len - 1)"/>
            <xsl:variable name="homnumb" select="substring($string,$len,1)"/>
            <xsl:choose>
                  <xsl:when test="matches($string,'\d$')">
                        <xsl:value-of select="$word"/>
                        <span class="sub">
                              <xsl:value-of select="$homnumb"/>
                        </span>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:value-of select="$string"/>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>
</xsl:stylesheet>
