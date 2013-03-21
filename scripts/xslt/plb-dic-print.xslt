<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
      <xsl:output indent="yes" method="xhtml" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"/>
      <xsl:variable name="engindex"></xsl:variable>
      <xsl:include href='../../scripts/xslt/inc-dict-sense-hom.xslt'/>
      <xsl:strip-space elements="*"/>
<xsl:param name="dd1"/>
<xsl:param name="dd2"/>
      <!-- sense and homonym templates -->
      <xsl:template match="/">
            <xsl:apply-templates select="database"/>
      </xsl:template>
      <xsl:template match="database">
            <html>
                  <head>
                        <meta name="generator" content="ToolBox PLB dictionary transformation"/>
                        <title>Karao Dictionary</title>
                        <style type="text/css">
                              <xsl:call-template name="css"/>
                        </style>
                  </head>
                  <body>
                        <xsl:apply-templates/>
                  </body>
            </html>
      </xsl:template>

      <xsl:template match="lxGroup">
            <xsl:variable name="engindex"></xsl:variable>
            <div class="{name(.)}">
                  <xsl:apply-templates/>
                  <xsl:value-of select="$engindex"/>
            </div>
      </xsl:template>
      <xsl:template match="psGroup">
            <xsl:text> 
    </xsl:text>
            <span class="{name(.)}">
                  <xsl:apply-templates/>
            </span>
      </xsl:template>
      <xsl:template match="glGroup">
            <xsl:text> 
    </xsl:text>
            <span class="{name(.)}">
                  <xsl:apply-templates/>
            </span>
      </xsl:template>
      <xsl:template match="msGroup">
            <xsl:text> 
    </xsl:text>
            <span class="{name(.)}">
                  <xsl:apply-templates/>
            </span>
      </xsl:template>
      <xsl:template match="snGroup">
            <xsl:text> 
    </xsl:text>
            <span class="{name(.)}">
                  <xsl:apply-templates/>
            </span>
      </xsl:template>
      <xsl:template match="vaGroup">
            <xsl:text> 
    </xsl:text>
            <span class="{name(.)}">
                  <xsl:apply-templates/>
            </span>
      </xsl:template>
      <xsl:template match="seGroup">
            <xsl:text> 
    </xsl:text>
            <span class="{name(.)}">
                  <xsl:apply-templates/>
            </span>
      </xsl:template>
      <xsl:template match="exGroup">
            <xsl:text> 
     </xsl:text>
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text> </xsl:text>
                  </span>
                  <xsl:apply-templates/>
            </span>
      </xsl:template>
      <xsl:template match="xvGroup">
            <xsl:text> 
     </xsl:text>
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>Example sentence:</xsl:text>
                  </span>
                  <xsl:apply-templates/>
            </span>
      </xsl:template>
      <xsl:template match="AlphDiv">
            <xsl:text> 
     </xsl:text>
            <h1 class="{name(.)}">
                  <xsl:apply-templates/>
            </h1>
      </xsl:template>
      <xsl:template match="charbold"><strong class="{name(.)}"><xsl:apply-templates/></strong></xsl:template>
      <xsl:template match="charitalic"><em class="{name(.)}">
                  <xsl:apply-templates/>
            </em>
      </xsl:template>
      <xsl:template match="*"> 
