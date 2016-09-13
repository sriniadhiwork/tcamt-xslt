<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="" exclude-result-prefixes="xs" version="2.0">
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  util: generic functions for string manipulations  -->
	<!-- format-trailing: add the padding if non-empty; called from format-with-space -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:formatData">
		<xsl:param name="content"/>
		<xsl:param name="colspan"/>
		<xsl:variable name="formattedData">
			<xsl:choose>
				<xsl:when test="string-length(normalize-space($content)) = 0">
					<td colspan="{$colspan}" class="noData"/>
				</xsl:when>
				<xsl:otherwise>
					<td colspan="{$colspan}">
						<xsl:value-of select="$content"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:copy-of select="$formattedData"/>
	</xsl:function>
	<xsl:function name="util:parseDate">
		<xsl:param name="elementDataIn"/>
		<xsl:variable name="elementData" select="concat($elementDataIn, '                ')"/>
		<xsl:if test="string-length(normalize-space($elementData)) > 0">
			<xsl:variable name="year" select="concat(substring($elementData, 1, 4), '/')"/>
			<xsl:variable name="month" select="concat(substring($elementData, 5, 2), '/')"/>
			<xsl:variable name="day" select="substring($elementData, 7, 2)"/>
			<xsl:value-of select="concat($year, $month, $day)"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:dateFormat">
		<xsl:param name="data"/>
		<xsl:variable name="Date" select="concat($data, ' ')"/>
		<xsl:if test="string-length(normalize-space($Date)) > 0">
			<xsl:variable name="year" select="concat(substring($Date, 1, 4), '/')"/>
			<xsl:variable name="month" select="concat(substring($Date, 5, 2), '/')"/>
			<xsl:variable name="day" select="substring($Date, 7, 2)"/>
			<xsl:value-of select="concat($year, $month, $day)"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:fillStatus">
		<xsl:param name="fill"/>
		<xsl:choose>
			<xsl:when test="$fill = 'AJ'">
				<xsl:value-of select="'AJ-Patient has picked up partial fill of prescription'"/>
			</xsl:when>
			<xsl:when test="$fill = 'AK'">
				<xsl:value-of select="'AK-Patient has not picked up prescription'"/>
			</xsl:when>
			<xsl:when test="$fill = 'AH'">
				<xsl:value-of select="'AH-Patient has picked up prescription'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$fill"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:chngRequestType">
		<xsl:param name="requestType"/>
		<xsl:choose>
			<xsl:when test="$requestType = 'G'">
				<xsl:value-of select="'G - Generic Substitution'"/>
			</xsl:when>
			<xsl:when test="$requestType = 'T'">
				<xsl:value-of select="'T - Therapeutic Interchange/Substitution'"/>
			</xsl:when>
			<xsl:when test="$requestType = 'P'">
				<xsl:value-of select="'P - Prior Authorization Required'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$requestType"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:response">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$code = 'A'">
				<xsl:value-of select="'A - Approved'"/>
			</xsl:when>
			<xsl:when test="$code = 'D'">
				<xsl:value-of select="'D - Denied'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:gender">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$code = 'F'">
				<xsl:value-of select="'Female'"/>
			</xsl:when>
			<xsl:when test="$code = 'M'">
				<xsl:value-of select="'Male'"/>
			</xsl:when>
			<xsl:when test="$code = 'U'">
				<xsl:value-of select="'Unknown/undifferentiated'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:format-tel">
		<xsl:param name="phonenumberin"/>
		<!-- pad it so that length problems don't happen -->
		<xsl:variable name="phonenumber" select="concat($phonenumberin, '                ')"/>
		<xsl:if test="$phonenumber != ''">
			<xsl:variable name="areaCode" select="concat('(', substring($phonenumber, 1, 3), ')')"/>
			<xsl:variable name="localCode" select="concat(substring($phonenumber, 4, 3), '-')"/>
			<xsl:variable name="idCode" select="substring($phonenumber, 7, 10)"/>
			<xsl:value-of select="concat($areaCode, $localCode, $idCode)"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:codeDescription">
		<xsl:param name="value"/>
		<xsl:param name="tableName"/>
		<xsl:choose>
			<xsl:when test="$CodeTables/Tables/TableDefinition[@Id = $tableName]/t[@c = $value]">
				<xsl:value-of select="concat($value, ' ', '-', ' ', '(', $CodeTables/Tables/TableDefinition[@Id = $tableName]/t[@c = $value]/@d, ')')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

</xsl:stylesheet>
