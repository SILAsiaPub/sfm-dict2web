<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
      <xsl:output indent="yes" method="html" version="4.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" omit-xml-declaration="no" name="html"/>
      <xsl:strip-space elements=""/>
      <xsl:param name="path"/>

      <xsl:variable name="labelname" select="'Language Name goes here'"/>
      <xsl:variable name="prefile" select="'/lx'"/>
      <xsl:variable name="preurl" select="'../lexicon/lx'"/>
      <xsl:variable name="groupsdivstext" select="
'exGroup
glGroup
lcGroup
ldGroup
liGroup
lsGroup msGroup
psGroup
raGroup
reGroup
rfGroup
rgGroup
rsGroup
rtGroup
scGroup
seGroup
snGroup
vaGroup'
"/>
      <!-- the above list should space or newline separated 
	It is okay to have redundant groups, but all groups soud be included -->
      <xsl:variable name="inlinespanstext" select="
'charbold
charitalic
charbolditalic
oa'
"/>
      <!-- the above list should space or newline separated 
	The list is for any fields that should be made into simple spans -->
      <xsl:variable name="sensehomtext" select="
'
ra
re
rf
rg
re
rt'
"/>
      <!-- the above list should space or newline separated 
	This list lists fields that have words with homonyms numbers and or links to multiple senses -->
      <xsl:variable name="groupedsensehomlist" select="
'
ra
re
rg
rs
rt
'
"/>
      <!-- the above list should space or newline separated 
	These fields are a suset or maybe all of the sensehomtext. They are grouped fields, -->
      <xsl:variable name="omittext" select="
'no ie rx'
"/>
      <!-- the above list should space or newline separated 
	This list is to omit these fields redundant names are okay, Better to leave blank until you see something that should be ignored -->
      <xsl:variable name="translateabreviations" select="
'ps oc'
"/>
      <!-- These fields have limited sets. The data is removed and replaced by a class that css will supply with the data. The above list should space or newline separated -->
      <xsl:variable name="serialnodesnothom" select="
'sc'
"/>
      <!-- Ththe above list is a set of nodes that has grouping. That is it occurs in series and has been grouped, but cannot have sense and Hom handling. The above list should space or newline separated -->

      <xsl:include href='../../scripts/xslt/inc-dict-html-css.xslt'/>
      <!-- above main dict handling -->
</xsl:stylesheet>
