<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:silp="http://silp.org.ph/ns">
      <xsl:include href='temp-match.xslt'/>
      <xsl:param name="precontext"/>
      <xsl:param name="postcontext"/>
      <xsl:param name="table"/>
      <xsl:param name="collabel1"/>
      <xsl:param name="collabel2"/>
      <xsl:param name="collabel3"/>
      <xsl:param name="collabel4"/>
      <xsl:param name="locref"/>
      <xsl:param name="pagination"/>
      <xsl:variable name="css">
            <xsl:text>
@page { size: A5 ; margin: 2cm ;
      @top-left { content: string(os) }
    @bottom-center { 
        content: counter(page);
        }
}
h3 {page-break-before:always}
.om_1 {page-break-before:avoid}
th {font-size:9pt}
tr {page-break-inside:avoid; margin-bottom:4pt}
td  {page-break-inside:avoid; vertical-align:top}
.os { string-set: os content() }
th {text-align:left}
td {padding-left:5pt}
td.o { width: .5cm; text-align:right; padding-left:0}
.e { width: 4cm;}
.t { width: 4.5cm;}
.k { width: auto}
</xsl:text>
      </xsl:variable>
      <xsl:template match="/*">
            <html>
                  <head>
                        <link rel="stylesheet" href="{$pagination}" type="text/css"/>
                        <style type="text/css">
                              <xsl:value-of select="$css"/>
                        </style>
                  </head>
                  <body>
                        <xsl:apply-templates/>
                  </body>
            </html>
      </xsl:template>
      <xsl:template match="*">
            <xsl:variable name="this-name" select="local-name()"/>
            <xsl:element name="{silp:match(name())}">
                  <xsl:attribute name="class">
                        <xsl:value-of select="name()"/>
                        <xsl:if test="$locref = 'yes'">
                              <xsl:text> </xsl:text>
                              <xsl:value-of select="name()"/>
                              <xsl:text>_</xsl:text>
                              <xsl:value-of select="count(preceding-sibling::*[name() = $this-name]) + 1"/>
                        </xsl:if>
                  </xsl:attribute>
                  <xsl:if test="$precontext = 'yes'">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="name()"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="name(preceding-sibling::*[1])"/>
                  </xsl:if>
                  <xsl:if test="$postcontext = 'yes'">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="name()"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="name(following-sibling::*[1])"/>
                  </xsl:if>
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="*[local-name() = $table]">
            <xsl:element name="{silp:match(name())}">
                  <xsl:attribute name="class">
                        <xsl:value-of select="name()"/>
                        <xsl:if test="$locref = 'yes'">
                              <xsl:text> </xsl:text>
                              <xsl:value-of select="name()"/>
                              <xsl:text>_</xsl:text>
                              <xsl:value-of select="count(preceding-sibling::*[name()])"/>
                        </xsl:if>
                  </xsl:attribute>
                  <xsl:apply-templates/>
            </xsl:element>
      </xsl:template>
      <xsl:template match="tb">
            <xsl:element name="{silp:match(name())}">
                  <xsl:attribute name="class">
                        <xsl:value-of select="name()"/>
                  </xsl:attribute>
                  <tr>
                        <th>
                              <xsl:value-of select="$collabel1"/>
                        </th>
                        <th>
                              <xsl:value-of select="$collabel2"/>
                        </th>
                        <th>
                              <xsl:value-of select="$collabel3"/>
                        </th>
                        <th>
                              <xsl:value-of select="$collabel4"/>
                        </th>
                  </tr>
            </xsl:element>
      </xsl:template>
      <xsl:template match="*[silp:match(name()) = 'td']">
            <xsl:variable name="this-name" select="local-name()"/>
            <xsl:element name="{silp:match(name())}">
                  <xsl:attribute name="class">
                        <xsl:value-of select="name()"/>
                        <xsl:if test="$locref = 'yes'">
                              <xsl:text> </xsl:text>
                              <xsl:value-of select="name()"/>
                              <xsl:text>_</xsl:text>
                              <xsl:value-of select="count(preceding-sibling::*[name() = $this-name]) + 1"/>
                        </xsl:if>
                  </xsl:attribute>
                  <xsl:if test="$precontext = 'yes'">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="name()"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="name(preceding-sibling::*[1])"/>
                  </xsl:if>
                  <xsl:if test="$postcontext = 'yes'">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="name()"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="name(following-sibling::*[1])"/>
                  </xsl:if>
                  <div class="nobreak">
                        <xsl:apply-templates/>
                  </div>
            </xsl:element>
      </xsl:template>
</xsl:stylesheet>
