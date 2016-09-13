<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    @author Laxmikanth Samudrala 
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:util="http://www.nist.gov/jurordoc" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
xmlns:fn="http://www.w3.org/2005/xpath-functions">

<xsl:include href="er7toxml.xsl" />

<!--xsl:variable name="file1text" select="unparsed-text('file:///C://Users//sna10//DEV//Source//java//dqa//WindowsMessageTool//msg//ORIGINAL-ONC-TestPlan2015//TestGroup_2//TestCase_1//TestStep_2/Message.txt')"/-->

<xsl:variable name="file1text" select="unparsed-text('file:///C://Users//sna10//DEV//Source//xslt//nistmu2hl7xslt//trunk//er7//LRI_4.2_4.1-GU_FRN.txt')"/>


	<xsl:template match="/">
		<xsl:call-template name="parseER7Message">
			<xsl:with-param name="er7Message" select="replace($file1text, '&#xA;', '&#xD;')" />
		</xsl:call-template>
		
	</xsl:template>
</xsl:stylesheet>
