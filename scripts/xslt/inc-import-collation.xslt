<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <!-- Sort order processing for XXX
The collation list is \r\n separated (win CR LF) 
The control list source text is in the form:

a,A
b,B
c,C

The first line contain ignore character separated by equal sign. (but that is not working, for now first line blank)
The last line should not be blank

<xsl:variable name="customcollation" >
<xsl:if test="$collationiso = 'yka'">
 <xsl:text>'&lt; ā,Ā &lt; a,A &lt; b,B &lt; c,C &lt; d,D &lt; ē,Ē &lt;e,E &lt; f,F &lt; g,G &lt; h,H &lt; ī,Ī &lt; i,I &lt; j,J &lt; k,K &lt; ˈ &lt; l,L &lt; m,M &lt; n,N &lt; ō,Ō &lt; o,O &lt; p,P &lt; q,Q &lt; r,R &lt; s,S &lt; t,T &lt; ū,Ū &lt; u,U &lt; v,V &lt; w,W &lt; x,X &lt; y,Y &lt; z,Z'</xsl:text>
</xsl:if>
 
</xsl:variable>      <xsl:param name="collationtexturi"/>
      <xsl:variable name="customcollation" select="replace(unparsed-text($collationtexturi),'\r\n',' &lt; ')"/>  -->
      <xsl:param name="customcollationon"/>
      <xsl:variable name="customcollation" select="'&lt; ā,Ā &lt; a,A &lt; b,B &lt; c,C &lt; d,D &lt; ē,Ē &lt;e,E &lt; f,F &lt; g,G &lt; h,H &lt; ī,Ī &lt; i,I &lt; j,J &lt; k,K &lt; ˈ &lt; l,L &lt; m,M &lt; n,N &lt; ng,Ng &lt; ŋ,Ŋ &lt; ō,Ō &lt; o,O &lt; p,P &lt; q,Q &lt; r,R &lt; s,S &lt; t,T &lt; ū,Ū &lt; u,U &lt; v,V &lt; w,W &lt; x,X &lt; y,Y &lt; z,Z'"/>

</xsl:stylesheet>
