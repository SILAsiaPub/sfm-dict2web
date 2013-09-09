<?xml version="1.0"?>
<!--
    #############################################################
    # Name:		check-field-to-checklist.xslt
    # Purpose:	Creates a checking html to check each entry of a particular type.
    # Part of:	sfm-dict2web - http://projects.palaso.org/projects/sfm-dict2web
    # Author:	Ian McQuay <ian_mcquay.org>
    # Created:	2013/08/22
    # Copyright:	(c) 2013 SIL International
    # Licence:	<LPGL>
    ################################################################
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
      <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>
      <xsl:param name="field"/>
      <xsl:param name="idlink"/>
      <xsl:param name="showvalue" select="'yes'"/>
      <xsl:param name="css" select="'../common/silpdict.css'"/>
      <xsl:template match="/*">
            <html xmlns="http://www.w3.org/1999/xhtml">
                  <head>
                        <meta name="generator" content="vimod-pub/iso-sorted-to-checklist.xslt"/>
                        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                        <link rel="stylesheet" href="{$css}" type="text/css"/>
                  </head>
                  <body>
<div class="masterlink">
<a href="index.html"></a>
</div>
                        <div id="results"/>
                        <div class="list">
                              <xsl:apply-templates select="*"/>
                        </div>
                  </body>
            </html>
      </xsl:template>
      <xsl:template match="lxGroup">
            <xsl:apply-templates select="*[name() = $field]">
                  <xsl:with-param name="lxpos" select="position()"/>
            </xsl:apply-templates>
      </xsl:template>
      <xsl:template match="*"/>
      <xsl:template match="*[name() = $field]">
            <xsl:param name="lxpos"/>
            <div class="row">
                  <span class="c1">
                        <xsl:element name="a">
                              <xsl:attribute name="href">
                                    <xsl:text>../lexicon/lx</xsl:text>
                                    <xsl:number value="$lxpos" format="00001"/>
                                    <xsl:text>.html</xsl:text>
                                    <xsl:if test="$idlink ne ''">
                                          <xsl:value-of select="concat('#',$field)"/>
                                    </xsl:if>
                              </xsl:attribute>
                              <xsl:attribute name="target">
                                    <xsl:text>lexicon</xsl:text>
                              </xsl:attribute>
                              <xsl:value-of select="preceding::lx[1]"/>
                        </xsl:element>
                  </span>
                  <xsl:if test="lower-case($showvalue) = 'yes'">
                        <xsl:text> \</xsl:text>
                        <xsl:value-of select="$field"/>
                        <xsl:text> </xsl:text>
                  </xsl:if>
            </div>
      </xsl:template>
</xsl:stylesheet>
