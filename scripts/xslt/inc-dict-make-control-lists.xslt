<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:silp="silp.org.ph/ns" exclude-result-prefixes="xs silp">
      <!-- 
The lists are \s separated (win CR LF or any space type) included items must be preceeded by a underscore
The control list source text is in the form:
included_item_1
included_item_2
or
item1 item3  item3 etc
	Modified by Ian McQuay 
	Created 2012-06-14
-->
      <xsl:variable name="groupsdivs">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$groupsdivstext"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="inlinespans">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$inlinespanstext"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="sensehom">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$sensehomtext"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="sensehomgrouped">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$groupedsensehomlist"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="omit">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$omittext"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="csstranslate">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$translateabreviations"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="serialnodes">
            <xsl:call-template name="list2xml">
                  <xsl:with-param name="text" select="$serialnodesnothom"/>
            </xsl:call-template>
      </xsl:variable>
      <xsl:include href='inc-list2xml.xslt'/>
</xsl:stylesheet>
