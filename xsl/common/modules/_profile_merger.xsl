<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml file:///C:/Users/sna10/DEV/Source/xslt/nistmu2hl7xslt/trunk/xml/meta/profile/VXU-Z22_Profile.xml?>
<xsl:stylesheet xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="" exclude-result-prefixes="xs" version="2.0">
	<!-- Release notes author: sriniadhi.work@gmail.com 


-->
<xsl:variable name="version" select="'1.0'" />


<!--This is required to escape the delimiters -->
<xsl:character-map name="tags">
		<xsl:output-character character="&lt;" string="&lt;"/>
		<xsl:output-character character="&gt;" string="&gt;"/>
</xsl:character-map>


<xsl:output method="text" use-character-maps="tags"/>


<xsl:variable name="generate-plain-html" select="false()" />


<xsl:variable name="output" select="'xml'" />

<xsl:variable name="ind1" select="'&#9;&#9;'"/>
<xsl:variable name="ind2" select="'&#9;&#9;&#9;&#9;&#9;'"/>
<xsl:variable name="ind3" select="'&#9;&#9;&#9;&#9;&#9;&#9;&#9;'"/>


<xsl:include href="_hl7tables_min2.xsl"/>
<xsl:include href="_util.xsl"/>


<!-- we take two inputs: one is the Profile.xml
      the other is the contraints.xml which is read whose path needs to be passed as a parameter -->
      
<xsl:param name="constraints" select="document('file:///C:/Users/sna10/DEV/Source/xslt/nistmu2hl7xslt/trunk/xml/meta/constraints/VXU-Z22_Constraints.xml')"/>



<!--Identity template, 
        provides default behavior that copies all content into the output -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>


	<xsl:template match="*[@ID]">
	<xsl:variable name="id" select="./@ID" />
	<xsl:variable name="constraint" select="$constraints//ByID[@ID=$id]" />
	<xsl:variable name="predicates" select="$constraint/Predicate/@ID" />
	<xsl:variable name="constraints" select="$constraint/Constraint/@ID" />

			<xsl:variable name="constraint-out">
			<xsl:value-of select="util:tag('Predicates', '')" />

					<xsl:for-each select="$constraint//Predicate/*" > 
							<xsl:value-of select="util:tag('Predicate', '')" />
							<xsl:value-of select="concat($nl, $indent, $indent, 'ID = ' , ./@ID, $nl)" />
							<xsl:copy>
								<xsl:value-of select="." />
							</xsl:copy>
							<xsl:value-of select="util:tag('/Predicate', '')" />
					</xsl:for-each>
					<xsl:value-of select="$nl" />
			<xsl:value-of select="util:tag('/Predicates', '')" />
					
<!--				Constraints <xsl:for-each select="$constraint/Constraint/@ID" > <xsl:value-of select="concat($nl, $indent, $indent, 'ID = ' , .)" /></xsl:for-each> <xsl:value-of select="$nl" /> -->
						
				
			</xsl:variable>
	


        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
			
			<xsl:value-of select="$constraint-out" />
            
        </xsl:copy>
	</xsl:template>

	<xsl:template match="*[@ID1]">
	<xsl:variable name="id" select="./@ID" />
	<xsl:value-of select="concat('Working on:',  $id, $nl, $nl)" />
	<xsl:variable name="constraint" select="$constraints//ByID[@ID=$id]" />
	<xsl:variable name="predicates" select="$constraint/Predicate/@ID" />
	<xsl:variable name="constraints" select="$constraint/Constraint/@ID" />

	<xsl:value-of select="concat($nl, '&lt;!--Working on:',  $id, '--&gt;', $nl, $nl)" />
	<xsl:if test="count($predicates) + count($constraints) > 0">
			<xsl:variable name="constraint-out">
				Predicates <xsl:for-each select="$constraint/Predicate/*" > 
				<xsl:value-of select="concat($nl, $indent, $indent, 'ID = ' , ./@ID, $nl)" />
					<xsl:copy><xsl:value-of select="." /></xsl:copy>
				</xsl:for-each> <xsl:value-of select="$nl" />
				Constraints <xsl:for-each select="$constraint/Constraint/@ID" > <xsl:value-of select="concat($nl, $indent, $indent, 'ID = ' , .)" /></xsl:for-each> <xsl:value-of select="$nl" />
				
				
			</xsl:variable>
	
	************************************************************************************************************************************************************************
	<xsl:value-of select="$constraint-out" />
	************************************************************************************************************************************************************************
	</xsl:if>


	<xsl:if test="count($predicates) + count($constraints) > 0">
			<xsl:variable name="constraint-out">
				Predicates <xsl:for-each select="$constraint/Predicate/*" > 
				<xsl:value-of select="concat($nl, $indent, $indent, 'ID = ' , ./@ID, $nl)" />
					<xsl:copy><xsl:value-of select="." /></xsl:copy>
				</xsl:for-each> <xsl:value-of select="$nl" />
				Constraints <xsl:for-each select="$constraint/Constraint/@ID" > <xsl:value-of select="concat($nl, $indent, $indent, 'ID = ' , .)" /></xsl:for-each> <xsl:value-of select="$nl" />
				
				
			</xsl:variable>
	
	************************************************************************************************************************************************************************
	<xsl:value-of select="$constraint-out" />
	************************************************************************************************************************************************************************
	</xsl:if>
	<!--
	<xsl:value-of select="concat('ID = (', $id, ')', $nl)" />	
	<xsl:value-of select="$constraint" />	 -->
	<xsl:value-of select="$nl" />


	<xsl:apply-templates select="./*"/>
	</xsl:template>


<!--

<for eachatrrib id=>





-->
</xsl:stylesheet>