</xsl:template>
      <xsl:template match="ad">
            <span class="{name(.)}">
                  <xsl:text>+ </xsl:text>
                  <xsl:apply-templates/>
                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="ar">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>Archaic </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="co">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>Note. </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="dd1">
            <span class="{name(.)}">
                  
                        <xsl:text>(</xsl:text>
                  <xsl:value-of select="$dd1"/>

                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="dd2">
            <span class="{name(.)}">
                        <xsl:text>(</xsl:text>
                  <xsl:value-of select="$dd2"/>

                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="de">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(Eng. </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="di">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(Ilo. </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="ds">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(Sp.  </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="ec">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(</xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="eg">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text></xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="ex">
            <span class="{name(.)}">
                 <xsl:apply-templates select="node()|charbold"/>
            </span>
            <xsl:text> </xsl:text>
      </xsl:template>
      <xsl:template match="ie">
 <!--           <xsl:param name="engindex"/>
                  <xsl:value-of select="$engindex"/>
                  <xsl:text>
</xsl:text>
                  <span class="{name(.)}">
                        <span class="label">
                              <xsl:text>[Eng. </xsl:text>
                        </span>
                        <xsl:apply-templates/>
                        <xsl:text>] </xsl:text>
                        <br/>
                  </span>
-->
      </xsl:template>
      <xsl:template match="gl">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text></xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="ld">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(derv.) </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="li">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(idiom)  </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="ls">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(saying) </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="lx">
            <span class="{name(.)}">
                  <xsl:call-template name="senseorhom">
                        <xsl:with-param name="string" select="."/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="mb">
            <span class="{name(.)}">
                  <xsl:text>(var.  </xsl:text>
                  <xsl:apply-templates/>
                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="mo">
            <span class="{name(.)}">
                  <xsl:text>&lt;</xsl:text>
                  <xsl:value-of select="."/>
                  <xsl:text>&gt; </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="mr">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>c.f. </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="ms">
            <span class="{name(.)}">
                  <!-- <span class="label">
                        <xsl:text>Sense</xsl:text>
                        <xsl:if test="position() gt 1">
                              <xsl:text> multisense</xsl:text>
                        </xsl:if>
                  </span> -->
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="oa">
            <span class="{name(.)}">
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="oi">
            <span class="{name(.)}">
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="op">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>pl. </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="pn">
            <span class="{name(.)}">
                  <xsl:text>[&#8204;</xsl:text>
                  <xsl:apply-templates/>
                  <xsl:text>&#8204;] </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="ps">
            <span class="{name(.)}">
                  <xsl:apply-templates/>
            </span>
            <xsl:text> </xsl:text>
      </xsl:template>
      <xsl:template match="re">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>c.f. </xsl:text>
                  </span>
                  <xsl:call-template name="senseorhom">
                        <xsl:with-param name="string" select="."/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="rf">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(from </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="rg">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>genr. </xsl:text>
                  </span>
                  <xsl:call-template name="senseorhom">
                        <xsl:with-param name="string" select="."/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="rs">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>syn. </xsl:text>
                  </span>
                  <xsl:call-template name="senseorhom">
                        <xsl:with-param name="string" select="."/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="rt">
            <span class="{name(.)}">
                  <xsl:text>(see </xsl:text>
                  <xsl:apply-templates/>
                  <xsl:text>for table.) </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="sn">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text></xsl:text>
                  </span>
                  <xsl:call-template name="senseorhom">
                        <xsl:with-param name="string" select="."/>
                  </xsl:call-template>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="tb">
            <span class="{name(.)}">
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="i">
            <i>
                  <xsl:apply-templates/>
            </i>
            <xsl:text> </xsl:text>
      </xsl:template>
      <xsl:template match="b">
            <b>
                  <xsl:apply-templates/>
            </b>
            <xsl:text> </xsl:text>
      </xsl:template>
      <xsl:template match="tr">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text></xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text> </xsl:text>
            </span>
      </xsl:template>
      <xsl:template match="va">
            <span class="{name(.)}">
                  <span class="label">
                        <xsl:text>(var. </xsl:text>
                  </span>
                  <xsl:apply-templates/>
                  <xsl:text>) </xsl:text>
            </span>
      </xsl:template>
      <!-- CSS styles -->
      <xsl:template name="css">
.ar, .ex, .ps, .sn {font-style:italic}
.oa, .oi {font-weight:bold}
.lx {font-weight:bold ;font-size:115%}    
body {font-family:Charis Sil; font-size:9pt}  
.multisense {display:block;   
	margin-left: 1.5em; 
}
div {  text-indent: -1.5em; 
  margin-left: 1.5em; 
}
.sub { font-size: 80%; position: relative; top: 2px}
          </xsl:template>
</xsl:stylesheet>
