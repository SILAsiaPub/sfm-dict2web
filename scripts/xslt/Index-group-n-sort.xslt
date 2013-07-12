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
<xsl:param name="digraphlist"/>
      <xsl:variable name="default-collation" select="'http://saxon.sf.net/collation?lang=en-US;strength=primary'"/>
      <xsl:include href='dict-custom-collation.xslt'/>
      <xsl:include href="inc-lower-remove-accents.xslt"/>
      <xsl:include href='../../scripts/xslt/inc-char-map-silp.xslt'/>
      <xsl:include href='inc-list2xml.xslt'/>
      <xsl:variable name="digraphs">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$digraphlist"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:template match="/*">
            <data>
                  <xsl:call-template name="removeaccentsfeedback"/>
                  <xsl:choose>
                        <xsl:when test="$collationname != ''">
                              <xsl:call-template name="customcollationfeedback"/>
                              <xsl:for-each-group select="record" group-by="substring(cite:no-space(cite:word-no-number(cite:lower-remove-accents(ie))),1,1)">
                                    <xsl:sort select="cite:lower-remove-accents-word(ie)" collation="http://saxon.sf.net/collation?rules={encode-for-uri($customcollation)}"/>
                                    <xsl:element name="alpha">
                                          <xsl:attribute name="key">
                                                <xsl:call-template name="letterkey"/>
                                                <!-- <xsl:sequence select="substring(cite:lower-remove-accents(ie),1,1)" /> -->
                                          </xsl:attribute>
                                          <xsl:apply-templates select="current-group()">
                                                <xsl:sort collation="http://saxon.sf.net/collation?rules={encode-for-uri($customcollation)}" select="cite:lower-remove-accents-word(ie)"/>
                                                <xsl:sort collation="{$default-collation}" select="cite:hom-number(ie)"/>
                                                <xsl:sort collation="http://saxon.sf.net/collation?rules={encode-for-uri($customcollation)}" select="cite:lower-remove-accents-word(lx)"/>
                                          </xsl:apply-templates>
                                    </xsl:element>
                              </xsl:for-each-group>
                        </xsl:when>
                        <xsl:otherwise>
                              <xsl:call-template name="defaultcollationfeedback"/>
                              <xsl:for-each-group select="record" group-by="substring(cite:no-space(cite:word-no-number(cite:lower-remove-accents(ie))),1,1)">
                                    <xsl:sort select="cite:lower-remove-accents-word(ie)"/>
                                    <xsl:element name="alpha">
                                          <xsl:attribute name="key">
                                                <xsl:call-template name="letterkey"/>
                                          </xsl:attribute>
                                          <xsl:apply-templates select="current-group()">
                                                <xsl:sort collation="{$default-collation}" select="cite:lower-remove-accents-word(ie)"/>
                                                <xsl:sort collation="{$default-collation}" select="cite:hom-number(ie)"/>
                                                <xsl:sort collation="{$default-collation}" select="cite:lower-remove-accents-word(lx)"/>
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
      <xsl:template name="letterkey">
            <!--<xsl:value-of select="substring(cite:word-no-number(cite:lower-remove-accents(ie)),1,1)"/>
 -->
            <xsl:choose>
                  <xsl:when test="substring(cite:word-no-number(cite:lower-remove-accents(ie)),1,2) = $digraphs/element/text()">
                        <xsl:value-of select="substring(cite:no-space(cite:word-no-number(cite:lower-remove-accents(ie))),1,2)"/>
                  </xsl:when>
                  <xsl:when test="substring(cite:word-no-number(cite:lower-remove-accents(ie)),1,1) = '+'">
                        <xsl:text>ng</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:value-of select="substring(cite:no-space(cite:word-no-number(cite:lower-remove-accents(ie))),1,1)"/>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:template>
      <xsl:template name="customcollationfeedback">
            <xsl:text disable-output-escaping="yes">
&lt;!-- custom sort 
          </xsl:text>
            <xsl:value-of select="$customcollation"/>
            <xsl:text disable-output-escaping="yes">
           --&gt;
</xsl:text>
      </xsl:template>
      <xsl:template name="defaultcollationfeedback">
            <xsl:text disable-output-escaping="yes">
&lt;!-- default sort 
          </xsl:text>
            <xsl:value-of select="$ac"/>
            <xsl:value-of select="$default-collation"/>
            <xsl:text disable-output-escaping="yes">
          --&gt;
          </xsl:text>
      </xsl:template>
      <xsl:template name="removeaccentsfeedback">
            <xsl:text disable-output-escaping="yes">
&lt;!-- remove accent visual feedback 
	   </xsl:text>
            <xsl:value-of select="$ac"/>
            <xsl:text>
Changed to
            </xsl:text>
            <xsl:value-of select="cite:lower-remove-accents($ac)"/>
            <xsl:text>
          </xsl:text>
            <xsl:text disable-output-escaping="yes">--&gt;
 </xsl:text>
      </xsl:template>
</xsl:stylesheet>
