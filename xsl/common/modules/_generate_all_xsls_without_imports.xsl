<?altova_samplexml file:///C:/Users/sna10/DEV/Source/xslt/nistmu2hl7xslt/trunk/xsl/common/modules/_common_tdspec_with_imports.xsl?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="_expand_imports_in_xsl.xslt"/>
	<xsl:template match="/">
		<xsl:result-document href="../common_tdspec.xsl" method="xml">
			<xsl:apply-templates select="document('_common_tdspec_with_imports.xsl')/*"/>
		</xsl:result-document>
		<xsl:result-document href="../common_messagecontent.xsl" method="xml">
			<xsl:apply-templates select="document('_common_messagecontent_with_imports.xsl')/*"/>
		</xsl:result-document>
		<xsl:result-document href="../common_teststory.xsl" method="xml">
			<xsl:apply-templates select="document('_common_teststory_with_imports.xsl')/*"/>
		</xsl:result-document>
		<xsl:result-document href="../../e-Rx/e-Rx_tdspec.xsl" method="xml">
			<xsl:apply-templates select="document('../../e-Rx/modules/_e-Rx_tdspec.xsl')/*"/>
		</xsl:result-document>
		<xsl:result-document href="../../e-Rx/e-Rx_tdspec_stdxml.xsl" method="xml">
			<xsl:apply-templates select="document('../../e-Rx/modules/_e-Rx_tdspec_stdxml.xsl')/*"/>
		</xsl:result-document>
		<xsl:result-document href="../xmsgcheck.xsl" method="xml">
			<xsl:apply-templates select="document('_xmsgcheck.xsl')/*"/>
		</xsl:result-document>
		<xsl:result-document href="../../lri/jurorDoc_LRIv2.xsl" method="xml">
			<xsl:apply-templates select="document('../../lri/modules/_build_jurorDoc_LRIv2.xsl')/*"/>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>
