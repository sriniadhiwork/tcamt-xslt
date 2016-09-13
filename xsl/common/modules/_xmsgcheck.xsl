<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    @author sriniadhi.work@gmail.com
-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:util="http://www.nist.gov/jurordoc" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
xmlns:fn="http://www.w3.org/2005/xpath-functions">
<xsl:param name="file1name" select="'file:///C:/Users/sna10/DEV/Source/xslt/nistmu2hl7xslt/trunk/er7/IZ-QR-1.1_Query_Q11_Z44.txt'"/>
<xsl:param name="file2name" select="'file:///C:/Users/sna10/DEV/Source/xslt/nistmu2hl7xslt/trunk/er7/IZ-QR-1.2_Response_K11_Z42.txt'"/>
<xsl:output method="text" />

<xsl:include href="../er7toxml.xsl"/>

<xsl:variable name="text-encoding" as="xs:string" select="'ISO-8859-1'"/>

<xsl:variable name="file1text" select="unparsed-text($file1name, $text-encoding)"/>
<xsl:variable name="file2text" select="unparsed-text($file2name, $text-encoding)"/>

<xsl:template match="/" priority="1000">

	<xsl:variable name="file1nodes"  as="node()*">
		<xsl:call-template name="parseER7Message">
			<xsl:with-param name="er7Message" select="replace($file1text, '&#xA;', '&#xD;')" />
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="file2nodes" as="node()*">
		<xsl:call-template name="parseER7Message">
			<xsl:with-param name="er7Message" select="replace($file2text, '&#xA;', '&#xD;')" />
		</xsl:call-template>
	</xsl:variable>
	
<xsl:variable name="config">
<check file1="MSH.3" file2="MSH.5"/>
<check file1="MSH.4" file2="MSH.6"/>
<check file1="MSH.5" file2="MSH.3"/>
<check file1="MSH.6" file2="MSH.4"/>
<check file1="MSH.10" file2="MSA.2"/>
<check file1="MSH.22" file2="MSH.23"/>
<check file1="MSH.23" file2="MSH.22"/>

<check file1="QPD.2" file2="QAK.1"/>
<check file1="QPD" file2="QPD"/>
<check file1="QPD.3.1" file2="PID.3.1"/>
<check file1="QPD.3.4" file2="PID.3.4"/>
<check file1="QPD.3.5" file2="PID.3.5"/>
<check file1="QPD.4.1" file2="PID.5.1"/>
<check file1="QPD.4.2" file2="PID.5.2"/>
<check file1="QPD.4.3" file2="PID.5.3"/>
<check file1="QPD.4.4" file2="PID.5.4"/>
<check file1="QPD.5.1" file2="PID.6.1"/>
<check file1="QPD.5.2" file2="PID.6.2"/>
<check file1="QPD.5.7" file2="PID.6.7"/>
<check file1="QPD.6" file2="PID.7"/>
<check file1="QPD.7" file2="PID.8"/>
<check file1="QPD.8.1" file2="PID.11.1"/>
<check file1="QPD.8.3" file2="PID.11.3"/>
<check file1="QPD.8.4" file2="PID.11.4"/>
<check file1="QPD.8.5" file2="PID.11.5"/>
<check file1="QPD.8.7" file2="PID.11.7"/>
<check file1="QPD.9.2" file2="PID.13.2"/>
<check file1="PQD.9.3" file2="PID.13.3"/>
<check file1="QPD.9.4" file2="PID.13.4"/>
<check file1="QPD.9.6" file2="PID.13.6"/>
<check file1="QPD.9.7" file2="PID.13.7"/>
<check file1="QPD.10" file2="PID.24"/>
<check file1="QPD.11" file2="PID.25"/>
<check file1="QPD.12" file2="PID.33"/>
<check file1="QPD.13" file2="PID.34"/>





</xsl:variable>

<xsl:for-each select="$config/check">
<xsl:variable name="file1field" select="@file1"/>
<xsl:variable name="file2field" select="@file2"/>

<xsl:choose>


	<xsl:when test="fn:compare(normalize-space(($file1nodes//*[name()=$file1field])[1]), normalize-space(($file2nodes//*[name()=$file2field])[1])) = 0">
	<xsl:text>Good</xsl:text> <xsl:value-of select="@file1"/> <xsl:text>= </xsl:text><xsl:value-of select="@file2"/><xsl:text>
	</xsl:text>
	</xsl:when>
	<xsl:otherwise>
		<xsl:text>Bad : file1</xsl:text> <xsl:value-of select="@file1"/> 
		<xsl:text>(</xsl:text><xsl:value-of select="normalize-space(($file1nodes//*[name()=$file1field])[1])"/> <xsl:text>) 		not = </xsl:text><xsl:value-of select="@file2"/>	<xsl:text>(</xsl:text><xsl:value-of select="normalize-space(($file2nodes//*[name()=$file2field])[1])"/><xsl:text>)	
		</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:for-each>
</xsl:template>

<xsl:function name="util:first">
<xsl:param name="nset" as="node()*" />

</xsl:function>
</xsl:stylesheet>