<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
	<xsl:template match="node() | @*">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xsl:import|xsl:include">
		<xsl:apply-templates select="document(@href)/xsl:stylesheet/*"/>
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>
