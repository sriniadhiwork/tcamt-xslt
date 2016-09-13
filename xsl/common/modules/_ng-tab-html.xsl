<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<!-- plain-html : create a head with css and a body around the "main" template to make it a plain html -->
	<xsl:template name="ng-tab-html">
		<xsl:call-template name="css"></xsl:call-template>
		<xsl:call-template name="main"></xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
