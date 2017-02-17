<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns="http://www.w3.org/1999/xhtml"
	xpath-default-namespace="" exclude-result-prefixes="xs" version="2.0">
	

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  util: generic functions for string manipulations  -->
	<!-- format-trailing: add the padding if non-empty; called from format-with-space -->
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
	<!-- add a trailing space if non empty -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:format-with-space">
		<xsl:param name="value"/>
		<xsl:value-of select="util:format-trailing($value, ' ')"/>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- format-tel: take a string and format it as (abc)efg-higk -->
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
	<!-- format-address: concatenate the individual elements, adding spaces when necessary -->
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
	<!-- format-address-multi-lines: concatenate the individual elements, adding spaces when necessary -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:format-address-multilines">
		<xsl:param name="elementName"/>
		<xsl:param name="street1"/>
		<xsl:param name="street2"/>
		<xsl:param name="cityStateZip"/>
		<xsl:param name="country"/>
		<xsl:param name="ind"/>
		<!--<xsl:choose>
			<xsl:when
			test="number(count($street1[text()]) + count($street2[text()]) + number(not(count($cityStateZip) = 0)) + count($country[text()])) > 0">
			<xsl:call-template name="util:element">
			<xsl:with-param name="name" select="$elementName"/>
			<xsl:with-param name="value" select="concat($street1, '&lt;br/>', $street2, '&lt;br/>', $cityStateZip, '&lt;br/>', $country)" />
			</xsl:call-template>
			</xsl:when>
			</xsl:choose>-->
		
		<!--Note: $street1 is always displayed-->
		<!--Note2: count($variable[text()]) is 1 if there are data, 0 otherwise-->
		<xsl:if test="not(count($street1[text()]) + count($street2[text()]) + number(not(count($cityStateZip) = 0)) + count($country[text()]) = 0)">
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
		</xsl:if>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- format-address-multi-lines: concatenate the individual elements, adding spaces when necessary -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="util:format-address-multilines">
		<xsl:param name="elementName"/>
		<xsl:param name="street1"/>
		<xsl:param name="street2"/>
		<xsl:param name="cityStateZip"/>
		<xsl:param name="country"/>
		<xsl:param name="ind"/>
		<!--<xsl:choose>
			<xsl:when
			test="number(count($street1[text()]) + count($street2[text()]) + number(not(count($cityStateZip) = 0)) + count($country[text()])) > 0">
			<xsl:call-template name="util:element">
			<xsl:with-param name="name" select="$elementName"/>
			<xsl:with-param name="value" select="concat($street1, '&lt;br/>', $street2, '&lt;br/>', $cityStateZip, '&lt;br/>', $country)" />
			</xsl:call-template>
			</xsl:when>
			</xsl:choose>-->
		
		<!--Note: $street1 is always displayed-->
		<!--Note2: count($variable[text()]) is 1 if there are data, 0 otherwise-->
		<xsl:if test="not(count($street1[text()]) + count($street2[text()]) + number(not(count($cityStateZip) = 0)) + count($country[text()]) = 0)">
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
		</xsl:if>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="util:chooseAmongThree">
		<xsl:param name="name"/>
		<xsl:param name="option1"/>
		<xsl:param name="option2"/>
		<xsl:param name="option3"/>
		<xsl:param name="ind"/>
		<xsl:choose>
			<xsl:when test="count($option1) > 0">
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="$name"/>
					<xsl:with-param name="value" select="$option1"/>
					<xsl:with-param name="ind" select="$ind"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count($option1) = 0 and count($option2) > 0">
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="$name"/>
					<xsl:with-param name="value" select="$option2"/>
					<xsl:with-param name="ind" select="$ind"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="count($option1) = 0 and count($option2) = 0 and count($option3) > 0">
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="$name"/>
					<xsl:with-param name="value" select="$option3"/>
					<xsl:with-param name="ind" select="$ind"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="$name"/>
					<xsl:with-param name="value" select="''"/>
					<xsl:with-param name="ind" select="$ind"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  format-date: takes a string and makes it a date mm/nn/yyyy -->
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
	<!-- some useful variables -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:variable name="indent" select="'&#9;'"/>
	<xsl:variable name="nl" select="'&#10;'"/>
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="util:title">
		<xsl:param name="tabname"/>
		<xsl:param name="multiple-segs" as="xs:boolean"/>
		<xsl:param name="output"/>
		<xsl:param name="segments"/>
		
		<xsl:choose>
			<xsl:when test="$output = 'ng-tab-html'">
				<!--Adding tab headers-->
				<xsl:element name="tab">
					<xsl:attribute name="heading">
						<xsl:value-of select="$tabname"/>
					</xsl:attribute>
					<xsl:element name="div">
						<xsl:attribute name="class">
							<xsl:text>panel panel-info</xsl:text>
						</xsl:attribute>
						<xsl:element name="div">
							<xsl:attribute name="class">
								<xsl:text>panel-body</xsl:text>
							</xsl:attribute>
							<xsl:element name="fieldset"> 
								<xsl:if test="$multiple-segs">
									<xsl:element name="accordion">
										<xsl:for-each select="$segments">
											<xsl:variable name="index">
												<xsl:value-of select="position()" />
											</xsl:variable>
											<xsl:apply-templates select=".">
												<xsl:with-param name="multiple-segs" select="$multiple-segs" />
												<xsl:with-param name="counter" select="position()"/>
												<xsl:with-param name="output" select="$output"/>
											</xsl:apply-templates>	
										</xsl:for-each>
									</xsl:element>
								</xsl:if>
								<xsl:if test="not($multiple-segs)">
									<xsl:for-each select="$segments">
										<xsl:variable name="index">
											<xsl:value-of select="position()" />
										</xsl:variable>
										<xsl:apply-templates select=".">
											<xsl:with-param name="multiple-segs" select="$multiple-segs" />
											<xsl:with-param name="counter" select="$index"/>
											<xsl:with-param name="output" select="$output"/>
										</xsl:apply-templates>	
									</xsl:for-each>
								</xsl:if>
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				
			</xsl:when>
			<xsl:when test="$output = 'plain-html'">
				<xsl:if test="$multiple-segs">
					<xsl:element name="fieldset">
						<xsl:element name="legend">
							<xsl:value-of select="$tabname"/>
						</xsl:element>
						<xsl:for-each select="$segments">
							<xsl:variable name="index">
								<xsl:if test="$multiple-segs">
									<xsl:value-of select="position()"/>
								</xsl:if>
							</xsl:variable>
							<xsl:apply-templates select=".">
								<xsl:with-param name="multiple-segs" select="$multiple-segs" />
								<xsl:with-param name="counter" select="$index"/>
								<xsl:with-param name="output" select="$output"/>
							</xsl:apply-templates>
						</xsl:for-each>
					</xsl:element>
				</xsl:if>
				<xsl:if test="not($multiple-segs)">
					<xsl:for-each select="$segments">
						<xsl:variable name="index">
							<xsl:if test="$multiple-segs">
								<xsl:value-of select="position()"/>
							</xsl:if>
						</xsl:variable>
						<xsl:apply-templates select=".">
							<xsl:with-param name="multiple-segs" select="$multiple-segs" />
							<xsl:with-param name="counter" select="$index"/>
							<xsl:with-param name="output" select="$output"/>
						</xsl:apply-templates>
					</xsl:for-each>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($output, ': unknown output')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->	
	<xsl:template name="util:process-segment">
		<xsl:param name="multiple-segs" />
		<xsl:param name="counter" />
		<xsl:param name="output" />
		<xsl:param name="title" />
		<xsl:param name="content" />
		
		<xsl:variable name="isOpenVar"
			select="concat('xsl', replace(replace($title, '-', ''), '[ \[*\\-\]]', ''))"/>
		
		<xsl:choose>
			<xsl:when test="$output = 'plain-html'">
				<xsl:element name="fieldset">
					<xsl:element name="legend">
						<xsl:if test="$multiple-segs">
							<xsl:value-of select="concat($title, ' - ', $counter)"/>
						</xsl:if>
						<xsl:if test="not($multiple-segs)">
							<xsl:value-of select="$title"/>
						</xsl:if>						
					</xsl:element>
					<xsl:copy-of select="$content" />
				</xsl:element>
			</xsl:when>
			
			<xsl:when test="$output = 'ng-tab-html'">
				
				<xsl:if test="$multiple-segs">
					<xsl:element name="accordion-group">
						<xsl:attribute name="class">
							<xsl:text>panel-info</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="type">
							<xsl:text>pills</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="style">
							<xsl:text>margin-top: 0; border: 1px ridge #C6DEFF;</xsl:text>
						</xsl:attribute>
						<xsl:attribute name="is-open">
							<xsl:value-of select="concat($isOpenVar, position())"/>
						</xsl:attribute>
						
						<xsl:element name="accordion-heading">
							<xsl:element name="span">
								<xsl:attribute name="class">
									<xsl:text>clearfix</xsl:text>
								</xsl:attribute>
								<xsl:element name="span">
									<xsl:attribute name="class">
										<xsl:text>accordion-heading pull-left</xsl:text>
									</xsl:attribute>
									<xsl:element name="i">
										<xsl:attribute name="class">
											<xsl:text>pull-left fa</xsl:text>
										</xsl:attribute>
										<xsl:attribute name="ng-class">
											<xsl:value-of
												select="concat('{''fa-caret-down'': ', concat($isOpenVar, $counter), ', ''fa-caret-right'': !', concat($isOpenVar, $counter), '}')"
											/>
										</xsl:attribute>
									</xsl:element>
									<xsl:value-of select="concat($title, ' - ', $counter)"/>
								</xsl:element>
							</xsl:element>
						</xsl:element>
						
						<xsl:element name="div">
							<xsl:attribute name="class">
								<xsl:text>panel panel-info</xsl:text>
							</xsl:attribute>
							<xsl:element name="div">
								<xsl:attribute name="class">
									<xsl:text>panel-body</xsl:text>
								</xsl:attribute>
								<xsl:copy-of select="$content" />
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>	
				<xsl:if test="not($multiple-segs)">
					<xsl:copy-of select="$content" />
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($output, ': unknown output')"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->	
	<xsl:template name="util:table-header">
		<xsl:element name="tr">
			<xsl:element name="th">
				<xsl:text>Element</xsl:text>
			</xsl:element>
			<xsl:element name="th">
				<xsl:text>Data</xsl:text>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
	<xsl:function name="util:title-and-elements">
		<xsl:param name="title"/>
		<xsl:param name="ind"/>
		<xsl:element name="table">
			<xsl:element name="tr">
				<xsl:element name="th">
					<xsl:attribute name="colspan">
						<xsl:text>2</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="$title"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  element: calls element-with-delimiter with value , ; basically generates table row element -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="util:element">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="ind"/>
		<xsl:call-template name="util:element-with-delimiter">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="value" select="$value"/>
			<xsl:with-param name="trailing" select="','"/>
			<xsl:with-param name="cols" select="2"/>
			<xsl:with-param name="ind" select="$ind"/>
		</xsl:call-template>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  element: calls element-with-delimiter with value , ; basically generates table row element -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="util:single-element">
		<xsl:param name="name"/>
		<xsl:param name="ind" select="$indent"/>
		
		<xsl:element name="tr">
			<xsl:element name="td">
				<xsl:attribute name="class">
					<xsl:text>separator</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="colspan">
					<xsl:text>2</xsl:text>
				</xsl:attribute>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- element-with-delimiter:  generates <tr> <td> name </td> <td> value </td> </tr>  (adds a class 'noData' to gray out if value is empty -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="util:element-with-delimiter">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="trailing"/>
		<xsl:param name="cols" as="xs:integer"/>
		<xsl:param name="ind"/>
		
		<xsl:if test="not(normalize-space($value) = '')">
			<xsl:variable name="col1span" select="floor($cols div 2)"/>
			<xsl:variable name="col2span" select="$cols - $col1span"/>
			<xsl:element name="tr">
				<xsl:element name="td">
					<xsl:attribute name="colspan">
						<xsl:value-of select="$col1span"/>
					</xsl:attribute>
					<xsl:value-of select="$name"/>
				</xsl:element>
				<xsl:choose>
					<xsl:when test="normalize-space($value) = ''">
						<xsl:element name="td">
							<xsl:attribute name="class">
								<xsl:text>noData</xsl:text>
							</xsl:attribute>
							<xsl:attribute name="colspan">
								<xsl:value-of select="$col2span"/>
							</xsl:attribute>
							<xsl:value-of select="$value"/>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:element name="td">
							<xsl:attribute name="colspan">
								<xsl:value-of select="$col2span"/>
							</xsl:attribute>
							<xsl:value-of select="$value"/>
						</xsl:element>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
		<!--<xsl:if test="normalize-space($value) = ''">
			<xsl:text>Empty value</xsl:text>
			</xsl:if>-->
	</xsl:template>
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
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:function name="util:union">
		<xsl:param name="table1"/>
		<xsl:param name="table2"/>
		<xsl:value-of select="$table1 | $table2"/>
	</xsl:function>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--<xsl:function name="util:strip-tabsets">
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
		</xsl:function>-->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
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
</xsl:stylesheet>
