<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    @author Laxmikanth Samudrala 
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:util="http://www.nist.gov/jurordoc" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:param name="er7Message"/>
	
	<xsl:variable name="testCaseInterim" select="segments"/>
	<xsl:variable name="segmentSplitter" select="'&#xD;'"/>
	<xsl:variable name="fieldSplitter" select="'[|]'"/>
	<xsl:variable name="componentSplitter" select="'[\^]'"/>
	<xsl:variable name="fieldRepeatSplitter" select="'[~]'"/>
	<xsl:variable name="subComponentSplitter" select="'[&amp;]'"/>
	<xsl:variable name="er7Profile" select="HL7v2xConformanceProfile/HL7v2xStaticDef"/>
	<xsl:function name="util:isPassesFilter" as="xs:boolean">
		<xsl:param name="data"/>
		<xsl:param name="dataPath"/>
		<xsl:value-of select="true()"/>
	</xsl:function>
	<xsl:template name="parseER7Message">
		<xsl:param name="er7Message"/>
		<xsl:variable name="segmentList" select="tokenize($er7Message,$segmentSplitter)"/>
		<xsl:text>&#xd;</xsl:text>
		<ADT_A04>
			<xsl:for-each select="$segmentList">
				<xsl:choose>
					<xsl:when test="string-length(.) &gt; 0">
						<xsl:text>&#xd;</xsl:text>
							<xsl:call-template name="parseSegment">
								<xsl:with-param name="segmentData" select="."/>
								<xsl:with-param name="segmentStage" select="position()"/>
							</xsl:call-template>
						<xsl:text>&#xd;</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:copy-of select="$testCaseInterim/messageProfile"/>
		</ADT_A04><xsl:text>&#xd;</xsl:text>
	</xsl:template>
	<!-- Formats Segments -->
	<xsl:template name="parseSegment">
		<xsl:param name="segmentData"/>
		<xsl:param name="segmentStage"/>
		<xsl:variable name="segmentFields" select="tokenize($segmentData,$fieldSplitter)"/>
		<xsl:element name="{$segmentFields[1]}">
		<xsl:variable name="segmentProfile" as="node()*">
			<xsl:copy-of select="$er7Profile//Segment[@Name=$segmentFields[1]]"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="util:isPassesFilter(.,$segmentFields[1])">
				<xsl:call-template name="parseFields">
					<xsl:with-param name="fieldsList" select="$segmentFields"/>
					<xsl:with-param name="segmentIdentifier" select="$segmentFields[1]"/>
					<xsl:with-param name="isSegment" select="true()"/>
					<xsl:with-param name="segmentProfile" select="$segmentProfile"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!-- Formats Fields of each segment -->
	<xsl:template name="parseFields">
		<xsl:param name="fieldsList"/>
		<xsl:param name="segmentIdentifier"/>
		<xsl:param name="isSegment"/>
		<xsl:param name="fieldRepeatStage"/>
		<xsl:param name="segmentProfile" as="node()*"/>
		<xsl:choose>
			<xsl:when test="$isSegment and $segmentIdentifier='MSH'">
				<xsl:for-each select="$fieldsList">
					<xsl:choose>
						<xsl:when test="position() &gt; 2 and string-length(.) &gt; 0">
							<xsl:call-template name="parseField">
								<xsl:with-param name="fieldData" select="."/>
								<xsl:with-param name="fieldRepeatStage" select="$fieldRepeatStage"/>
								<xsl:with-param name="isSegment" select="false()"/>
								<xsl:with-param name="segmentIdentifier" select="$segmentIdentifier"/>
								<xsl:with-param name="segmentProfile" select="$segmentProfile"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="$isSegment">
				<xsl:for-each select="$fieldsList[position() &gt; 1]">
					<xsl:if test="string-length(.) &gt; 0">
						<xsl:call-template name="parseField">
							<xsl:with-param name="fieldData" select="."/>
							<xsl:with-param name="fieldRepeatStage" select="$fieldRepeatStage"/>
							<xsl:with-param name="isSegment" select="false()"/>
							<xsl:with-param name="segmentIdentifier" select="$segmentIdentifier"/>
							<xsl:with-param name="segmentProfile" select="$segmentProfile"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$fieldsList">
					<xsl:if test="string-length(.) &gt; 0">
						<xsl:call-template name="parseField">
							<xsl:with-param name="fieldData" select="."/>
							<xsl:with-param name="fieldRepeatStage" select="$fieldRepeatStage"/>
							<xsl:with-param name="isSegment" select="false()"/>
							<xsl:with-param name="segmentIdentifier" select="$segmentIdentifier"/>
							<xsl:with-param name="segmentProfile" select="$segmentProfile"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="parseField">
		<xsl:param name="segmentIdentifier"/>
		<xsl:param name="isSegment"/>
		<xsl:param name="fieldRepeatStage"/>
		<xsl:param name="fieldData"/>
		<xsl:param name="segmentProfile" as="node()*"/>
		<xsl:variable name="segPath">
			<xsl:choose>
				<xsl:when test="$isSegment">
					<xsl:value-of select="concat($segmentIdentifier,'.',position())"/>
					
				</xsl:when>
				<xsl:when test="string-length($fieldRepeatStage) = 0">
					<xsl:value-of select="concat($segmentIdentifier,'.',position())"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($segmentIdentifier,'.',$fieldRepeatStage)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="currentFieldStage">
			<xsl:choose>
				<xsl:when test="string-length($fieldRepeatStage) &gt; 0">
					<xsl:value-of select="$fieldRepeatStage"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="position()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="fieldProfile" as="node()*">
			<xsl:choose>
				<xsl:when test="count($segmentProfile) &gt;1">
					<xsl:copy-of select="$segmentProfile[1]/Field[position()=$currentFieldStage]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="$segmentProfile/Field[position()=$currentFieldStage]"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="matches(.,$fieldRepeatSplitter)">
				<xsl:call-template name="parseFields">
					<xsl:with-param name="fieldsList" select="tokenize(.,$fieldRepeatSplitter)"/>
					<xsl:with-param name="segmentIdentifier" select="$segmentIdentifier"/>
					<xsl:with-param name="isSegment" select="false()"/>
					<xsl:with-param name="fieldRepeatStage" select="$currentFieldStage"/>
					<xsl:with-param name="segmentProfile" select="$segmentProfile"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		<xsl:variable name="isFieldRepeated" select="matches(.,$fieldRepeatSplitter)"/>
		<xsl:choose>
			<xsl:when test="not($isFieldRepeated) and util:isPassesFilter(.,$segPath)">
			<xsl:text>&#xd;</xsl:text>
				<xsl:element name="{$segPath}">
					<xsl:choose>
						<xsl:when test="matches(.,$componentSplitter)">
							<xsl:call-template name="parseComponent">
								<xsl:with-param name="componentList" select="tokenize(.,$componentSplitter)"/>
								<xsl:with-param name="fieldStage" select="$currentFieldStage"/>
								<xsl:with-param name="segmentID" select="$segmentIdentifier"/>
								<xsl:with-param name="segmentPath" select="$segPath"/>
								<xsl:with-param name="fieldProfile" select="$fieldProfile"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="util:isPassesFilter(.,$segPath)">
							<xsl:value-of select="."/>
						</xsl:when>
					</xsl:choose>
				</xsl:element><xsl:text>&#xd;</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Formats the components for each Field -->
	<xsl:template name="parseComponent">
		<xsl:param name="componentList"/>
		<xsl:param name="fieldStage"/>
		<xsl:param name="segmentID"/>
		<xsl:param name="segmentPath"/>
		<xsl:param name="fieldProfile"/>
		<xsl:for-each select="$componentList">
			<xsl:variable name="compPath" select="concat($segmentPath,'.',position())"/>
			<xsl:variable name="currentComponentStage" select="position()"/>
			<xsl:choose>
				<xsl:when test="matches(.,$subComponentSplitter) and util:isPassesFilter(.,$compPath) and string-length(.) &gt; 0">
					<xsl:text>&#xd;</xsl:text>
					<xsl:element name="{$compPath}">
						<xsl:call-template name="parseSubComponent">
							<xsl:with-param name="subComponentList" select="tokenize(.,$subComponentSplitter)"/>
							<xsl:with-param name="componentStage" select="position()"/>
							<xsl:with-param name="segmentID" select="$segmentID"/>
							<xsl:with-param name="componentPath" select="$compPath"/>
							<xsl:with-param name="fieldStage" select="$fieldStage"/>
							<xsl:with-param name="fieldProfile" select="$fieldProfile"/>
						</xsl:call-template>
					</xsl:element> <xsl:text>&#xd;</xsl:text>
				</xsl:when>
				<xsl:when test="util:isPassesFilter(.,$compPath) and string-length(.) &gt; 0">
					<xsl:text>&#xd;</xsl:text>
					<xsl:element name="{$compPath}">
						<xsl:value-of select="."/>
					</xsl:element><xsl:text>&#xd;</xsl:text>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<!-- Formats components within components -->
	<xsl:template name="parseSubComponent">
		<xsl:param name="subComponentList"/>
		<xsl:param name="componentStage"/>
		<xsl:param name="segmentID"/>
		<xsl:param name="componentPath"/>
		<xsl:param name="fieldStage"/>
		<xsl:param name="fieldProfile"/>
		<xsl:for-each select="$subComponentList">
			<xsl:variable name="subCompPath" select="concat($componentPath,'.',position())"/>
			<xsl:choose>
				<xsl:when test="util:isPassesFilter(.,$subCompPath) and string-length(.) &gt; 0">
					<xsl:element name="{$subCompPath}">
						<xsl:variable name="subCompStage" select="position()"/>
						<xsl:value-of select="."/>
					</xsl:element>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
