<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:util="http://hl7.nist.gov/data-specs/util"  xmlns:fo="http://www.w3.org/1999/XSL/Format">


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- plain-html : create a head with css and a body around the "main" template to make it a plain html -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="plain-html">
			<xsl:variable name="full">
				<xsl:call-template name="_main"/>
			</xsl:variable>
			<html>
				<head>
					<title></title>
					<xsl:call-template name="css"></xsl:call-template>
				</head>
				<body>
					<div class="test-data-specs-main">
						<xsl:value-of select="util:strip-tabsets($full)"/>
					</div>
				</body>
			</html>
	</xsl:template>


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="plain-html-message-content">
			<xsl:variable name="full">
				<xsl:call-template name="_main"/>
			</xsl:variable>
			<html>
				<head>
					<title></title>
					<xsl:call-template name="css"></xsl:call-template>
				</head>
				<body>
					<div class="message-content">
						<xsl:value-of select="util:strip-tabsets($full)"/>
					</div>
				</body>
			</html>
	</xsl:template>
</xsl:stylesheet>
