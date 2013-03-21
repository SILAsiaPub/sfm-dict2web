<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
      <!-- Part of the SILP Dictionary Creator
Used to create a checking file that has a sample of each field type.
Expected input is valid but unstructured xml. Flat file all elements ar siblings except the root element.
Issues: It is run on the unstructured flat file so sorting may mean that the links go to the wrong place.
For use with SIL Philippines SFM code converted to XML. 
(But may work with MDF sfm exported from Toolbox.)
Written by Ian McQuay
Created: 5/08/2012
Modified: 21/08/2012

 -->
      <xsl:output method="html" version="4.0" omit-xml-declaration="no" indent="yes"/>
      <xsl:template match="/*">
            <html>
                  <head>
                        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
                        <meta name="generator" content="SILP Dictionary Creator"/>
                        <title>Sample checking</title>
                  </head>
                  <body>
                        <div id="results">
                              <xsl:for-each-group select="*" group-by="name()">
                                    <xsl:sort select="name()"/>
                                    <xsl:call-template name="list">
                                          <xsl:with-param name="field" select="name()"/>
                                          <xsl:with-param name="lx" select="preceding-sibling::lx[1]"/>
                                          <xsl:with-param name="count" select="count(preceding-sibling::lx)"/>
                                          <xsl:with-param name="value">
                                                <xsl:choose>
                                                      <xsl:when test="contains(name(),'Group')">
                                                            <xsl:value-of select="*/*[1]"/>
                                                      </xsl:when>
                                                      <xsl:otherwise>
                                                            <xsl:value-of select=".[1]"/>
                                                      </xsl:otherwise>
                                                </xsl:choose>
                                          </xsl:with-param >
                                    </xsl:call-template>
                              </xsl:for-each-group>
                        </div>
                  </body>
            </html>
      </xsl:template>
      <xsl:template name="list">
            <xsl:param name="field"/>
            <xsl:param name="lx"/>
            <xsl:param name="count"/>
            <xsl:param name="value"/>
            <xsl:if test="$field != 'lx'">
                  <p>
                        <xsl:value-of select="$field"/>
                        <xsl:text>  </xsl:text>
                        <xsl:element name="a">
                              <xsl:attribute name="href">
                                    <xsl:text>../lexicon/lx</xsl:text>
                                    <xsl:number value="$count" format="00001"/>
                                    <xsl:text>.html</xsl:text>
                              </xsl:attribute>
                              <xsl:attribute name="target">
                                    <xsl:text>lexicon</xsl:text>
                              </xsl:attribute>
                              <xsl:value-of select="$lx"/>
                        </xsl:element>
                        <xsl:text>  Data: </xsl:text>
                        <xsl:if test="$field != 'tb'">
                              <xsl:value-of select="$value"/>
                        </xsl:if>
                  </p>
            </xsl:if>
      </xsl:template>
</xsl:stylesheet>
