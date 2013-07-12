<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/" xmlns:cite="http://fake.org.au/ns/" version="2.0">
      <!-- Part of the SILP Dictionary Creator
Used to sort a xml dictionary indexes.
See Inculde below for essential other files.
Written by Ian McQuay
Created: 5/08/2012
Modified: 21/08/2012
Modified: 2013-07-09 IKM 

 -->
      <!-- made redundant by index-group-n-sort.xslt not hyphen not underscore. 2012-08-20 -->
      <xsl:output method="xml" indent="yes" encoding="utf-8" use-character-maps="silp"/>
      <xsl:param name="collationname"/>
      <xsl:variable name="default-collation" select="'http://saxon.sf.net/collation?lang=en-US;strength=primary'"/>
      <xsl:include href='dict-custom-collation.xslt'/>
      <xsl:include href="inc-lower-remove-accents.xslt"/>
      <xsl:include href='../../scripts/xslt/inc-char-map-silp.xslt'/>
      <xsl:template match="/*">
            <data>
                  <xsl:call-template name="removeaccentsfeedback"/>
                  <xsl:choose>
                        <xsl:when test="$collationname != ''">
                              <xsl:call-template name="customcollationfeedback"/>
                              <xsl:for-each-group select="record" group-by="cite:custom-first-letter(cite:translateaccents(ie))">
                                    <xsl:sort collation="http://saxon.sf.net/collation?rules={encode-for-uri($customcollation)}" select="cite:custom-first-letter(cite:translateaccents(ie))"/>
                                    <xsl:element name="alpha">
                                          <xsl:attribute name="key">
                                                <!-- <xsl:call-template name="letterkey"/> -->
                                                <xsl:value-of select="cite:custom-first-letter(cite:translateaccents(ie))"/>
                                          </xsl:attribute>
                                          <xsl:apply-templates select="current-group()">
                                                <xsl:sort collation="http://saxon.sf.net/collation?rules={encode-for-uri($customcollation)}" select="cite:translateaccents(ie)"/>
                                                <xsl:sort collation="{$default-collation}" select="cite:hom-number(ie)"/>
                                                <xsl:sort collation="http://saxon.sf.net/collation?rules={encode-for-uri($customcollation)}" select="cite:translateaccents(lx)"/>
                                          </xsl:apply-templates>
                                    </xsl:element>
                              </xsl:for-each-group>
                        </xsl:when>
                        <xsl:otherwise>
                              <xsl:call-template name="defaultcollationfeedback"/>
                              <xsl:for-each-group select="record" group-by="cite:translateaccents(cite:custom-first-letter(ie))">
                                    <xsl:sort select="cite:translateaccents(cite:custom-first-letter(ie))"/>
                                    <xsl:element name="alpha">
                                          <xsl:attribute name="key">
                                                <xsl:value-of select="cite:translateaccents(cite:custom-first-letter(ie))"/>
                                          </xsl:attribute>
                                          <xsl:apply-templates select="current-group()">
                                                <xsl:sort collation="{$default-collation}" select="cite:translateaccents(ie)"/>
                                                <xsl:sort collation="{$default-collation}" select="cite:hom-number(ie)"/>
                                                <xsl:sort collation="{$default-collation}" select="cite:translateaccents(lx)"/>
                                          </xsl:apply-templates>
                                    </xsl:element>
                              </xsl:for-each-group>
                        </xsl:otherwise>
                  </xsl:choose>
            </data>
      </xsl:template>
      <xsl:template match="*">
            <!--  <lower><xsl:value-of select="cite:lower-remove-accents(.)" /></lower> -->
            <xsl:element name="{name()}">
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
</xsl:stylesheet>
