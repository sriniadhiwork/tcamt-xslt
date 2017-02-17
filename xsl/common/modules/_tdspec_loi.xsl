<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xi="http://www.w3.org/2001/XInclude"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xs" version="2.0">
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  Includes & variables & output - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
	<xsl:include href="_util.new.xsl"/>
	<xsl:output method="html" indent = "yes" />
	<xsl:variable name="version" select="'3.1'"/>
	<xsl:variable name="ind1" select="'&#9;&#9;'"/>
	<xsl:variable name="ind2" select="'&#9;&#9;&#9;&#9;&#9;'"/>
	
	<!--  Supported profiles -->
	<xsl:variable name="ACK" select="'ACK'"/>
	<xsl:variable name="OML" select="'OML'"/>
	<xsl:variable name="ORL" select="'ORL'"/>
	
	<!-- Segments names -->
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
			<xsl:when test="$seg = 'MSA'">
				<xsl:value-of select="'Acknowledgment'"/>
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
	
	<xsl:template name="_main">
		<xsl:param name="output"/>
		<xsl:variable name="message-type">
			<xsl:choose>
				<xsl:when test="starts-with(name(/*), 'ACK')">
					<xsl:value-of select="$ACK"/>
				</xsl:when>
				<xsl:when test="starts-with(name(/*), 'OML')">
					<xsl:value-of select="$OML"/>
				</xsl:when>
				<xsl:when test="starts-with(name(/*), 'ORL')">
					<xsl:value-of select="$ORL"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="name(/*)"/>
					<xsl:text>: Unknown message type</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- - - - - - Ack display - - - - - - - - - - - -->
		<xsl:if test="$message-type = $ACK">
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//MSA"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//ERR"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
		</xsl:if>
		
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - OML display - - - - - - - - - - - - -->
		
		<xsl:if test="$message-type = $OML">
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//PID"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//NK1"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//PV1"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
			<!--	<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//IN1"/>
				<xsl:with-param name="output" select="$output"/>
				</xsl:call-template>
				<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//GT1"/>
				<xsl:with-param name="output" select="$output"/>
				</xsl:call-template>
				<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//ORC"/>
				<xsl:with-param name="output" select="$output"/>
				</xsl:call-template>-->
		</xsl:if>
		
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - ORL display - - - - - - - - - - - - -->
		<xsl:if test="$message-type = $ORL">
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//MSA"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//ERR"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//PID"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//ORC"/>
				<xsl:with-param name="output" select="$output"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Patient information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="PID">
		<xsl:param name="output" />
		<xsl:param name="multiple-segs" as="xs:boolean" select="false()"/>
		<xsl:param name="counter" />
		
		<xsl:variable name="title">
			<xsl:text>Patient Information</xsl:text>
		</xsl:variable>
		
		<xsl:variable name="content">
			<xsl:element name="table">
				<xsl:call-template name="util:table-header" />
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Patient name'"/>
					<xsl:with-param name="value" select=".//PID.5.2"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Patient name'"/>
					<xsl:with-param name="value" select="concat(util:format-with-space(.//PID.5.2), util:format-with-space(.//PID.5.3), util:format-with-space(.//PID.5.1.1), .//PID.5.4)"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Mother''s Maiden Name'"/>
					<xsl:with-param name="value" select="concat(util:format-with-space(.//PID.6.2), util:format-with-space(.//PID.6.3), util:format-with-space(.//PID.6.1.1), .//PID.6.4)"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Date/Time of Birth'"/>
					<xsl:with-param name="value" select="util:format-time(.//PID.7.1)"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Death Date/Time'"/>
					<xsl:with-param name="value" select="util:format-time(.//PID.29.1)"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:for-each select=".//PID.11">
					<xsl:call-template name="util:format-address-multilines">
						<xsl:with-param name="elementName" select="'Patient Address'"/>
						<xsl:with-param name="street1" select=".//PID.11.1.1"/>
						<xsl:with-param name="street2" select=".//PID.11.1.2"/>
						<xsl:with-param name="cityStateZip" select="concat(util:format-with-space(.//PID.11.3), util:format-with-space(.//PID.11.4), util:format-with-space(.//PID.11.5))"/>
						<xsl:with-param name="country" select=".//PID.11.6"/>
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:for-each select=".//PID.13">
					<xsl:choose>
						<xsl:when test=".//PID.13.3 = 'PH'">
							<xsl:call-template name="util:element">
								<xsl:with-param name="name" select="'Home phone number'"/>
								<xsl:with-param name="value" select="concat(util:format-with-space(.//PID.13.6), util:format-with-space(.//PID.13.7), util:format-with-space(.//PID.13.8))"/>
								<xsl:with-param name="ind" select="$ind1"/>
							</xsl:call-template>
							
						</xsl:when>
						<xsl:when test=".//PID.13.3 = 'X.400' or .//PID.13.3 = 'Internet'">
							<xsl:call-template name="util:element">
								<xsl:with-param name="name" select="'Email address'"/>
								<xsl:with-param name="value" select=".//PID.13.4"/>
								<xsl:with-param name="ind" select="$ind1"/>
							</xsl:call-template>								
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				
				<xsl:for-each select=".//PID.14">
					<xsl:choose>
						<xsl:when test=".//PID.14.3 = 'PH'">
							<xsl:call-template name="util:element">
								<xsl:with-param name="name" select="'Business phone number'"/>
								<xsl:with-param name="value" select="concat(util:format-with-space(.//PID.14.6), util:format-with-space(.//PID.14.7), util:format-with-space(.//PID.14.8))"/>
								<xsl:with-param name="ind" select="$ind1"/>
							</xsl:call-template>
							
						</xsl:when>
						<xsl:when test=".//PID.14.3 = 'X.400' or .//PID.14.3 = 'Internet'">
							<xsl:call-template name="util:element">
								<xsl:with-param name="name" select="'Business email address'"/>
								<xsl:with-param name="value" select=".//PID.14.4"/>
								<xsl:with-param name="ind" select="$ind1"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				
				<xsl:for-each select=".//PID.10">
					<xsl:call-template name="util:chooseAmongThree">
						<xsl:with-param name="name" select="'Race'"/>
						<xsl:with-param name="option1" select=".//PID.10.9"/>
						<xsl:with-param name="option2" select=".//PID.10.2"/>
						<xsl:with-param name="option3" select=".//PID.10.1"/>
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:for-each select=".//PID.22">
					<xsl:call-template name="util:chooseAmongThree">
						<xsl:with-param name="name" select="'Ethnic group'"/>
						<xsl:with-param name="option1" select=".//PID.22.9"/>
						<xsl:with-param name="option2" select=".//PID.22.2"/>
						<xsl:with-param name="option3" select=".//PID.22.1"/>
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:element>
		</xsl:variable>
		
		<xsl:call-template name="util:process-segment">
			<xsl:with-param name="output" select="$output" />
			<xsl:with-param name="multiple-segs" select="$multiple-segs" />
			<xsl:with-param name="counter" select="$counter"/>
			<xsl:with-param name="title" select="$title"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	</xsl:template>
	
	
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Next of kin - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="NK1">
		<xsl:param name="output" />
		<xsl:param name="multiple-segs" as="xs:boolean" select="false()"/>
		<xsl:param name="counter" />
		
		<xsl:variable name="title">
			<xsl:text>Next of kin information</xsl:text>
		</xsl:variable>
		
		<xsl:variable name="content">
			<xsl:element name="table">
				<xsl:call-template name="util:table-header" />
				
				<xsl:for-each select=".//NK1.3">
					<xsl:call-template name="util:chooseAmongThree">
						<xsl:with-param name="name" select="'Relationship'"/>
						<xsl:with-param name="option1" select=".//NK1.3.9"/>
						<xsl:with-param name="option2" select=".//NK1.3.2"/>
						<xsl:with-param name="option3" select=".//NK1.3.1"/>
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:if test="count(.//NK1.2)">
					<xsl:call-template name="util:element">
						<xsl:with-param name="name" select="'Name'"/>
						<xsl:with-param name="value" select="concat(util:format-with-space(.//NK1.2.2), util:format-with-space(.//NK1.2.3), util:format-with-space(.//NK1.2.1.1), .//NK1.2.4)"/>
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Organization name'"/>
					<xsl:with-param name="value" select=".//NK1.13.1"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Organization identifier'"/>
					<xsl:with-param name="value" select=".//NK1.13.10"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Contact person''s name'"/>
					<xsl:with-param name="value" select="concat(util:format-with-space(.//NK1.30.2), util:format-with-space(.//NK1.30.3), util:format-with-space(.//NK1.30.1.1), util:format-with-space(.//NK1.30.4))"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:if test="count(.//NK1.32)">
					<xsl:call-template name="util:format-address-multilines">
						<xsl:with-param name="elementName" select="'Contact person''s address'"></xsl:with-param>
						<xsl:with-param name="street1" select=".//NK1.32.1.1"/>
						<xsl:with-param name="street2" select=".//NK1.32.1.2"/>
						<xsl:with-param name="cityStateZip" select="concat(util:format-with-space(.//NK1.32.3), util:format-with-space(.//NK1.32.4), util:format-with-space(.//NK1.32.5))" />
						<xsl:with-param name="country" select=".//NK1.32.6" />
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:for-each select=".//NK1.4">
					<xsl:call-template name="util:format-address-multilines">
						<xsl:with-param name="elementName" select="'Address'"></xsl:with-param>
						<xsl:with-param name="street1" select=".//NK1.4.1"/>
						<xsl:with-param name="street2" select=".//NK1.4.2"/>
						<xsl:with-param name="cityStateZip" select="concat(util:format-with-space(.//NK1.4.3), util:format-with-space(.//NK1.4.4), util:format-with-space(.//NK1.4.5))" />
						<xsl:with-param name="country" select=".//NK1.4.6" />
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:for-each select=".//NK1.5">
					<xsl:choose>
						<xsl:when test=".//NK1.5.3 = 'PH'">
							<xsl:call-template name="util:element">
								<xsl:with-param name="name" select="'Phone number'"/>
								<xsl:with-param name="value" select="concat(util:format-with-space(.//NK1.5.6), util:format-with-space(.//NK1.5.7), util:format-with-space(.//NK1.5.8))"/>
								<xsl:with-param name="ind" select="$ind1"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test=".//NK1.5.3 = 'X.400' or .//NK1.5.3 = 'Internet'">
							<xsl:call-template name="util:element">
								<xsl:with-param name="name" select="'Email address'"/>
								<xsl:with-param name="value" select=".//NK1.5.4"/>
								<xsl:with-param name="ind" select="$ind1"/>
							</xsl:call-template>							
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				
				<xsl:call-template name="util:chooseAmongThree">
					<xsl:with-param name="name" select="'Contact role'"/>
					<xsl:with-param name="option1" select=".//NK1.7.9"/>
					<xsl:with-param name="option2" select=".//NK1.2.2"/>
					<xsl:with-param name="option3" select=".//NK1.1.1"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Next of kin/Associated parties job code/Class'"/>
					<xsl:with-param name="value" select=".//NK1.11.3"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
			</xsl:element>
		</xsl:variable>
		
		<xsl:call-template name="util:process-segment">
			<xsl:with-param name="output" select="$output" />
			<xsl:with-param name="multiple-segs" select="$multiple-segs" />
			<xsl:with-param name="counter" select="$counter"/>
			<xsl:with-param name="title" select="$title"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
		
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Patient Visit information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="PV1">
		<xsl:param name="output" />
		<xsl:param name="multiple-segs" as="xs:boolean" select="false()"/>
		<xsl:param name="counter" />
		
		<xsl:variable name="title">
			<xsl:text>Visit information</xsl:text>
		</xsl:variable>
		
		<xsl:variable name="content">
			<xsl:element name="table">
				<xsl:call-template name="util:table-header" />
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Patient class'"/>
					<xsl:with-param name="value" select=".//PV1.2"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Financial class'"/>
					<xsl:with-param name="value" select=".//PV1.20.1"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:for-each select=".//PV1.22">
					<xsl:call-template name="util:chooseAmongThree">
						<xsl:with-param name="name" select="'Courtesy code'"/>
						<xsl:with-param name="option1" select=".//PV1.22.9"/>
						<xsl:with-param name="option2" select=".//PV1.22.2"/>
						<xsl:with-param name="option3" select=".//PV1.22.1"/>
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:element>
		</xsl:variable>
		
		<xsl:call-template name="util:process-segment">
			<xsl:with-param name="output" select="$output" />
			<xsl:with-param name="multiple-segs" select="$multiple-segs" />
			<xsl:with-param name="counter" select="$counter"/>
			<xsl:with-param name="title" select="$title"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Insurance information - - - - - - - - - - - -->
	<xsl:template match="IN1">
		<xsl:param name="output" />
		<xsl:param name="multiple-segs" as="xs:boolean" select="false()"/>
		<xsl:param name="counter" />
		
		<xsl:variable name="title">
			<xsl:text>Insurance information</xsl:text>
		</xsl:variable>
		
		<xsl:variable name="content">
			<xsl:element name="table">
				<xsl:call-template name="util:table-header" />
				
				<xsl:for-each select=".//IN1.2">
					<xsl:call-template name="util:chooseAmongThree">
						<xsl:with-param name="name" select="'Relationship'"/>
						<xsl:with-param name="option1" select=".//IN1.2.9"/>
						<xsl:with-param name="option2" select=".//IN1.2.2"/>
						<xsl:with-param name="option3" select=".//IN1.2.1"/>
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Insurance Company ID'"/>
					<xsl:with-param name="value" select=".//IN1.3.1"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Insurance Company Name'"/>
					<xsl:with-param name="value" select=".//IN1.4.1"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:format-address-multilines">
					<xsl:with-param name="elementName" select="'Insurance Company Address'"></xsl:with-param>
					<xsl:with-param name="street1" select=".//IN1.5.1.1"/>
					<xsl:with-param name="street2" select=".//IN1.5.2"/>
					<xsl:with-param name="cityStateZip" select="concat(util:format-with-space(.//IN1.5.3), util:format-with-space(.//IN1.5.4), util:format-with-space(.//IN1.5.5))" />
					<xsl:with-param name="country" select=".//IN1.5.6" />
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Group Number'"/>
					<xsl:with-param name="value" select=".//IN1.8"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Insured''s Group Employer Name'"/>
					<xsl:with-param name="value" select=".//IN1.11.1"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Insured''s Group Employer Identifier'"/>
					<xsl:with-param name="value" select=".//IN1.11.10"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Plan Expiration Date'"/>
					<xsl:with-param name="value" select=".//IN1.13"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Name of insured'"/>
					<xsl:with-param name="value" select="concat(util:format-with-space(.//IN1.16.2), util:format-with-space(.//IN1.16.3), util:format-with-space(.//IN1.16.1.1), util:format-with-space(.//IN1.16.4))"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:chooseAmongThree">
					<xsl:with-param name="name" select="'Insured''s Relationship To Patient'"/>
					<xsl:with-param name="option1" select=".//IN1.17.9"/>
					<xsl:with-param name="option2" select=".//IN1.17.2"/>
					<xsl:with-param name="option3" select=".//IN1.17.1"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Insured''s Date of Birth'"/>
					<xsl:with-param name="value" select="util:format-time(.//IN1.18.1)"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:format-address-multilines">
					<xsl:with-param name="elementName" select="'Insured Address'"></xsl:with-param>
					<xsl:with-param name="street1" select=".//IN1.19.1.1"/>
					<xsl:with-param name="street2" select=".//IN1.19.2"/>
					<xsl:with-param name="cityStateZip" select="concat(util:format-with-space(.//IN1.19.3), util:format-with-space(.//IN1.19.4), util:format-with-space(.//IN1.19.5))" />
					<xsl:with-param name="country" select=".//IN1.19.6" />
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Type Of Agreement Code'"/>
					<xsl:with-param name="value" select="util:format-time(.//IN1.31)"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Policy number'"/>
					<xsl:with-param name="value" select="util:format-time(.//IN1.36)"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>

			</xsl:element>
		</xsl:variable>
		
		<xsl:call-template name="util:process-segment">
			<xsl:with-param name="output" select="$output" />
			<xsl:with-param name="multiple-segs" select="$multiple-segs" />
			<xsl:with-param name="counter" select="$counter"/>
			<xsl:with-param name="title" select="$title"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
		
	</xsl:template>
	
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - 	Guarantor information - - - - - - - - - - - -->
		<xsl:template match="GT1">
			<xsl:param name="output" />
			<xsl:param name="multiple-segs" as="xs:boolean" select="false()"/>
			<xsl:param name="counter" />
			
			<xsl:variable name="title">
				<xsl:text>Guarantor Information</xsl:text>
			</xsl:variable>
			
			<xsl:variable name="content">
				<xsl:element name="table">
					<xsl:call-template name="util:table-header" />
			
					<xsl:call-template name="util:element">
						<xsl:with-param name="name" select="'Guarantor Name'"/>
						<xsl:with-param name="value" select="concat(util:format-with-space(.//GT1.3.2), util:format-with-space(.//GT1.3.3), util:format-with-space(.//GT1.3.1.1), .//GT1.3.4)"/>
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
					
					<xsl:call-template name="util:format-address-multilines">
						<xsl:with-param name="elementName" select="'Guarantor Address'" />
						<xsl:with-param name="street1" select=".//GT1.5.1.1"/>
						<xsl:with-param name="street2" select=".//GT1.5.2"/>
						<xsl:with-param name="cityStateZip" select="concat(util:format-with-space(.//GT1.5.3), util:format-with-space(.//GT1.5.4), util:format-with-space(.//GT1.5.5))" />
						<xsl:with-param name="country" select=".//GT1.5.6" />
						<xsl:with-param name="ind" select="$ind1"/>
					</xsl:call-template>
					
					<xsl:for-each select=".//GT1.11">
						<xsl:call-template name="util:chooseAmongThree">
							<xsl:with-param name="name" select="'Guarantor Relationship'"/>
							<xsl:with-param name="option1" select=".//GT1.11.9"/>
							<xsl:with-param name="option2" select=".//GT1.11.2"/>
							<xsl:with-param name="option3" select=".//GT1.11.1"/>
							<xsl:with-param name="ind" select="$ind1"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:element>
			</xsl:variable>
			
			<xsl:call-template name="util:process-segment">
				<xsl:with-param name="output" select="$output" />
				<xsl:with-param name="multiple-segs" select="$multiple-segs" />
				<xsl:with-param name="counter" select="$counter"/>
				<xsl:with-param name="title" select="$title"/>
				<xsl:with-param name="content" select="$content" />
			</xsl:call-template>		
			
			<xsl:call-template name="util:element">
				<xsl:with-param name="name" select="'Guarantor Organization Name'"/>
				<xsl:with-param name="value" select=".//GT1.21.1"/>
				<xsl:with-param name="ind" select="$ind1"/>
			</xsl:call-template>
		
		</xsl:template>
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - 	Order  - - - - - - - - - - - -->
		<xsl:template match="ORC">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of
		select="util:title('title', concat('Order', $counter), 'Order', $ind1, true(), $vertical-orientation, false())"/>
		
		<!-- Ordering Provider subtable -->
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', 'Ordering Provider', 'Ordering Provider', $ind2, false())"/>
		<xsl:value-of select="util:elements($ind2)"/>
		<xsl:value-of
		select="util:element('Provider Name', concat(util:format-with-space(.//ORC.12.3), .//ORC.12.2), $ind1)"/>
		
		<xsl:value-of select="util:element('Provider NPI identifier', .//ORC.12.1, $ind1)"/>
		
		<xsl:for-each select=".//ORC.14">
		<xsl:choose>
		<xsl:when test=".//ORC.14.3 = 'PH'">
		<xsl:value-of
		select="util:element('Call Back Phone number', concat(util:format-with-space(.//ORC.14.6), util:format-with-space(.//ORC.14.7), util:format-with-space(.//ORC.14.8)), $ind1)"
		/>
		</xsl:when>
		<xsl:when test=".//ORC.14.3 = 'X.400' or .//ORC.14.3 = 'Internet'">
		<xsl:value-of select="util:element('Email address', .//ORC.14.4, $ind1)"/>
		</xsl:when>
		</xsl:choose>
		</xsl:for-each>
		
		<xsl:value-of select="util:element('Ordering Facility Name', .//ORC.21.1, $ind1)"/>
		
		<xsl:choose>
		<xsl:when test="count(.//ORC.22)">
		<xsl:value-of
		select="util:format-address-multilines('Ordering Facility Address', .//ORC.22.1.1, .//ORC.22.2, concat(util:format-with-space(.//ORC.22.3), util:format-with-space(.//ORC.22.4), util:format-with-space(.//ORC.22.5)), .//ORC.22.6, $ind1)"
		/>
		</xsl:when>
		</xsl:choose>
		
		<xsl:for-each select=".//ORC.23">
		<xsl:choose>
		<xsl:when test=".//ORC.23.3 = 'PH'">
		<xsl:value-of
		select="util:element('Ordering Facility Phone number', concat(util:format-with-space(.//ORC.23.6), util:format-with-space(.//ORC.23.7), util:format-with-space(.//ORC.23.8)), $ind1)"
		/>
		</xsl:when>
		<xsl:when test=".//ORC.23.3 = 'X.400' or .//ORC.23.3 = 'Internet'">
		<xsl:value-of
		select="util:element('Ordering Facility email address', .//ORC.23.4, $ind1)"
		/>
		</xsl:when>
		</xsl:choose>
		</xsl:for-each>
		<xsl:value-of select="util:end-table-fieldset($ind1)"/>
		
		<!-- General order information subtable -->
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', 'General order information', 'General order information', $ind2, false())"/>
		<xsl:value-of select="util:elements($ind2)"/>
		<xsl:value-of select="util:element('Placer Order Number', .//ORC.2.1, $ind1)"/>
		<xsl:value-of select="util:element('Filler Order Number', .//ORC.3.1, $ind1)"/>
		<xsl:value-of select="util:element('Placer Group Number', .//ORC.4.1, $ind1)"/>
		<xsl:value-of select="util:element('Order Control', .//ORC.1, $ind1)"/>
		<xsl:choose>
		<xsl:when test="count(.//ORC.20.9) > 0">
		<xsl:value-of
		select="util:element('Advanced Beneficiary Notice Code', .//ORC.20.9, $ind1)"/>
		</xsl:when>
		<xsl:when test="count(.//ORC.20.9) = 0 and count(.//ORC.20.2) > 0">
		<xsl:value-of
		select="util:element('Advanced Beneficiary Notice Code', .//ORC.20.2, $ind1)"/>
		</xsl:when>
		<xsl:when
		test="count(.//ORC.20.9) = 0 and count(.//ORC.20.2) = 0 and count(.//ORC.20.1) > 0">
		<xsl:value-of
		select="util:element('Advanced Beneficiary Notice Code', .//ORC.20.1, $ind1)"/>
		</xsl:when>
		</xsl:choose>
		<xsl:value-of
		select="util:element('Date/Time of Transaction', util:format-time(.//ORC.9.1), $ind1)"/>
		<xsl:value-of select="util:end-table-fieldset($ind2)"/>
		
		<!-- Timing/Quantity Information subtable -->
		<xsl:if test="not(count(..//TQ1) = 0)">
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', 'Timing/Quantity Information', 'Timing/Quantity Information', $ind2, false())"/>
		<xsl:value-of select="util:elements($ind2)"/>
		<xsl:value-of
		select="util:element('Start Date/time', util:format-time(..//TQ1.7.1), $ind1)"/>
		<xsl:value-of
		select="util:element('End date/time', util:format-time(..//TQ1.8.1), $ind1)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Priority', ..//TQ1.9.9, ..//TQ1.9.2, ..//TQ1.9.1, $ind1)"/>
		<xsl:value-of select="util:end-table-fieldset($ind2)"/>
		</xsl:if>
		
		<!-- Order details subtable -->
		<!--Format time needs to be checked; alternative id too-->
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', 'Order details', 'Order details', $ind2, false())"/>
		<xsl:value-of select="util:elements($ind2)"/>
		
		<xsl:choose>
		<xsl:when test="..//OBR.4.3 = 'LN'">
		<xsl:value-of
		select="util:element('Service Identifier (LOINC code)', ..//OBR.4.1, $ind1)"
		/>
		</xsl:when>
		<xsl:when test="..//OBR.4.6 = 'LN'">
		<xsl:value-of
		select="util:element('Service Identifier (LOINC code)', ..//OBR.4.4, $ind1)"
		/>
		</xsl:when>
		</xsl:choose>
		<xsl:choose>
		<xsl:when test="not(..//OBR.4.3 = 'LN')">
		<xsl:value-of
		select="util:element('Service Identifier (local code)', ..//OBR.4.1, $ind1)"
		/>
		</xsl:when>
		<xsl:when test="not(..//OBR.4.6 = 'LN')">
		<xsl:value-of
		select="util:element('Service Identifier (local code)', ..//OBR.4.4, $ind1)"
		/>
		</xsl:when>
		</xsl:choose>
		<xsl:value-of
		select="util:element('Observation Date/Time', util:format-time(..//OBR.7.1), $ind1)"/>
		<xsl:value-of
		select="util:element('Observation end Date/Time', util:format-time(..//OBR.8.1), $ind1)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Relevant Clinical Information', ..//OBR.13.9, ..//OBR.13.2, ..//OBR.13.1, $ind1)"/>
		<xsl:value-of select="util:end-table-fieldset($ind1)"/>
		
		
		<!-- Notes and comments subtable -->
		<xsl:if test="not(count(..//NTE) = 0)">
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', 'Notes &amp; comments', 'Notes &amp; comments', $ind1, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:for-each select="..//NTE">
		<xsl:value-of select="util:element('Comments', .//NTE.3, $ind1)"/>
		</xsl:for-each>
		<xsl:value-of select="util:end-table-fieldset($ind1)"/>
		</xsl:if>
		
		
		<!-- Result copies subtable -->
		<xsl:for-each select="..//PRT">
		<xsl:variable name="index">
		<xsl:choose>
		<xsl:when test="count(..//PRT) > 1">
		<xsl:value-of select="concat(' - ', position())"/>
		</xsl:when>
		<xsl:otherwise>
		<xsl:text/>
		</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', concat('Result copies', $index), concat('Result copies', $index), $ind2, false())"/>
		<xsl:value-of select="util:elements($ind2)"/>
		
		<xsl:value-of select="util:element('Instance ID', .//PRT.1.1, $ind1)"/>
		<xsl:value-of select="util:element('NPI Identifier', .//PRT.5.1, $ind1)"/>
		<xsl:value-of
		select="util:element('Name', concat(util:format-with-space(.//PRT.5.3), .//PRT.5.2), $ind1)"/>
		<xsl:value-of
		select="util:format-address-multilines('Address', .//PRT.14.1.1, .//PRT.14.2, concat(util:format-with-space(.//PRT.14.3), util:format-with-space(.//PRT.14.4), util:format-with-space(.//PRT.14.5)), .//PRT.14.6, $ind1)"/>
		
		<xsl:for-each select=".//PRT.15">
		<xsl:choose>
		<xsl:when test=".//PRT.15.3 = 'PH'">
		<xsl:value-of
		select="util:element('Phone Number', concat(util:format-with-space(.//PRT.15.6), util:format-with-space(.//PRT.15.7), util:format-with-space(.//PRT.15.8)), $ind1)"
		/>
		</xsl:when>
		<xsl:when test=".//PRT.15.3 = 'X.400' or .//PRT.15.3 = 'Internet'">
		<xsl:value-of select="util:element('Email address', .//PRT.15.4, $ind1)"/>
		</xsl:when>
		</xsl:choose>
		</xsl:for-each>
		
		<xsl:value-of select="util:element('Action code', .//PRT.2, $ind1)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Participation', .//PRT.4.9, .//PRT.4.2, .//PRT.4.1, $ind1)"/>
		
		<xsl:value-of select="util:end-table-fieldset($ind1)"/>
		</xsl:for-each>
		
		<!-- Diagnosis information subtable -->
		<xsl:for-each select="..//DG1">
		<xsl:variable name="index">
		<xsl:choose>
		<xsl:when test="count(..//DG1) > 1">
		<xsl:value-of select="concat(' - ', position())"/>
		</xsl:when>
		<xsl:otherwise>
		<xsl:text/>
		</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', concat('Diagnosis information', $index), concat('Diagnosis information', $index), $ind2, false())"/>
		<xsl:value-of select="util:elements($ind2)"/>
		
		<xsl:value-of select="util:element('Priority', .//DG1.15, $ind1)"/>
		
		<xsl:choose>
		<xsl:when test=".//DG1.3.3 = 'I9'">
		<xsl:value-of select="util:element('Diagnosis ICD-9CM Code', .//DG1.3.1, $ind1)"
		/>
		</xsl:when>
		<xsl:when test=".//DG1.3.3 = 'I10C'">
		<xsl:value-of
		select="util:element('Diagnosis ICD-10CM Code', .//DG1.3.1, $ind1)"/>
		</xsl:when>
		</xsl:choose>
		
		<xsl:value-of select="util:element('Diagnosis type', .//DG1.6, $ind1)"/>
		<xsl:value-of select="util:end-table-fieldset($ind1)"/>
		</xsl:for-each>
		
		<xsl:for-each select="..//OBX">
		<!-- Observation Result subtable -->
		<xsl:variable name="index">
		<xsl:choose>
		<xsl:when test="count(..//OBX) > 1">
		<xsl:value-of select="concat(' - ', position())"/>
		</xsl:when>
		<xsl:otherwise>
		<xsl:text/>
		</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', concat('Observation Result - ', .//OBX.1), concat('Observation Result - ', .//OBX.1), $ind2, false())"/>
		<xsl:value-of select="util:elements($ind2)"/>
		<xsl:choose>
		<xsl:when test=".//OBX.3.3 = 'LN'">
		<xsl:value-of
		select="util:element('Observation Identifier (LOINC code)', .//OBX.3.1, $ind1)"/>
		</xsl:when>
		<xsl:when test=".//OBX.3.6 = 'LN'">
		<xsl:value-of
		select="util:element('Observation Identifier (LOINC code)', .//OBX.3.4, $ind1)"/>
		</xsl:when>
		</xsl:choose>
		<xsl:choose>
		<xsl:when test="not(.//OBX.3.3 = 'LN')">
		<xsl:value-of
		select="util:element('Observation Identifier (local code)', .//OBX.3.1, $ind1)"
		/>
		</xsl:when>
		<xsl:when test="not(.//OBX.3.6 = 'LN')">
		<xsl:value-of
		select="util:element('Observation Identifier (local code)', .//OBX.3.4, $ind1)"
		/>
		</xsl:when>
		</xsl:choose>
		<xsl:choose>
		<xsl:when test=".//OBX.2 = 'CWE'">
		<xsl:value-of
		select="util:chooseAmongThree('Observation Value', .//OBX.5.9, .//OBX.5.2, .//OBX.5.1, $ind1)"
		/>
		</xsl:when>
		<xsl:when test=".//OBX.2 = 'NM'">
		<xsl:value-of select="util:element('Observation Value', .//OBX.5, $ind1)"/>
		</xsl:when>
		<xsl:when test=".//OBX.2 = 'DT'">
		<xsl:value-of
		select="util:element('Observation Value', util:format-time(.//OBX.5), $ind1)"
		/>
		</xsl:when>
		</xsl:choose>
		<xsl:value-of
		select="util:chooseAmongThree('Units', .//OBX.6.9, .//OBX.6.2, .//OBX.6.1, $ind1)"/>
		<xsl:value-of select="util:element('Observation Result status', .//OBX.11, $ind1)"/>
		<xsl:value-of
		select="util:element('Date/Time of the Observation', util:format-time(.//OBX.14.1), $ind1)"/>
		<xsl:value-of select="util:element('Observation Type', .//OBX.29, $ind1)"/>
		<xsl:value-of select="util:end-table-fieldset($ind1)"/>
		</xsl:for-each>
		
		<xsl:variable name="multiple-specimens" select="count(..//SPM) > 1"/>
		<xsl:for-each select="..//SPM">
		<xsl:variable name="index">
		<xsl:if test="$multiple-specimens">
		<xsl:value-of select="concat(' - ', position())"/>
		</xsl:if>
		</xsl:variable>
		<!-- Specimen Information -->
		<xsl:value-of select="util:begin-sub-table($ind2)"/>
		<xsl:value-of
		select="util:title-no-tab('title', concat('Specimen Details', $index), concat('Specimen Details', $index), $ind2, false())"/>
		<xsl:value-of select="util:elements($ind2)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Type', .//SPM.4.9, .//SPM.4.2, .//SPM.4.1, $ind1)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Type Modifier', .//SPM.5.9, .//SPM.5.2, .//SPM.5.1, $ind1)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Additives', .//SPM.6.9, .//SPM.6.2, .//SPM.6.1, $ind1)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Collection Method', .//SPM.7.9, .//SPM.7.2, .//SPM.7.1, $ind1)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Source site', .//SPM.8.9, .//SPM.8.2, .//SPM.8.1, $ind1)"/>
		<xsl:value-of
		select="util:chooseAmongThree('Source site modifier', .//SPM.9.9, .//SPM.9.2, .//SPM.9.1, $ind1)"/>
		<xsl:value-of
		select="util:element('Collection Start Date/Time', util:format-time(.//SPM.17.1.1), $ind1)"/>
		<xsl:value-of
		select="util:element('Collection End Date/Time', util:format-time(.//SPM.17.2.1), $ind1)"/>
		<xsl:value-of select="util:end-table-fieldset($ind1)"/>
		</xsl:for-each>
		
		<!--<xsl:value-of select="util:end-table-fieldset($ind1)"/>-->
		
		<xsl:value-of select="util:end-tab($ind1, $vertical-orientation)"/>
		</xsl:template>
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		
		
		
		
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - Patient information for QPD - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:template match="QPD">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of
		select="util:title('title', concat('Patient Information', $counter), 'Patient Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of
		select="util:element('Patient Name', concat(util:format-with-space(.//QPD.4.2), util:format-with-space(.//QPD.4.3), .//QPD.4.1.1), $ind1)"/>
		<xsl:value-of select="util:element('Mother''s Maiden Name', .//QPD.5.1.1, $ind1)"/>
		<xsl:value-of
		select="util:element('ID Number', concat(util:format-with-space(.//QPD.3.1[1]), .//QPD.3.1[2]), $ind1)"/>
		<xsl:value-of
		select="util:element('Date/Time of Birth', util:format-time(.//QPD.6.1), $ind1)"/>
		<xsl:value-of select="util:element('Sex', util:admin-sex(.//QPD.7), $ind1)"/>
		<xsl:value-of
		select="util:element('Patient Address', util:format-address(.//QPD.8.1.1, .//QPD.8.3, .//QPD.8.4, .//QPD.8.5, .//QPD.8.6), $ind1)"/>
		<xsl:value-of
		select="util:element('Patient Phone', util:format-tel(.//QPD.9.6, .//QPD.9.7), $ind1)"/>
		<xsl:value-of select="util:element('Birth Indicator', util:yes-no(.//QPD.10), $ind1)"/>
		<xsl:value-of
		select="util:element('Birth Order', .//QPD.11, $ind1)"
		/>
		</xsl:template>
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - Immunization Registry information - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:template match="PD1">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of
		select="util:title('title', concat('Immunization Registry Information', $counter), 'Immunization Registry Information', $ind1, true(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of
		select="util:element('Immunization Registry Status', util:imm-reg-status(.//PD1.16), $ind1)"/>
		<xsl:value-of
		select="util:element('Immunization Registry Status Effective Date', util:format-time(.//PD1.17), $ind1)"/>
		<xsl:value-of select="util:element('Publicity Code', .//PD1.11.2, $ind1)"/>
		<xsl:value-of
		select="util:element('Publicity Code Effective Date', util:format-time(.//PD1.18), $ind1)"/>
		<xsl:value-of
		select="util:element('Protection Indicator', util:protection-indicator(.//PD1.12), $ind1)"/>
		<xsl:value-of
		select="util:element('Protection Indicator Effective Date', util:format-time(.//PD1.13), $ind1)"
		/>
		</xsl:template>
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		
		@@@@@@@@@@@@@@@@
	
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Acknoledgment information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="MSA">
		<xsl:param name="output" />
		<xsl:param name="multiple-segs" as="xs:boolean" select="false()"/>
		<xsl:param name="counter" />
		
		<xsl:variable name="title">
			<xsl:text>Acknowledgement</xsl:text>
		</xsl:variable>
		
		<xsl:variable name="content">
			<xsl:element name="table">
				<xsl:call-template name="util:table-header" />
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Acknowledgment code'"/>
					<xsl:with-param name="value" select=".//MSA.1"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
			</xsl:element>
		</xsl:variable>>
		
		<xsl:call-template name="util:process-segment">
			<xsl:with-param name="output" select="$output" />
			<xsl:with-param name="multiple-segs" select="$multiple-segs" />
			<xsl:with-param name="counter" select="$counter"/>
			<xsl:with-param name="title" select="$title"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
	</xsl:template>
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Error details information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="ERR">
		<xsl:param name="output" />
		<xsl:param name="multiple-segs" as="xs:boolean" select="false()"/>
		<xsl:param name="counter" />
		
		<xsl:variable name="title">
			<xsl:text>Error details</xsl:text>
		</xsl:variable>
		
		<xsl:variable name="content">	
			<xsl:element name="table">
				<xsl:call-template name="util:table-header" />
				
				<xsl:call-template name="util:single-element">
					<xsl:with-param name="name" select="'Error Location'"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Segment ID'"/>
					<xsl:with-param name="value" select=".//ERR.2.1"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Segment sequence'"/>
					<xsl:with-param name="value" select=".//ERR.2.2"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Field Position'"/>
					<xsl:with-param name="value" select=".//ERR.2.3"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Repetition'"/>
					<xsl:with-param name="value" select=".//ERR.2.4"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Component number'"/>
					<xsl:with-param name="value" select=".//ERR.2.5"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Sub-Component number'"/>
					<xsl:with-param name="value" select=".//ERR.2.6"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:chooseAmongThree">
					<xsl:with-param name="name" select="'HL7 Error Code'"/>
					<xsl:with-param name="option1" select=".//ERR.3.9"/>
					<xsl:with-param name="option2" select=".//ERR.3.2"/>
					<xsl:with-param name="option3" select=".//ERR.3.1"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Severity'"/>
					<xsl:with-param name="value" select=".//ERR.4"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:chooseAmongThree">
					<xsl:with-param name="name" select="'Application Error Code'"/>
					<xsl:with-param name="option1" select=".//ERR.5.9"/>
					<xsl:with-param name="option2" select=".//ERR.5.2"/>
					<xsl:with-param name="option3" select=".//ERR.5.1"/>
					<xsl:with-param name="ind" select="$ind2"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'Diagnostic information'"/>
					<xsl:with-param name="value" select=".//ERR.7"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
				
				<xsl:call-template name="util:element">
					<xsl:with-param name="name" select="'User message'"/>
					<xsl:with-param name="value" select=".//ERR.8"/>
					<xsl:with-param name="ind" select="$ind1"/>
				</xsl:call-template>
			</xsl:element>
		</xsl:variable>
		
		<xsl:call-template name="util:process-segment">
			<xsl:with-param name="output" select="$output" />
			<xsl:with-param name="multiple-segs" select="$multiple-segs" />
			<xsl:with-param name="counter" select="$counter"/>
			<xsl:with-param name="title" select="$title"/>
			<xsl:with-param name="content" select="$content" />
		</xsl:call-template>
		
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
</xsl:stylesheet>
