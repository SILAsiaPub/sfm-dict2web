<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
      <xsl:output method="text" name="text" omit-xml-declaration="yes"/>
      <xsl:variable name="data" select="."/>
      <xsl:param name="basepath"/>
      <xsl:param name="sourcelist"/>
      <xsl:param name="namelink"/>
      <xsl:variable name="sources">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$sourcelist"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:param name="targetlist"/>
      <xsl:variable name="targets">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$targetlist"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:include href='inc-list2xml.xslt'/>
      <xsl:template match="/">
            <xsl:for-each select="$sources//element">
                  <xsl:variable name="filename" select="concat($basepath,'/scripts/cct/link-',.,'.cct')"/>
                  <xsl:value-of select="$filename"/>
                  <xsl:text>
</xsl:text>
                  <xsl:result-document href="{$filename}" format="text">
                        <xsl:call-template name="cct">
                              <xsl:with-param name="sourcefield" select="."/>
                        </xsl:call-template>
                  </xsl:result-document>
            </xsl:for-each>
      </xsl:template>
      <xsl:template name="cct">
            <xsl:param name="sourcefield"/>
            <xsl:text>c Replace individual words with hyperlinks in certain xml fields
c tool to aid automatic processing of SIL Philippines schema sfm dictionaries
c written by Ian McQuay 2011-05-19
c created automatically:</xsl:text>
            <xsl:value-of select="current-dateTime()"/>
            <xsl:text>
 
begin	&gt;	  store(bound) ' ;,.&lt;&gt;()' d51  
		store(amacron) u0100 u0101
		store(aacute) u00E1 u00C1
		store(a) 'Aa'
		store(b) 'Bb'
		store(c) 'Cc'
		store(d) 'Dd'
		store(emacron) u0112 u0113
		store(ecircum) u00CA u00EA
		store(eacute) u00C9 u00E9
		store(e) 'Ee'
		store(g) 'Gg'
		store(h) 'Hh'
		store(i) 'Ii'
		store(imacron) u012A u012B
		store(j) 'Jj'
		store(k) 'Kk'
		store(l) 'Ll'
		store(m) 'Mm'
		store(eng) u014A u014B
		store(n) 'Nn'
		store(omacron) u014C u014D
		store(o) 'Oo'
		store(p) 'Pp'
		store(r) 'Rr'
		store(s) 'Ss'
		store(t) 'Tt'
		store(umacron) u016A u016B
		store(u) 'Uu'
		store(w) 'Ww'
		store(y) 'Yy'
		store(dash) '-'

		store(star) '*'
		
			endstore use(main)
 
group(main)
</xsl:text>
            <xsl:apply-templates select="$targets//element" mode="main"/>
            <xsl:text>

group(skip)
')'	&gt;	dup use(insert)

group(skipfield)
'&gt;'	>	dup use(insert)

group(insert)
'('	&gt;	dup use(skip)  c skip bracketed words
'&lt;ch'	>	dup use(skipfield)
'&lt;li'	>	dup use(skipfield)
</xsl:text>
            <xsl:apply-templates select="$targets//element" mode="insert"/>
            <xsl:for-each select="$data//lxGroup">
                  <xsl:call-template name="template">
                        <xsl:with-param name="lxGroup" select="."/>
                        <xsl:with-param name="sourcefield" select="$sourcefield"/>
                        <xsl:with-param name="counter" select="position()"/>
                  </xsl:call-template>
            </xsl:for-each>
      </xsl:template>
      <xsl:template match="lxGroup">
            <xsl:call-template name="template">
                  <xsl:with-param name="lxGroup" select="$data//lxGroup"/>
                  <xsl:with-param name="counter" select="position()"/>
            </xsl:call-template>
      </xsl:template>
      <xsl:template name="template">
            <xsl:param name="sourcefield"/>
            <xsl:param name="lxGroup"/>
            <xsl:param name="counter"/>
            <xsl:variable name="apos">
                  <xsl:text>'</xsl:text>
            </xsl:variable>
            <xsl:variable name="dquote">
                  <xsl:text>"</xsl:text>
            </xsl:variable>
            <xsl:for-each select="*[name() = $sourcefield]">
                  <xsl:variable name="ccstring">
                        <xsl:value-of select="replace(normalize-space(.),'&#34;',concat('&#34; ', &#34;'&#34;, '&#34;', &#34;'&#34;, ' &#34;'))"/>
                  </xsl:variable>
                  <xsl:variable name="ccstringfirst">
                        <xsl:value-of select="substring($ccstring,1,1)"/>
                  </xsl:variable>
                  <xsl:variable name="ccstringrest">
                        <xsl:value-of select="substring($ccstring,2)"/>
                  </xsl:variable>
                  <xsl:if test=". != ''">
                        <!-- added if to ignore empty fields -->
                        <xsl:text>
prec(bound) any(</xsl:text>
                        <!-- Added handling for double quote makes inside lx words with replace string. cct tables were broken before -->
                        <!-- replace(normalize-space(.),'"',concat('" ', "'", '"', "'", ' "')) or  normalize-space(.)
                        <xsl:value-of select="lower-case($ccstringfirst)"/> -->
                        <xsl:choose>
                              <xsl:when test="lower-case($ccstringfirst) = 'ā'">
                                    <xsl:text>amacron</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = 'á'">
                                    <xsl:text>aacute</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = 'ē'">
                                    <xsl:text>emacron</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = 'ê'">
                                    <xsl:text>ecircum</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = 'é'">
                                    <xsl:text>eacute</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = 'ī'">
                                    <xsl:text>imacron</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = 'ō'">
                                    <xsl:text>omacron</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = 'ū'">
                                    <xsl:text>umacron</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = 'ŋ'">
                                    <xsl:text>eng</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = '*'">
                                    <xsl:text>star</xsl:text>
                              </xsl:when>
                              <xsl:when test="lower-case($ccstringfirst) = '-'">
                                    <xsl:text>dash</xsl:text>
                              </xsl:when>
                              <xsl:otherwise>
                                    <xsl:value-of select="lower-case($ccstringfirst)"/>
                              </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>) "</xsl:text>
                        <xsl:value-of select="lower-case($ccstringrest)"/>
                        <xsl:text>" fol(bound)     &gt;     '&lt;link data="</xsl:text>
                        <xsl:value-of select="format-number($counter,'00000')"/>
                        <xsl:text>" title="</xsl:text>
                        <xsl:if test="$namelink = 'on'">
                              <xsl:choose>
                                    <xsl:when test="ie = ''">
                                          <xsl:value-of select="replace(replace(replace(ancestor::lxGroup//gl[1]/text(),$dquote,''),$apos,concat($apos,' ',$dquote,$apos,$dquote,' ',$apos)),'\|[rbi]','')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                          <xsl:value-of select="replace(replace(replace(ancestor::lxGroup//ie[1]/text(),$dquote,''),$apos,concat($apos,' ',$dquote,$apos,$dquote,' ',$apos)),'\|[rbi]','')"/>
                                    </xsl:otherwise>
                              </xsl:choose>
                        </xsl:if>
                        <xsl:text>"&gt;' dup '&lt;/link&gt;'</xsl:text>
                  </xsl:if>
            </xsl:for-each>
      </xsl:template>
      <xsl:template match="element" mode="main">
            <xsl:text>'&lt;</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&gt;'        &gt;        dup back(1) use(insert)
</xsl:text>
      </xsl:template>
      <xsl:template match="element" mode="insert">
            <xsl:text>'/</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&gt;'        &gt;        dup use(main)
</xsl:text>
      </xsl:template>
</xsl:stylesheet>
