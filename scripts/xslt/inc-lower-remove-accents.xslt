<?xml version="1.0" encoding="utf-8" standalone="no"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cite="http://fake.org.au/ns/">
      <xsl:param name="translateaccents" select="'yes'"/>
      <xsl:param name="customfind"/>
      <xsl:param name="customreplace"/>
      <xsl:param name="removechar"/>
      <xsl:param name="digraphlist"/>
      <!--     <xsl:param name="decchar2remove" select="'39 34'"/>
      <xsl:variable name="entities">
            <xsl:analyze-string select="$decchar2remove" regex="\s+">
                  <xsl:matching-substring/>
                  <xsl:non-matching-substring>
                        <xsl:value-of select="concat('&#38;#',.,';')"/>
                  </xsl:non-matching-substring>
            </xsl:analyze-string>
      </xsl:variable> -->
      <xsl:variable name="ac" select="'àáâãāçèéêëēìíîïɨīùúûüūòóôõöōŏőɴ'"/>
      <xsl:variable name="un" select="'aaaaaceeeeeiiiiiiuuuuuoooooooon'"/>
      <xsl:variable name="numbers" select="'0123456789'"/>
      <xsl:variable name="or-digraph">
            <xsl:choose>
                  <xsl:when test="string-length($digraphlist) gt 0">
                        <xsl:value-of select="replace($digraphlist,' ','|')"/>
                        <xsl:text>|</xsl:text>
                  </xsl:when>
                  <xsl:otherwise/>
            </xsl:choose>
      </xsl:variable>
      <xsl:variable name="removefromstart">&#34;\-(“~\[,‘;&#39;#&#42;&#47;<xsl:value-of select="$removechar" /></xsl:variable>
      <xsl:include href='inc-list2xml.xslt'/>
      <xsl:variable name="digraphs">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$digraphlist"/>
            </xsl:call-template>
      </xsl:variable>
      <!--  <xsl:function name="cite:lower-remove-accents">
            <xsl:param name="input"/>
            <xsl:choose>
                  <xsl:when test="$translateaccents = 'no'">
                        <xsl:choose>
                              <xsl:when test="$customfind != ''">
                                    <xsl:sequence select="translate(replace(lower-case(normalize-unicode($input)),$customfind,$customreplace),$removefromstart,'')"/>
                              </xsl:when>
                              <xsl:otherwise>
                                    <xsl:sequence select="translate(lower-case(normalize-unicode($input)),$removefromstart,'')"/>
                              </xsl:otherwise>
                        </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:choose>
                              <xsl:when test="$customfind != ''">
                                    <xsl:sequence select="translate(
										translate(
												replace(
												         	lower-case(
		               									                                      normalize-unicode($input)
															          )
													    ,$customfind,$customreplace)
											      ,$removefromstart,'')
										,$ac,$un)"/>
                              </xsl:when>
                              <xsl:otherwise>
                                    <xsl:sequence select="translate(translate(lower-case(normalize-unicode($input)),$ac,$un),$removefromstart,'')"/>
                              </xsl:otherwise>
                        </xsl:choose>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:function>
      <xsl:function name="cite:lower-remove-accents-word">
            <xsl:param name="input"/>
            <xsl:choose>
                  <xsl:when test="$translateaccents = 'no'">
                        <!- - Normalize text
				convert to lower case
				remove punctuation characters from words
			- ->
                        <xsl:sequence select="translate(lower-case(normalize-unicode($input)),$removefromstart,'')"/>
                  </xsl:when>
                  <xsl:otherwise>
                        <!- - Normalize text
				convert to lower case
				remove accentes on vowels
				remove punctuation characters from words
			- ->
                        <xsl:sequence select="translate(translate(lower-case(normalize-unicode($input)),$ac,$un),$removefromstart,'')"/>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:function> -->
      <xsl:function name="cite:custom-first-letter">
            <xsl:param name="input"/>
            <xsl:variable name="findletterordigraph" select="concat('^(',$or-digraph,'.).*') "/>
            <xsl:variable name="find" select="'^[\d\*&#47; -]*(\w).*'"/>
            <xsl:variable name="trimmedinput" select="cite:translateaccents($input)"/>
            <xsl:variable name="firstletterordigraph">
                  <xsl:choose>
                        <xsl:when test="string-length($digraphs) gt 0">
                              <xsl:value-of select="replace($trimmedinput,$findletterordigraph,'$1')"/>
                        </xsl:when>
                        <xsl:otherwise>
                              <xsl:value-of select="replace($trimmedinput,$find,'$1')"/>
                        </xsl:otherwise>
                  </xsl:choose>
            </xsl:variable>
            <xsl:sequence select="$firstletterordigraph"/>
      </xsl:function>
      <xsl:function name="cite:translateaccents">
            <xsl:param name="input"/>
            <xsl:variable name="findnremoveatstart" select="concat('^[\d\* ',$removefromstart,']*(',$or-digraph,'\w)(\w*)') "/>
            <xsl:variable name="lcinput" select="lower-case($input)"/>
            <xsl:variable name="trimmedinput" select="replace($lcinput,$findnremoveatstart,'$1$2')"/>
            <xsl:choose>
                  <xsl:when test="$translateaccents = 'yes'">
                        <xsl:sequence select="translate($trimmedinput,$ac,$un)"/>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:sequence select="$trimmedinput"/>
                  </xsl:otherwise>
            </xsl:choose>
      </xsl:function>
      <xsl:function name="cite:word-no-number">
            <xsl:param name="input"/>
            <xsl:sequence select="translate($input,$numbers,'')"/>
      </xsl:function>
      <xsl:function name="cite:no-space">
            <xsl:param name="input"/>
            <xsl:sequence select="translate($input,' ','')"/>
      </xsl:function>
      <xsl:function name="cite:hom-number">
            <!-- used in dict-sort-with-custom-collation.xslt and index-group-n-sort.xslt -->
            <xsl:param name="input"/>
            <xsl:sequence select="substring-after($input,translate($input,$numbers,''))"/>
      </xsl:function>
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
            <xsl:value-of select="cite:translateaccents($ac)"/>
            <xsl:text>
          </xsl:text>
            <xsl:text disable-output-escaping="yes">--&gt;
 </xsl:text>
      </xsl:template>
</xsl:stylesheet>
