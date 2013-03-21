<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <!--
Simple SFM to XML importer
This imports a sfm text and converts to a flat xml file.
It can import inline sfm codes. like \bd bold words\bd* without change.
Illegal element characters are removed.
Fields with line separated data can be excluded from normalisation

usage:
java  -jar "saxon9.jar"   -o "output.xml" "sfm2xml.xslt" "sfm2xml.xslt" sourcetexturi="file:///fullpath/source.sfm" donotnormalise="tb dd"

Written by Ian McQuay
Created 2013-01-30

-->
      <xsl:output method="xml" version="1.0" encoding="utf-8" omit-xml-declaration="yes" indent="yes"/>
      <xsl:param name="sourcetexturi"/>
      <xsl:param name="donotnormalise"/>
      <xsl:param name="unwantedchar" select="'\_'"/>
      <xsl:variable name="notnormalise">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$donotnormalise"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:template match="/">
            <xsl:element name="database">
                  <xsl:analyze-string select="replace(unparsed-text($sourcetexturi),'(\r)',' $1')" regex="\n\\">
                        <!-- split on backslash, add a space to the end of every line so every empty sfm can be found -->
                        <xsl:matching-substring/>
                        <xsl:non-matching-substring>
                              <xsl:element name="{translate(substring-before(.,' '),$unwantedchar,'')}">
                                    <!-- create element with sfm marker as element name -->
                                    <xsl:choose>
                                          <xsl:when test="substring-before(.,' ') = $notnormalise/element">
                                                <xsl:value-of select="substring-after(.,' ')"/>
                                                <!-- Output data following space after sfm marker  but not normalised-->
                                          </xsl:when>
                                          <xsl:otherwise>
                                                <xsl:value-of select="normalize-space(substring-after(.,' '))"/>
                                                <!-- Output data following space after sfm marker, normalized -->
                                          </xsl:otherwise>
                                    </xsl:choose>
                              </xsl:element>
                        </xsl:non-matching-substring>
                  </xsl:analyze-string>
            </xsl:element>
      </xsl:template>
      <xsl:template name="list2xml">
            <xsl:param name="text"/>
            <xsl:analyze-string select="$text" regex="\s+">
                  <xsl:matching-substring/>
                  <xsl:non-matching-substring>
                        <xsl:element name="element">
                              <xsl:value-of select="."/>
                        </xsl:element>
                  </xsl:non-matching-substring>
            </xsl:analyze-string>
      </xsl:template>
</xsl:stylesheet>
