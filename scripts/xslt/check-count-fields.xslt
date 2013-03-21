<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
      <!-- Part of the SILP Dictionary Creator
Used to count fields and also some elements in the fields, for the compiler to check.
Expected input is valid but unstructured xml. Flat file all elements ar siblings except the root element.
For use with SIL Philippines SFM code converted to XML. 
(But may work with MDF sfm exported from Toolbox.)
Written by Ian McQuay
Created: 5/08/2012
Modified: 21/08/2012

 -->
      <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>
      <xsl:template match="/*">
            <data type="">
                  <xsl:for-each-group select="*" group-by="name()">
                        <xsl:sort select="name()"/>
                        <xsl:choose>
                              <xsl:when test="string-length(local-name()) > 3">
                                    <xsl:element name="{name()}">
                                          <xsl:attribute name="count">
                                                <xsl:value-of select="count(current-group())"/>
                                          </xsl:attribute>
                                    </xsl:element>
                              </xsl:when>
                              <xsl:when test="name() = 'database'"/>
                              <xsl:otherwise>
                                    <xsl:element name="{name()}">
                                          <xsl:attribute name="count">
                                                <xsl:value-of select="count(current-group())"/>
                                          </xsl:attribute>
                                          <xsl:if test="count(current-group()[. = '']) gt 0">
                                                <xsl:attribute name="empty">
                                                      <xsl:value-of select="count(current-group()[. = ''])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,'|')]) gt 0">
                                                <xsl:attribute name="barcodes">
                                                      <xsl:value-of select="count(current-group()[contains(.,'|')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,' +')]) gt 0">
                                                <xsl:attribute name="pluscodes">
                                                      <xsl:value-of select="count(current-group()[contains(.,' +')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,' _')]) gt 0">
                                                <xsl:attribute name="underscore">
                                                      <xsl:value-of select="count(current-group()[contains(.,' _')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,' *')]) gt 0">
                                                <xsl:attribute name="indexmark">
                                                      <xsl:value-of select="count(current-group()[contains(.,' *')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,';')]) gt 0">
                                                <xsl:attribute name="semicolon">
                                                      <xsl:value-of select="count(current-group()[contains(.,'; ')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,',')]) gt 0">
                                                <xsl:attribute name="comma">
                                                      <xsl:value-of select="count(current-group()[contains(.,',')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,&quot;'&quot;)]) gt 0">
                                                <xsl:attribute name="squot">
                                                      <xsl:value-of select="count(current-group()[contains(.,&quot;'&quot;)])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,'&quot;')]) gt 0">
                                                <xsl:attribute name="quot">
                                                      <xsl:value-of select="count(current-group()[contains(.,'&quot;')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,'(')]) gt 0">
                                                <xsl:attribute name="lpar">
                                                      <xsl:value-of select="count(current-group()[contains(.,'(')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[contains(.,'[')]) gt 0">
                                                <xsl:attribute name="lsquar">
                                                      <xsl:value-of select="count(current-group()[contains(.,'[')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[matches(.,'\d$')])">
                                                <xsl:attribute name="endnumb">
                                                      <xsl:value-of select="count(current-group()[matches(.,'\d$')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[matches(.,'\s\d$')])">
                                                <xsl:attribute name="spacenumb">
                                                      <xsl:value-of select="count(current-group()[matches(.,'\s\d$')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                          <xsl:if test="count(current-group()[matches(.,'\d\s\d$')])">
                                                <xsl:attribute name="numbspacenumb">
                                                      <xsl:value-of select="count(current-group()[matches(.,'\d\s\d$')])"/>
                                                </xsl:attribute>
                                          </xsl:if>
                                    </xsl:element>
                              </xsl:otherwise>
                        </xsl:choose>
                  </xsl:for-each-group>
            </data>
      </xsl:template>
</xsl:stylesheet>
