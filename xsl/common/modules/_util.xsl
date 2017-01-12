<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns="http://www.w3.org/1999/xhtml"
	xpath-default-namespace="" exclude-result-prefixes="xs" version="2.0">
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
	<xsl:function name="util:format-trailing">
		<xsl:param name="value"/>
		<xsl:param name="padding"/>
		<xsl:value-of select="$value"/>
		<xsl:if test="$value != ''">
			<xsl:value-of select="$padding"/>
		</xsl:if>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- add a trailing space if non empty -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:format-with-space">
		<xsl:param name="value"/>
		<xsl:value-of select="util:format-trailing($value, ' ')"/>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- format-tel: take a string and format it as (abc)efg-higk -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:format-tel">
		<xsl:param name="areacode"/>
		<xsl:param name="phonenumberin"/>
		<!-- pad it so that length problems don't happen -->
		<xsl:variable name="phonenumber" select="concat($phonenumberin, '                ')"/>
		<xsl:if test="$areacode != '' and $phonenumber != ''">
			<xsl:variable name="areaCode" select="concat('(', $areacode, ')')"/>
			<xsl:variable name="localCode" select="concat(substring($phonenumber, 1, 3), '-')"/>
			<xsl:variable name="idCode" select="substring($phonenumber, 4, 4)"/>
			<xsl:value-of select="concat($areaCode, $localCode, $idCode)"/>
		</xsl:if>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- format-address: concatenate the individual elements, adding spaces when necessary -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:format-address">
		<xsl:param name="street"/>
		<xsl:param name="city"/>
		<xsl:param name="state"/>
		<xsl:param name="zip"/>
		<xsl:param name="country"/>
		<xsl:value-of
			select="concat(util:format-with-space($street), util:format-with-space($city), util:format-with-space($state), util:format-with-space($zip), util:format-with-space($country))"
		/>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- format-address-multi-lines: concatenate the individual elements, adding spaces when necessary -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:format-address-multilines">
		<xsl:param name="elementName"/>
		<xsl:param name="street1"/>
		<xsl:param name="street2"/>
		<xsl:param name="cityStateZip"/>
		<xsl:param name="country"/>
		<xsl:param name="ind"/>
		<xsl:value-of select="util:element($elementName, concat($street1, '&lt;br&gt;', $street2, '&lt;br&gt;', $cityStateZip ,'&lt;br&gt;', $country), $ind)"/>
		<!--<xsl:value-of select="util:element(' ', $street2, $ind)"/>
		<xsl:value-of select="util:element(' ', $cityStateZip, $ind)"/>
		<xsl:value-of select="util:element(' ', $country, $ind)"/>-->


		<!--Note: $street1 is always displayed-->
		<!--Note2: count($variable[text()]) is 1 if there are data, 0 otherwise-->
		<!--		<xsl:if test="not(count($street1[text()]) + count($street2[text()]) + number(not(count($cityStateZip) = 0)) + count($country[text()]) = 0)">
			<xsl:variable name="rowspan" select="1 + count($street2[text()]) + number(not(count($cityStateZip) = 0)) + count($country[text()])"/> 
			
			<xsl:element name="tr">
				<xsl:element name="td">
					<xsl:attribute name="rowspan">
						<xsl:value-of select="$rowspan"/>
					</xsl:attribute>
					<xsl:value-of select="$elementName"/>
				</xsl:element>
				<xsl:element name="td">
					<xsl:if test="normalize-space($street1) = ''">
						<xsl:attribute name="noData"></xsl:attribute>
					</xsl:if>
					<xsl:value-of select="$street1"/>
				</xsl:element>
			</xsl:element>
			<xsl:if test="not(normalize-space($street2) = '')">
				<xsl:element name="tr">
					<xsl:element name="td">
						<xsl:value-of select="$street2"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<xsl:if test="not(count($cityStateZip) = 0)">
				<xsl:element name="tr">
					<xsl:element name="td">
						<xsl:value-of select="$cityStateZip"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<xsl:if test="not(normalize-space($country) = '')">
				<xsl:element name="tr">
					<xsl:element name="td">
						<xsl:value-of select="$country"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
		</xsl:if>-->
	</xsl:function>


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:chooseAmongThree">
		<xsl:param name="elementName"/>
		<xsl:param name="option1"/>
		<xsl:param name="option2"/>
		<xsl:param name="option3"/>
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="count($option1) > 0">
				<xsl:value-of select="util:element($elementName, $option1, $ind)"/>
			</xsl:when>
			<xsl:when test="count($option1) = 0 and count($option2) > 0">
				<xsl:value-of select="util:element($elementName, $option2, $ind)"/>
			</xsl:when>
			<xsl:when test="count($option1) = 0 and count($option2) = 0 and count($option3) > 0">
				<xsl:value-of select="util:element($elementName, $option3, $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:element($elementName, '', $ind)"/>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- tags: most important functions; if you pass X, Y, and indentation it outputs <X> Y </X> ; if Y is empty, however, it produces only <X>  -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:tags">
		<xsl:param name="tag"/>
		<xsl:param name="content"/>
		<xsl:param name="ind"/>
		<xsl:value-of select="concat($nl, $ind)"/>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>
		<xsl:value-of select="$tag"/>
		<xsl:text disable-output-escaping="yes">></xsl:text>
		<xsl:value-of select="$content"/>
		<xsl:text disable-output-escaping="yes">&lt;/</xsl:text>
		<xsl:value-of select="$tag"/>
		<xsl:text disable-output-escaping="yes">></xsl:text>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:tag">
		<xsl:param name="tag"/>
		<xsl:param name="ind"/>
		<xsl:value-of select="concat($nl, $ind)"/>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>
		<xsl:value-of select="$tag"/>
		<xsl:text disable-output-escaping="yes">></xsl:text>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  format-date: takes a string and makes it a date mm/nn/yyyy -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:format-date">
		<xsl:param name="elementDataIn"/>
		<!-- pad it so that length problems don't happen -->
		<xsl:variable name="elementData" select="concat($elementDataIn, '                  ')"/>
		<xsl:if test="string-length(normalize-space($elementData)) > 0">
			<xsl:variable name="year" select="substring($elementData, 1, 4)"/>
			<xsl:variable name="month" select="concat(substring($elementData, 5, 2), '/')"/>
			<xsl:variable name="day" select="concat(substring($elementData, 7, 2), '/')"/>
			<xsl:variable name="hour" select="concat(' ', substring($elementData, 9, 2), ':')"/>
			<xsl:variable name="min" select="concat(substring($elementData, 11, 2), ' ')"/>
			<xsl:variable name="time">
				<xsl:if test="string-length(normalize-space($elementDataIn)) > 11">
					<xsl:value-of select="concat($hour, $min)"/>
				</xsl:if>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="not(normalize-space(substring($elementData, 5, 2)) = '')">
					<xsl:value-of select="concat($month, $day, $year, $time)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$year"/>
				</xsl:otherwise>
			</xsl:choose>
			<!-- <xsl:value-of select="format-date(xs:date(concat($month,$day,$year)),'[D1o] 
				[MNn], [Y]', 'en', (), ())"/> -->
		</xsl:if>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:format-time">
		<xsl:param name="time"/>

		<xsl:choose>
			<xsl:when test="string-length(normalize-space($time)) &lt; 9">
				<xsl:value-of select="util:format-date($time)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="year" select="substring($time, 1, 4)"/>
				<xsl:variable name="month" select="concat(substring($time, 5, 2), '/')"/>
				<xsl:variable name="day" select="concat(substring($time, 7, 2), '/')"/>
				<xsl:variable name="hrs" select="substring($time, 9, 2)"/>
				<xsl:variable name="cHrs">
					<xsl:choose>
						<xsl:when test="number($hrs) > 12">
							<xsl:variable name="tHr" select="number($hrs) - 12"/>
							<xsl:choose>
								<xsl:when test="string-length(string($tHr)) = 1">
									<xsl:value-of select="concat('0', $tHr)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$tHr"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="number($hrs) &lt; 12 or number($hrs) = 12">
							<xsl:value-of select="$hrs"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="AM-PM">
					<xsl:choose>
						<xsl:when test="number($hrs) > 12 or number($hrs) = 12">
							<xsl:value-of select="'PM'"/>
						</xsl:when>
						<xsl:when test="number($hrs) &lt; 12">
							<xsl:value-of select="'AM'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="mins" select="concat(':', substring($time, 11, 2))"/>

				<xsl:if test="string-length(normalize-space($time)) > 13">
					<xsl:variable name="secs" select="concat(':', substring($time, 13, 2))"/>
					<xsl:variable name="time-format" select="concat($cHrs, $mins, $secs)"/>
					<!--<xsl:variable name="time-format"
						select="format-time(xs:time(concat($cHrs, $mins, $secs)), '[H]:[m]:[s]')"/>-->
					<xsl:value-of
						select="concat($month, $day, $year, ' ', $time-format, ' ', $AM-PM)"/>
				</xsl:if>
				<xsl:if test="string-length(normalize-space($time)) &lt; 13">
					<xsl:variable name="time-format" select="concat($cHrs, $mins)"/>
					<xsl:value-of
						select="concat($month, $day, $year, ' ', $time-format, ' ', $AM-PM)"/>
				</xsl:if>


			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- start:  output <div class='test-data-specs'> or if json,   { "profile" : "name-of-profile", "tables" : [ -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:start">
		<xsl:param name="profile"/>
		<xsl:param name="div"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<!-- output version number and profile info at the start with the comment -->
				<xsl:variable name="comment-string">
					<xsl:value-of select="'!-- generated by common_tdspec.xslt Version:'"/>
					<xsl:value-of select="$version"/>
					<xsl:value-of select="'   Profile:'"/>
					<xsl:value-of select="$profile"/>
					<xsl:value-of select="'--'"/>
				</xsl:variable>
				<xsl:value-of select="util:tag($comment-string, '')"/>
				<xsl:value-of select="util:tag('fieldset', '')"/>
				<xsl:value-of select="util:tag(concat('div class=&quot;', $div, '&quot;'), '')"/>
				<!-- generate tabset outer block for angular -->
				<xsl:if test="$output = 'ng-tab-html'">
					<xsl:value-of select="util:tag('tabset', '')"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat('{', $nl, '&quot;version&quot; : &quot;', $version, '&quot;,', $nl, '&quot;profile&quot; : &quot;', $profile, '&quot;,', $nl, '&quot;tables&quot;:', $nl, '[', $nl)"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- begin-sub-table: end previous table with </table></fieldset> so as to prepare for the obx table; in case of json, add an element 
		{"element" : "obx", "data" : -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:begin-sub-table">
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html"> </xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat($nl, $ind, '{&quot;element&quot; : &quot;obx&quot;, &quot;data&quot; : ', $nl)"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- end-obx-group:  add a gray line <tr class='obxGrpSpl'> <td colspan="2"></td></tr> and an empty element/data pair in case of json -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:end-obx-group">
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:value-of select="util:tag('tr class=''obxGrpSpl''', $ind)"/>
				<xsl:value-of select="util:tag('td colspan=''2''', $ind)"/>
				<xsl:value-of select="util:tag('/td', $ind)"/>
				<xsl:value-of select="util:tag('/tr', $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:element('', '', $ind)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- some useful variables -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:variable name="indent" select="'&#9;'"/>
	<xsl:variable name="nl" select="'&#10;'"/>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- title: <fieldset> <legend> title </legend> in case of html; in case of json,  { "title" : "param-name", -->
	<!-- note that the function last-element ends the table, but the param endprevioustable generates </table></fieldset> if the previous table is open (as in the case of starting OBX) -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:title">
		<xsl:param name="name"/>
		<xsl:param name="tabname"/>
		<xsl:param name="value"/>
		<xsl:param name="ind"/>
		<xsl:param name="endprevioustable" as="xs:boolean"/>
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="full" as="xs:boolean"/>
		<xsl:value-of
			select="util:_title($name, $tabname, $value, '', $ind, $endprevioustable, $vertical-orientation, $full)"
		/>
	</xsl:function>


	<xsl:function name="util:_title">
		<xsl:param name="name"/>
		<xsl:param name="tabname"/>
		<xsl:param name="value"/>
		<xsl:param name="additionalvalue"/>
		<xsl:param name="ind"/>
		<xsl:param name="endprevioustable" as="xs:boolean"/>
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="full" as="xs:boolean"/>
		<xsl:variable name="prelude">
			<xsl:choose>
				<xsl:when test="$endprevioustable">
					<xsl:choose>
						<xsl:when test="$generate-plain-html">
							<xsl:value-of select="util:tag('/table', $ind)"/>
							<xsl:value-of select="util:tag('br/', $ind)"/>
							<xsl:value-of select="util:end-tab($ind, $vertical-orientation)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($ind, '},', $nl)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise> </xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:if test="not($full)">
					<xsl:value-of
						select="util:_begin-tab($tabname, $value, $additionalvalue, '', $vertical-orientation)"
					/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- json -->
				<xsl:value-of
					select="concat($prelude, $ind, '{', $nl, $ind, $indent, '&quot;', $name, '&quot;', ':', '&quot;', $value, '&quot;,', $nl)"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:title-no-tab">
		<xsl:param name="name"/>
		<xsl:param name="tabname"/>
		<xsl:param name="value"/>
		<xsl:param name="ind"/>
		<xsl:param name="endprevioustable" as="xs:boolean"/>
		<xsl:choose>
			<xsl:when test="$output = 'ng-tab-html'">
				<xsl:value-of select="util:tag('fieldset', $ind)"/>
				<xsl:value-of select="util:tags('legend', $value, $ind)"/>
			</xsl:when>
			<xsl:when test="$output = 'plain-html'">
				<xsl:value-of select="util:tag('fieldset', $ind)"/>
				<xsl:value-of select="util:tags('legend', $value, $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="util:title($name, $tabname, $value, $ind, $endprevioustable, false(), true())"/>
				<!-- [Caro] why call util:title in a function that is not supposed to produce tabs ? util:title DOES produce tabs under certain circumstances-->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:end-title-no-tab">
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$output = 'ng-tab-html'">
				<xsl:value-of select="util:tag('/fieldset', $ind)"/>
			</xsl:when>
			<xsl:otherwise> </xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:begin-tab">
		<xsl:param name="tabname"/>
		<xsl:param name="val"/>
		<xsl:param name="ind"/>
		<xsl:param name="vertical-orientation" as="xs:boolean"/>

		<xsl:value-of select="util:_begin-tab($tabname, $val, '', $ind, $vertical-orientation)"/>
	</xsl:function>


	<xsl:function name="util:_begin-tab">
		<xsl:param name="tabname"/>
		<xsl:param name="val"/>
		<xsl:param name="additionalval"/>
		<xsl:param name="ind"/>
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<!-- use the tabname to convert into a valid javascript variable name that is used to track open and close of the accordions -->
		<xsl:variable name="isOpenVar"
			select="concat('xsl', replace(replace($tabname, '-', ''), '[ \\-]', ''))"/>

		<xsl:choose>
			<xsl:when test="$output = 'ng-tab-html'">
				<xsl:value-of
					select="
						util:tag(concat(util:IfThenElse($vertical-orientation,
						concat('accordion-group class=&quot;panel-info&quot; type=&quot;pills&quot; style=&quot;margin-top:0;border: 1px ridge  #C6DEFF;&quot; is-open=&quot;', $isOpenVar, '&quot; '), 'tab'),
						util:IfThenElse($vertical-orientation, '', concat(' heading=&quot;', $tabname, '&quot; heading2=&quot;', $additionalval, '&quot; ')), ' vertical=&quot;', $vertical-orientation, '&quot;'), '')"/>
				<xsl:if test="$vertical-orientation">
					<xsl:value-of select="util:tag('accordion-heading', '')"/>
					<xsl:value-of select="util:tag('span class=&quot;clearfix&quot;', '')"/>
					<xsl:value-of
						select="util:tag('span class=&quot;accordion-heading pull-left&quot;', '')"/>
					<xsl:value-of
						select="util:tag(concat('i class=&quot;pull-left fa&quot; ng-class=&quot;{''fa-caret-down'': ', $isOpenVar, ', ''fa-caret-right'': !', $isOpenVar, '}&quot;'), '')"/>
					<xsl:value-of select="util:tag('/i', '')"/>
					<xsl:value-of select="$tabname"/>
					<xsl:value-of select="util:tag('/span', '')"/>
					<xsl:value-of select="util:tag('/span', '')"/>
					<xsl:value-of select="util:tag('/accordion-heading', '')"/>
				</xsl:if>
				<xsl:value-of select="util:tag('div class=&quot;panel panel-info&quot;', $ind)"/>
				<xsl:value-of select="util:tag('div class=&quot;panel-body&quot;', $ind)"/>
				<xsl:value-of select="util:tag('fieldset', $ind)"/>
			</xsl:when>
			<xsl:when test="$output = 'plain-html'">
				<xsl:value-of select="util:tag('fieldset', $ind)"/>
				<xsl:value-of select="util:tags('legend', $val, $ind)"/>
			</xsl:when>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:end-tab">
		<xsl:param name="ind"/>
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:choose>
			<xsl:when test="$output = 'ng-tab-html'">
				<xsl:value-of select="util:tag('/fieldset', '')"/>
				<xsl:value-of select="util:tag('/div', '')"/>
				<xsl:value-of select="util:tag('/div', '')"/>
				<xsl:value-of
					select="util:tag(util:IfThenElse($vertical-orientation, '/accordion-group', '/tab'), '')"
				/>
			</xsl:when>
			<xsl:when test="$output = 'plain-html'">
				<xsl:value-of select="util:tag('/fieldset', '')"/>
			</xsl:when>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- elements: <table><tr><th>Element </th> <th> Data </th> </tr> and "elements" : [   in case of json -->
	<xsl:function name="util:elements">
		<xsl:param name="ind"/>
		<xsl:value-of select="util:elements-with-colspan(2, $ind)"/>
	</xsl:function>


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- elements: <table><tr><th>Element </th> <th> Data </th> </tr> and "elements" : [   in case of json -->
	<xsl:function name="util:elements-with-colspan">
		<xsl:param name="cols" as="xs:integer"/>
		<xsl:param name="ind"/>

		<xsl:variable name="col1span" select="floor($cols div 2)"/>
		<xsl:variable name="col2span" select="$cols - $col1span"/>

		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:value-of select="util:tag('table', $ind)"/>
				<xsl:value-of select="util:tag('tr', $ind)"/>
				<xsl:value-of
					select="util:tag(concat('th colspan=&quot;', $col1span, '&quot;'), $ind)"/>
				<xsl:value-of select="'Element'"/>
				<xsl:value-of select="util:tag('/th', $ind)"/>
				<xsl:value-of
					select="util:tag(concat('th colspan=&quot;', $col2span, '&quot;'), $ind)"/>
				<xsl:value-of select="'Data'"/>
				<xsl:value-of select="util:tag('/th', $ind)"/>
				<xsl:value-of select="util:tag('/tr', $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat($ind, $indent, '&quot;elements&quot; : ', $nl, $ind, $indent, '[')"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>



	<xsl:function name="util:title-and-elements">
		<xsl:param name="title"/>
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:value-of select="util:tag('table', $ind)"/>
				<xsl:value-of select="util:tag('tr', $ind)"/>
				<xsl:value-of select="util:tag('th colspan=&quot;2&quot; ', $ind)"/>
				<xsl:value-of select="$title"/>
				<xsl:value-of select="util:tag('/th ', $ind)"/>
				<xsl:value-of select="util:tag('/tr', $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat($ind, $indent, '&quot;elements&quot; : ', $nl, $ind, $indent, '[')"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- elements: <table><tr><th>Element </th> <th> Data </th> </tr> and "elements" : [   in case of json -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:message-elements">
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:value-of select="util:tag('table', $ind)"/>
				<xsl:value-of select="util:tag('tr', $ind)"/>
				<xsl:value-of select="util:tags('th', 'Location', $ind)"/>
				<xsl:value-of select="util:tags('th', 'Data Element', $ind)"/>
				<xsl:value-of select="util:tags('th', 'Data', $ind)"/>
				<xsl:value-of select="util:tags('th', 'Categorization', $ind)"/>
				<xsl:value-of select="util:tag('/tr', $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat($ind, $indent, '&quot;elements&quot; : ', $nl, $ind, $indent, '[')"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- end-elements: </table></fieldset>  or just ] in case of json, to denote the end of the table -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:end-sub-table">
		<xsl:param name="ind"/>
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:variable name="end-elements">
					<xsl:value-of select="util:tag('/table', $ind)"/>
					<xsl:value-of select="util:tag('br/', $ind)"/>
					<xsl:value-of select="util:tag('/fieldset', $ind)"/>
					<xsl:value-of select="util:end-tab($ind, $vertical-orientation)"/>
				</xsl:variable>
				<xsl:value-of select="$end-elements"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat($nl, $indent, ']', $ind2, '}', $nl, $ind2, '}', $nl, $ind1, ']', $nl)"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- end-elements: </table></fieldset>  or just ] in case of json, to denote the end of the table -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:end-elements">
		<xsl:param name="ind"/>
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="full" as="xs:boolean"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:variable name="end-elements">
					<xsl:value-of select="util:tag('/table', $ind)"/>
					<xsl:value-of select="util:tag('br/', $ind)"/>
					<xsl:if test="not($full)">
						<xsl:value-of select="util:end-tab($ind, $vertical-orientation)"/>
					</xsl:if>
				</xsl:variable>
				<xsl:value-of select="$end-elements"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind, ']', $nl)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>



	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  element: calls element-with-delimiter with value , ; basically generates table row element -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:element">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="ind"/>
		<xsl:value-of select="util:element-with-delimiter($name, $value, ',', 2, $ind)"/>
	</xsl:function>

	<xsl:function name="util:element-var-cols">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="cols" as="xs:integer"/>
		<xsl:param name="ind"/>
		<xsl:value-of select="util:element-with-delimiter($name, $value, ',', $cols, $ind)"/>
	</xsl:function>

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- last-element: just like element, but also generates </table></fieldset> at the end, ] in case of json -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:last-element">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="ind"/>
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="full" as="xs:boolean"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:value-of select="util:element-with-delimiter($name, $value, '', 2, $ind)"/>
				<xsl:if test="not($full)">
					<xsl:value-of select="util:tag('/table', $ind)"/>
				</xsl:if>
				<xsl:value-of select="util:end-tab($ind, $vertical-orientation)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat(util:element-with-delimiter($name, $value, '', 2, $ind), $nl, $ind, $indent, ']', $nl)"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- last-element: just like element, but also generates </table></fieldset> at the end, ] in case of json -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:end-table">
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:value-of select="util:tag('/table', $ind)"/>
				<xsl:value-of select="util:tag('br/', $ind)"/>
			</xsl:when>
			<xsl:otherwise> </xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- last-element: just like element, but also generates </table></fieldset> at the end, ] in case of json -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:end-table-fieldset">
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:value-of select="util:tag('/table', $ind)"/>
				<xsl:value-of select="util:tag('br/', $ind)"/>
				<xsl:value-of select="util:tag('/fieldset', $ind)"/>
			</xsl:when>
			<xsl:otherwise> </xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  element: calls element-with-delimiter with value , ; basically generates table row element -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:single-element">
		<xsl:param name="name"/>
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:variable name="td-element">
					<xsl:value-of
						select="util:tag('td class=&quot;separator&quot; colspan=&quot;2&quot;', $ind)"/>
					<xsl:value-of select="$name"/>
					<xsl:value-of select="util:tag('/td', $ind)"/>
				</xsl:variable>
				<xsl:value-of select="util:tags('tr', $td-element, $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:element-with-delimiter($name, '', ',', 2, $ind)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- element-with-delimiter:  generates <tr> <td> name </td> <td> value </td> </tr>  (adds a class 'noData' to gray out if value is empty -->
	<!-- for json output, { "element" : "name", "value" : "value-of-the-element-param" } -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:element-with-delimiter">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="trailing"/>
		<xsl:param name="cols" as="xs:integer"/>
		<xsl:param name="ind"/>

		<xsl:if test="not(normalize-space($value) = '')">
			<xsl:variable name="col1span" select="floor($cols div 2)"/>
			<xsl:variable name="col2span" select="$cols - $col1span"/>
			<xsl:choose>
				<xsl:when test="$generate-plain-html">
					<xsl:variable name="td-element">
						<xsl:value-of
							select="util:tag(concat('td colspan=&quot;', $col1span, '&quot;'), $ind)"/>
						<xsl:value-of select="$name"/>
						<xsl:value-of select="util:tag('/td', $ind)"/>
						<xsl:choose>
							<xsl:when test="normalize-space($value) = ''">
								<xsl:value-of
									select="util:tag(concat('td class=''noData'' colspan=&quot;', $col2span, '&quot;'), $ind)"/>
								<xsl:value-of select="$value"/>
								<xsl:value-of select="util:tag('/td', $ind)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of
									select="util:tag(concat('td colspan=&quot;', $col2span, '&quot;'), $ind)"/>
								<xsl:value-of select="$value"/>
								<xsl:value-of select="util:tag('/td', $ind)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:value-of select="util:tags('tr', $td-element, $ind)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="concat($nl, $ind, $indent, $indent, '{&quot;element&quot; : &quot;', $name, '&quot;, &quot;data&quot; : &quot;', $value, '&quot;}', $trailing)"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:function>


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- element-with-delimiter:  generates <tr> <td> name </td> <td> value </td> </tr>  (adds a class 'noData' to gray out if value is empty -->
	<!-- for json output, { "element" : "name", "value" : "value-of-the-element-param" } -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:message-element-with-delimiter">
		<xsl:param name="location"/>
		<xsl:param name="dataelement"/>
		<xsl:param name="data"/>
		<xsl:param name="categorization"/>
		<xsl:param name="trailing"/>
		<xsl:param name="ind"/>
		<xsl:param name="item-hierarchy"/>
		<xsl:variable name="isField" as="xs:boolean" select="$item-hierarchy = 'Field'"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:variable name="td-element">
					<xsl:value-of
						select="util:tag(concat('td class=&quot;', $item-hierarchy, '&quot;'), $ind)"/>
					<xsl:value-of
						select="concat(substring($location, 1, 3), '-', substring($location, 5, string-length($location) - 4))"/>
					<xsl:value-of select="util:tag('/td', $ind)"/>
					<xsl:value-of
						select="util:tag(concat('td class=&quot;', $item-hierarchy, '&quot;'), $ind)"/>
					<xsl:value-of select="$dataelement"/>
					<xsl:value-of select="util:tag('/td', $ind)"/>
					<xsl:value-of
						select="util:tag(concat('td class=&quot;', util:IfThenElse($isField, $item-hierarchy, util:IfEmptyThenElse($data, 'noData', 'Data')), '&quot;'), $ind)"/>
					<xsl:value-of select="$data"/>
					<xsl:value-of select="util:tag('/td', $ind)"/>
					<xsl:value-of
						select="util:tag(concat('td class=&quot;', util:IfThenElse($isField, $item-hierarchy, util:IfEmptyThenElse($categorization, 'noData', 'Data')), '&quot;'), $ind)"/>
					<xsl:value-of select="$categorization"/>
					<xsl:value-of select="util:tag('/td', $ind)"/>
				</xsl:variable>
				<xsl:value-of select="util:tags('tr', $td-element, $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="
						concat($nl, $ind, $indent, $indent,
						'{&quot;location&quot; : &quot;', $location, '&quot;, &quot;dataelement&quot; : &quot;', $dataelement, '&quot;, &quot;data&quot; : &quot;', $data, '&quot;, &quot;categorization&quot; : &quot;', $categorization, '&quot;}', $trailing)"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- end: </div> to end the test-data-specs div; for json }]} to end the array of tables -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:end">
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:if test="$output = 'ng-tab-html'">
					<xsl:value-of select="util:tag('/tabset', '')"/>
				</xsl:if>
				<xsl:value-of select="util:tag('/div', $ind)"/>
				<xsl:value-of select="util:tag('/fieldset', '')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($nl, $ind, '}', $nl, ']', $nl, '}')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- blank-if-1 -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:blank-if-1">
		<xsl:param name="pos"/>
		<xsl:param name="total"/>
		<xsl:choose>
			<xsl:when test="$total = 1"> </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$pos"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- blank-if-1-variant2 -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:blank-if-1-variant2">
		<xsl:param name="pos"/>
		<xsl:param name="total"/>
		<xsl:choose>
			<xsl:when test="$pos = 1"> </xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('[', $pos, ']')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:action-code">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$code = 'A'">
				<xsl:value-of select="'Add'"/>
			</xsl:when>
			<xsl:when test="$code = 'D'">
				<xsl:value-of select="'Delete'"/>
			</xsl:when>
			<xsl:when test="$code = 'U'">
				<xsl:value-of select="'Update'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:admin-sex">
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
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:protection-indicator">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$code = 'N'">
				<xsl:value-of select="'No'"/>
			</xsl:when>
			<xsl:when test="$code = 'Y'">
				<xsl:value-of select="'Yes'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:IfEmptyThenElse">
		<xsl:param name="data"/>
		<xsl:param name="ifData"/>
		<xsl:param name="ifNotData"/>
		<xsl:choose>
			<xsl:when test="normalize-space($data) = ''">
				<xsl:value-of select="$ifData"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$ifNotData"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:IfThenElse">
		<xsl:param name="cond" as="xs:boolean"/>
		<xsl:param name="ifData"/>
		<xsl:param name="ifNotData"/>
		<xsl:choose>
			<xsl:when test="$cond">
				<xsl:value-of select="$ifData"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$ifNotData"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:valueset">
		<xsl:param name="key"/>
		<xsl:param name="tablename"/>
		<xsl:if test="count($HL7Tables/Tables/TableDefinition[@Id = $tablename]/t[@c = $key]) = 0"> </xsl:if>
		<xsl:value-of select="$HL7Tables/Tables/TableDefinition[@Id = $tablename]/t[@c = $key]/@d"/>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:valueset2">
		<xsl:param name="key"/>
		<xsl:param name="table"/>
		<xsl:value-of select="$table/t[@c = $key]/@d"/>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:union">
		<xsl:param name="table1"/>
		<xsl:param name="table2"/>
		<xsl:value-of select="$table1 | $table2"/>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:table">
		<xsl:param name="tablename"/>
		<xsl:value-of select="$HL7Tables/Tables/TableDefinition[@Id = $tablename]"/>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:value-or-valueset">
		<xsl:param name="val"/>
		<xsl:param name="key"/>
		<xsl:param name="tablename"/>
		<xsl:choose>
			<xsl:when test="string-length(normalize-space($val)) = 0">
				<xsl:value-of select="util:valueset($key, $tablename)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$val"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:strip-tabsets">
		<xsl:param name="html"/>
		<xsl:variable name="pass1"
			select="replace($html, 'tab heading=&quot;([^&quot;]*)&quot; *heading2=&quot;([^&quot;]*)&quot; *vertical=&quot;false&quot;', 'fieldset> &lt;legend> $1 &lt;/legend')"/>
		<xsl:variable name="pass2" select="replace($pass1, '/tab>', '/fieldset>')"/>
		<xsl:variable name="pass3"
			select="replace($pass2, 'span class=&quot;accordion-heading pull-left&quot;', 'span')"/>
		<xsl:variable name="pass4"
			select="replace($pass3, 'i class=&quot;pull-left fa&quot; ng-', 'i ')"/>
		<xsl:variable name="pass5" select="replace($pass4, 'accordion-heading', 'legend')"/>
		<xsl:value-of
			select="
				replace(replace($pass5, '(&lt;tab heading=&quot;.*&quot;)|(&lt;tabset)|(&lt;accordion((-group)|(-heading))?)', '&lt;diV'),
				'(&lt;/tab>)|(&lt;/tabset>)|(&lt;/accordion((-group)|(-heading))?>)', '&lt;/div>')"
		/>
	</xsl:function>


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:strip-tabsets2">
		<xsl:param name="html"/>

		<xsl:variable name="isOpenVar" select="'xslfulltab$2'"/>
		<xsl:variable name="vertical-orientation" select="true()"/>
		<xsl:variable name="accordion-block">
			<xsl:value-of
				select="
					util:tag(concat(util:IfThenElse($vertical-orientation,
					concat('accordion-group class=&quot;panel-info&quot; type=&quot;pills&quot; style=&quot;margin-top:0;border: 1px ridge  #C6DEFF;&quot; is-open=&quot;', $isOpenVar, '&quot; '), 'tab'),
					util:IfThenElse($vertical-orientation, '', concat(' heading=&quot;', '$1', '&quot; ')), ' vertical=&quot;', $vertical-orientation, '&quot;'), '')"/>
			<xsl:value-of select="util:tag('accordion-heading', '')"/>
			<xsl:value-of select="util:tag('span class=&quot;clearfix&quot;', '')"/>
			<xsl:value-of
				select="util:tag('span class=&quot;accordion-heading pull-left&quot;', '')"/>
			<xsl:value-of
				select="util:tag(concat('i class=&quot;pull-left fa&quot; ng-class=&quot;{''fa-caret-down'': ', $isOpenVar, ', ''fa-caret-right'': !', $isOpenVar, '}&quot;'), '')"/>
			<xsl:value-of select="util:tag('/i', '')"/>
			<xsl:value-of select="'$2'"/>
			<xsl:value-of select="util:tag('/span', '')"/>
			<xsl:value-of select="util:tag('/span', '')"/>
			<xsl:value-of select="util:tag('/accordion-heading', '')"/>
		</xsl:variable>

		<xsl:variable name="pass1"
			select="replace($html, '&lt;tab heading=&quot;([^&quot;]*)&quot; *heading2=&quot;([^&quot;]*)&quot; *vertical=&quot;false&quot;>', $accordion-block)"/>
		<xsl:variable name="pass2" select="replace($pass1, '/tab>', '/accordion-group>')"/>
		<xs:value-of select="$pass2"/>
		<xsl:value-of select="$pass2"/>
	</xsl:function>


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:segdesc">
		<xsl:param name="seg"/>
		<xsl:choose>
			<xsl:when test="$seg = 'PID'">
				<xsl:value-of select="'Patient Information'"/>
			</xsl:when>
			<xsl:when test="$seg = 'PV1'">
				<xsl:value-of select="'Patient Visit Information'"/>
			</xsl:when>
			<xsl:when test="$seg = 'NK1'">
				<xsl:value-of select="'Next of kin'"/>
			</xsl:when>
			<xsl:when test="$seg = 'OBX'">
				<xsl:value-of select="'Observations'"/>
			</xsl:when>
			<xsl:when test="$seg = 'ACK'">
				<xsl:value-of select="'Acknowledgment'"/>
			</xsl:when>
			<xsl:when test="$seg = 'ERR'">
				<xsl:value-of select="'Error'"/>
			</xsl:when>
			<xsl:when test="$seg = 'ORC'">
				<xsl:value-of select="'Order'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'Other'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:completion-status">
		<xsl:param name="status"/>
		<xsl:choose>
			<xsl:when test="$status = 'CP'">
				<xsl:value-of select="'Complete'"/>
			</xsl:when>
			<xsl:when test="$status = 'NA'">
				<xsl:value-of select="'Not Administered'"/>
			</xsl:when>
			<xsl:when test="$status = 'PA'">
				<xsl:value-of select="'Partially Administered'"/>
			</xsl:when>
			<xsl:when test="$status = 'RE'">
				<xsl:value-of select="'Refused'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$status"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:imm-reg-status">
		<xsl:param name="status"/>
		<xsl:choose>
			<xsl:when test="$status = 'A'">
				<xsl:value-of select="'Active'"/>
			</xsl:when>
			<xsl:when test="$status = 'I'">
				<xsl:value-of select="'Inactive'"/>
			</xsl:when>
			<xsl:when test="$status = 'L'">
				<xsl:value-of select="'Inactive-Lost to follow-up (cannot contact)'"/>
			</xsl:when>
			<xsl:when test="$status = 'M'">
				<xsl:value-of select="'Inactive-Lost to follow-up (cannot contact)'"/>
			</xsl:when>
			<xsl:when test="$status = 'P'">
				<xsl:value-of
					select="'Inactive-Permanently inactive (do not re-activate or add new entries to this record)'"
				/>
			</xsl:when>
			<xsl:when test="$status = 'U'">
				<xsl:value-of select="'Unknown'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$status"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:sub-refusal-reason">
		<xsl:param name="status"/>
		<xsl:choose>
			<xsl:when test="$status = '00'">
				<xsl:value-of select="'Parental decision'"/>
			</xsl:when>
			<xsl:when test="$status = '01'">
				<xsl:value-of select="'Religious exemption'"/>
			</xsl:when>
			<xsl:when test="$status = '02'">
				<xsl:value-of select="'Other'"/>
			</xsl:when>
			<xsl:when test="$status = '03'">
				<xsl:value-of select="'Patient decision'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$status"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>


	<xsl:function name="util:yes-no">
		<xsl:param name="val"/>
		<xsl:choose>
			<xsl:when test="$val = '1' or $val = 'y' or $val = 'Y'">
				<xsl:value-of select="'Yes'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'No'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xsl:function name="util:or5">
		<xsl:param name="val1"/>
		<xsl:param name="val2"/>
		<xsl:param name="val3"/>
		<xsl:param name="val4"/>
		<xsl:param name="val5"/>
		<xsl:choose>
			<xsl:when test="normalize-space($val1) != ''">
				<xsl:value-of select="$val1"/>
			</xsl:when>
			<xsl:when test="normalize-space($val2) != ''">
				<xsl:value-of select="$val2"/>
			</xsl:when>
			<xsl:when test="normalize-space($val3) != ''">
				<xsl:value-of select="$val3"/>
			</xsl:when>
			<xsl:when test="normalize-space($val4) != ''">
				<xsl:value-of select="$val4"/>
			</xsl:when>
			<xsl:when test="normalize-space($val5) != ''">
				<xsl:value-of select="$val5"/>
			</xsl:when>
		</xsl:choose>
	</xsl:function>

	<xsl:function name="util:element1">
		<xsl:param name="val"/>
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="normalize-space($val) = ''">
				<xsl:value-of select="util:tag('td class=''noData''', $ind)"/>
				<xsl:value-of select="$val"/>
				<xsl:value-of select="util:tag('/td', $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:tags('td', $val, $ind)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xsl:function name="util:elements9-header">
		<xsl:param name="val1"/>
		<xsl:param name="val2"/>
		<xsl:param name="val3"/>
		<xsl:param name="val4"/>
		<xsl:param name="val5"/>
		<xsl:param name="val6"/>
		<xsl:param name="val7"/>
		<xsl:param name="val8"/>
		<xsl:param name="val9"/>
		<xsl:param name="ind"/>

		<xsl:value-of
			select="util:elements9($val1, $val2, $val3, $val4, $val5, $val6, $val7, $val8, $val9, ' class=&quot;separator&quot; ', $ind)"
		/>
	</xsl:function>

	<xsl:function name="util:elements9">
		<xsl:param name="val1"/>
		<xsl:param name="val2"/>
		<xsl:param name="val3"/>
		<xsl:param name="val4"/>
		<xsl:param name="val5"/>
		<xsl:param name="val6"/>
		<xsl:param name="val7"/>
		<xsl:param name="val8"/>
		<xsl:param name="val9"/>
		<xsl:param name="tdclass"/>
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="$generate-plain-html">
				<xsl:variable name="td-element">
					<xsl:value-of select="util:element1($val1, $ind1)"/>
					<xsl:value-of select="util:element1($val2, $ind1)"/>
					<xsl:value-of select="util:element1($val3, $ind1)"/>
					<xsl:value-of select="util:element1($val4, $ind1)"/>
					<xsl:value-of select="util:element1($val5, $ind1)"/>
					<xsl:value-of select="util:element1($val6, $ind1)"/>
					<xsl:value-of select="util:element1($val7, $ind1)"/>
					<xsl:value-of select="util:element1($val8, $ind1)"/>
					<xsl:value-of select="util:element1($val9, $ind1)"/>
				</xsl:variable>
				<xsl:value-of select="util:tag(concat('tr', $tdclass), $ind)"/>
				<xsl:value-of select="$td-element"/>
				<xsl:value-of select="util:tag('/tr', $ind)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat($nl, $ind, $indent, $indent, '{&quot;val1&quot; : &quot;', $val1, '&quot;, &quot;val2&quot; : &quot;', $val2, '&quot;}', '')"
				/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<!-- If OBX-2 =
		Display in result box :
		NM	OBX-5
		SN	OBX-5.1 OBX-5.2 OBX-5.3 OBX-5.4
		
		FT	OBX-5
		ST	OBX-5
		TX	OBX-5
		DT	OBX-5
		TS	OBX-5-1
		TM	OBX-5
		CWE	OBX-5.9 or OBX-5.2 or OBX-5.5 
		ED	OBX-5.5
	-->
	<xsl:function name="util:obx-result">
		<xsl:param name="obx"/>
		<xsl:choose>
			<xsl:when test="$obx//OBX.2 = 'SN'">
				<xsl:value-of
					select="concat(util:format-with-space($obx//OBX.5.1), util:format-with-space($obx//OBX.5.2), util:format-with-space($obx//OBX.5.3), $obx//OBX.5.4)"
				/>
			</xsl:when>
			<xsl:when test="$obx//OBX.2 = 'TS'">
				<xsl:value-of select="$obx//OBX.5.1"/>
			</xsl:when>
			<xsl:when test="$obx//OBX.2 = 'CWE'">
				<xsl:value-of select="util:or5($obx//OBX.5.9, $obx//OBX.5.2, $obx//OBX.5.5, '', '')"
				/>
			</xsl:when>
			<xsl:when test="$obx//OBX.2 = 'ED'">
				<xsl:value-of select="$obx//OBX.5.5"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$obx//OBX.5"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

</xsl:stylesheet>
