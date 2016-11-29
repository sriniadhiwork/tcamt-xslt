<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs" version="2.0">
	<!-- param: output   values: json | jquery-tab-html | ng-tab-html    default: plain-html -->
	<!--xsl:param name="output" select="'json'" /-->
	<!--xsl:param name="output" select="'jquery-tab-html'" -->
	<!-- <xsl:param name="output" select="'plain-html'"/> --> 
	<xsl:param name="output" select="'ng-tab-html'"/>
	<xsl:variable name="version" select="'2.10'"/>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- Release notes author:sriniadhi.work@gmail.com

	2.1:  Tabset support
	2.2:  Adding support for SS and major refactoring into imports and includes
	2.8:  Bugfixes for SS
	2.9:  Adding LRI support (.1 = fixed OBR.28[1], .2 bugfixes for SS, .3 LRI repeating elements .4: bug fix regarding repeating race/ethnicgroup/address) .5 added qpd.3.1 patient identifier, also fixing QPD.address info .6 more birth order stuff z22 as well
.7 fixed a bug in plain-html
.8 - Multiple birth indicator, Immunization Registry status
.9 LRI lab results
.10 added /.br/ for LRI NTE
.11 SS update for Observation Value condition
	-->
	
	<!--  Release notes author: caroline.rosin@nist.gov 
2.10 Bug fixes for LRI : 
	- fixed a bug in plain-html (fieldset not present)
	- fixed a bug in ng-tab-html : fixed Order Observation[*] tab 
	- removed comments and fixed minor typos
	- fixed css to avoid break in table
	- fixed typos in Ordering Provider Name table
	- fixed typos in Timing/Quantity Information table

-->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- character map is used for being able to output these special html entities directly after escaping -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:character-map name="tags">
		<xsl:output-character character="&lt;" string="&lt;"/>
		<xsl:output-character character="&gt;" string="&gt;"/>
	</xsl:character-map>
	<xsl:output method="html" use-character-maps="tags"/>
	<xsl:variable name="generate-plain-html" select="$output = 'plain-html' or $output = 'ng-tab-html'"/>
	<!--  Use this section for supportd profiles -->
	<xsl:variable name="ACK" select="'ACK'"/>
	<xsl:variable name="RSP" select="'RSP'"/>
	<xsl:variable name="LOI" select="'LOI'"/>

	<xsl:variable name="br">
		<xsl:value-of select="util:tag('br/', '')" />
	</xsl:variable>

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  ROOT TEMPLATE. Call corresponding sub templates based on the output desired (parametrized) -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="*">
		<xsl:choose>
			<xsl:when test="$output = 'plain-html'">
				<xsl:call-template name="plain-html"/>
			</xsl:when>
			<xsl:when test="$output = 'ng-tab-html'">
				<xsl:call-template name="ng-tab-html"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="main-html"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- This generates the structured DATA (html if it is 'plain-html'. Note that the main-html/jquery-tab-html call this in return -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="main">
		<!-- - - - programatically determine if it is a VXU or a QBP - -->
		<xsl:if test="$output = 'ng-tab-html'">
			<xsl:variable name="full">
				<xsl:call-template name="_main"/>
			</xsl:variable>
			<xsl:value-of select="util:begin-tab('FULL', 'All Segments', '', false())"/>
			<xsl:value-of select="util:strip-tabsets($full)"/>
			<xsl:value-of select="util:end-tab($ind1, false())"/>
		</xsl:if>
		<xsl:call-template name="_main"/>
		<xsl:value-of select="util:end($ind1)"/>
	</xsl:template>
	<xsl:template name="_main">
		<xsl:variable name="message-type">
			<xsl:choose>
				<xsl:when test="starts-with(name(.), 'ACK')">
					<xsl:value-of select="$ACK"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'ORU')">
					<xsl:value-of select="$LOI"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'OML')">
					<xsl:value-of select="$LOI"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- - - - - - Acknolwedgement profiles: showing a template saying that it is supplied by the system- - - - - - - - - - - -->
		<xsl:if test="$message-type = $ACK or $message-type = $RSP">
			<xsl:value-of select="util:title('title', 'Patient Information', 'Patient Information', $ind1, false(), false(), false())"/>
			<xsl:value-of select="util:elements($ind1)"/>
			<xsl:value-of select="util:single-element('This information will be automatically supplied by the System', $ind1)"/>
			<xsl:value-of select="util:end-elements($ind1, false(), false())"/>
		</xsl:if>

		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - LOI display - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:if test="$message-type = $LOI">
			<!-- - - - - - LOI - - - - - - - - - - - -->
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//PID"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//NK1"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//PV1"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//IN1"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//GT1"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//ORC"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//TQ1"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//OBR"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//NTE"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//PRT"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//DG1"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//OBX"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//SPM"/>
			</xsl:call-template>
			<!-- - - - Call with mode - - -  
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//PID"/>
				<xsl:with-param name="mode" select="'LRI'"/>
			</xsl:call-template>
			-->
		</xsl:if>
	</xsl:template>
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- Indentation values so that the output is readable -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:variable name="ind1" select="'&#9;&#9;'"/>
	<xsl:variable name="ind2" select="'&#9;&#9;&#9;&#9;&#9;'"/>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - display-segment-in-groups - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="display-repeating-segment-in-accordion">
		<xsl:param name="segments"/>
		<xsl:param name="mode"/>
		<xsl:variable name="multiple-segs" as="xs:boolean">
			<xsl:value-of select="count($segments) > 1"/>
			</xsl:variable>
			<xsl:if test="$multiple-segs">
				<xsl:value-of select="util:title('title', concat(util:segdesc(name($segments[1])), '[*]'),  concat(util:segdesc(name($segments[1])), '[*]'), $ind1, false(), false(), false())"/>
				<xsl:value-of select="util:tag('accordion', '')"/>
			</xsl:if>
			<xsl:for-each select="$segments">
				<xsl:variable name="index">
					<xsl:if test="$multiple-segs">
						<xsl:value-of select="concat(' - ', position())"/>
					</xsl:if>
				</xsl:variable>
				<xsl:call-template name="segments">
					<xsl:with-param name="vertical-orientation" as="xs:boolean" select="$multiple-segs"/>
					<xsl:with-param name="counter" select="$index"/>
					<xsl:with-param name="mode" select="$mode"/>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:if test="$multiple-segs">
				<xsl:value-of select="util:tag('/accordion', '')"/>
				<xsl:value-of select="util:end-tab($ind1, false())"/>
			</xsl:if>
		</xsl:template>
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!--  since mode parameter cannot be dynamic, using this approach which simply expands with xsl:when and calls the segments with different modes as constants -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:template name="segments">
			<xsl:param name="vertical-orientation" as="xs:boolean"/>
			<xsl:param name="counter"/>
			<xsl:param name="mode"/>
			<xsl:choose>
				<xsl:when test="$mode = ''">
					<xsl:apply-templates select=".">
						<xsl:with-param name="vertical-orientation" as="xs:boolean" select="$vertical-orientation"/>
						<xsl:with-param name="counter" select="$counter"/>
					</xsl:apply-templates>
				</xsl:when>
			</xsl:choose>
		</xsl:template>
	
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - Patient information - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:template match="PID">
			<xsl:param name="vertical-orientation" as="xs:boolean"/>
			<xsl:param name="counter"/>
			<xsl:value-of select="util:title('title', concat('Patient Information', $counter), 'Patient Information', $ind1, false(), $vertical-orientation, false())"/>
			<xsl:value-of select="util:elements($ind1)"/>
			<xsl:value-of select="util:element('Patient Name', concat(util:format-with-space(.//PID.5.2), util:format-with-space(.//PID.5.3), util:format-with-space(.//PID.5.1.1), .//PID.5.4), $ind1)"/>
			<xsl:value-of select="util:element('Mother''s Maiden Name', concat(util:format-with-space(.//PID.6.2), util:format-with-space(.//PID.6.3), util:format-with-space(.//PID.6.1.1), .//PID.6.4), $ind1)"/>
			<xsl:value-of select="util:element('Administrative Sex', util:admin-sex(.//PID.8), $ind1)"/>
			<xsl:value-of select="util:element('Date/Time of Birth',util:format-date(.//PID.7.1), $ind1)"/>
			<xsl:value-of select="util:element('Death Date/Time',util:format-date(.//PID.29.1), $ind1)"/>
			
			<xsl:value-of select="util:format-address-multilines('Patient Address', .//PID.11.1.1, .//PID.11.2, concat(util:format-with-space(.//PID.11.3), util:format-with-space(.//PID.11.4), util:format-with-space(.//PID.11.5)), .//PID.11.6, $ind1)" />

			<xsl:variable name="hpn" as="xs:boolean" select=".//PID.13.3 = 'PH'"/>
			<xsl:value-of select="util:element('Home phone number', util:IfThenElse($hpn, concat(util:format-with-space(.//PID.13.6), util:format-with-space(.//PID.13.7), util:format-with-space(.//PID.13.8)), ''), $ind1)"/>
			
			<xsl:variable name="ema" as="xs:boolean" select=".//PID.13.3 = 'X.400' or .//PID.13.3 = 'Internet'"/>
			<xsl:value-of select="util:element('Email address', util:IfThenElse($ema, .//PID.13.4, ''), $ind1)"/>
			
			<xsl:variable name="bpn" as="xs:boolean" select=".//PID.14.3 = 'PH'"/>
			<xsl:value-of select="util:element('Business phone number', util:IfThenElse($bpn, concat(util:format-with-space(.//PID.14.6), util:format-with-space(.//PID.14.7), util:format-with-space(.//PID.14.8)), ''), $ind1)"/>
			
			<xsl:variable name="bema" as="xs:boolean" select=".//PID.14.3 = 'X.400' or .//PID.14.3 = 'Internet'"/>
			<xsl:value-of select="util:element('Business email address', util:IfThenElse($bema, .//PID.14.4, ''), $ind1)"/>
			
			<xsl:choose>
				<xsl:when test="count(.//PID.10.9) > 0">
					<xsl:value-of select="util:element('Race', .//PID.10.9, $ind1)"/>
				</xsl:when>
				<xsl:when test="count(.//PID.10.9) = 0 and count(.//PID.10.2) > 0">
					<xsl:value-of select="util:element('Race', .//PID.10.2, $ind1)"/>
				</xsl:when>
				<xsl:when test="count(.//PID.10.9) = 0 and count(.//PID.10.2) = 0 and count(.//PID.10.1) > 0">
					<xsl:value-of select="util:element('Race', .//PID.10.1, $ind1)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="util:element('Race', '', $ind1)"/>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:choose>
				<xsl:when test="count(.//PID.22.9) > 0">
					<xsl:value-of select="util:element('Ethnic group', .//PID.22.9, $ind1)"/>
				</xsl:when>
				<xsl:when test="count(.//PID.22.9) = 0 and count(.//PID.22.2) > 0">
					<xsl:value-of select="util:element('Ethnic group', .//PID.22.2, $ind1)"/>
				</xsl:when>
				<xsl:when test="count(.//PID.10.9) = 0 and count(.//PID.22.2) = 0 and count(.//PID.22.1) > 0">
					<xsl:value-of select="util:element('Ethnic group', .//PID.22.1, $ind1)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="util:element('Ethnic group', '', $ind1)"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="util:end-elements($ind1, $vertical-orientation, false())"/>	
		</xsl:template>
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Next of kin - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="NK1">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Next of kin information', $counter), 'Next of kin information', $ind1, true(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>		
		<xsl:choose>
			<xsl:when test="count(.//NK1.3.9) > 0">
				<xsl:value-of select="util:element('Relationship', .//NK1.3.9, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(.//NK1.3.9) = 0 and count(.//NK1.3.2) > 0">
				<xsl:value-of select="util:element('Relationship', NK1.3.2, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(.//NK1.3.9) = 0 and count(.//NK1.3.2) = 0 and count(.//NK1.3.1) > 0">
				<xsl:value-of select="util:element('Relationship', NK1.3.1, $ind1)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:element('Relationship', '', $ind1)"/>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:value-of select="util:element('Name', concat(util:format-with-space(.//NK1.2.2), util:format-with-space(.//NK1.2.3), util:format-with-space(.//NK1.2.1.1), .//NK1.2.4), $ind1)"/>
		<xsl:value-of select="util:element('Organization name', NK1.13.1, $ind1)"/>
		<xsl:value-of select="util:element('Organization identifier', NK1.13.10, $ind1)"/>
		<xsl:value-of select="util:element('Contact person''s name', NK1.30, $ind1)"/>
		
		<xsl:value-of select="util:format-address-multilines('Contact person''s address', .//NK1.32.1.1, .//NK1.32.2, concat(util:format-with-space(.//NK1.32.3), util:format-with-space(.//NK1.32.4), util:format-with-space(.//NK1.32.5)), .//NK1.32.6, $ind1)" />
		
		<xsl:value-of select="util:format-address-multilines('Address', .//NK1.4.1.1, .//NK1.4.2, concat(util:format-with-space(.//NK1.4.3), util:format-with-space(.//NK1.4.4), util:format-with-space(.//NK1.4.5)), .//NK1.4.6, $ind1)" />
		
		<xsl:variable name="pn" as="xs:boolean" select=".//NK1.5.3 = 'PH'"/>
		<xsl:value-of select="util:element('Phone number', util:IfThenElse($pn, concat(util:format-with-space(.//NK1.5.6), util:format-with-space(.//NK1.5.7), util:format-with-space(.//NK1.5.8)), ''), $ind1)"/>
		
		<xsl:variable name="ema" as="xs:boolean" select=".//NK1.5.3 = 'X.400' or .//NK1.5.3 = 'Internet'"/>
		<xsl:value-of select="util:element('Email address', util:IfThenElse($ema, .//NK1.5.4, ''), $ind1)"/>
				
		<xsl:value-of select="util:element('Contact role', concat(util:format-with-space(.//NK1.7.9), util:format-with-space(.//NK1.7.2), .//NK1.7.1), $ind1)"/>	
		<xsl:value-of select="util:element('Next of kin/Associated parties job code/Class', .//NK1.11.3, $ind1)"/>	
		
		<xsl:value-of select="util:end-elements($ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Patient Visit information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="PV1">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Visit Information', $counter), 'Visit Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		
		<xsl:value-of select="util:element('Patient Class', PV1.2, $ind1)"/>
		<xsl:value-of select="util:element('Financial Class', PV1.20.1, $ind1)"/>
		
		<xsl:choose>
			<xsl:when test="count(PV1.22.9) > 0">
				<xsl:value-of select="util:element('Courtesy Code', PV1.22.9, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(PV1.22.9) = 0 and count(PV1.22.2) > 0">
				<xsl:value-of select="util:element('Courtesy Code', PV1.22.2, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(PV1.22.9) = 0 and count(PV1.22.2) = 0 and count(PV1.22.1) > 0">
				<xsl:value-of select="util:element('Courtesy Code', PV1.22.1, $ind1)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:element('Courtesy Code', '', $ind1)"/>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:value-of select="util:end-elements($ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Insurance information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="IN1">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Insurance Information', $counter), 'Insurance Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>

		<xsl:choose>
			<xsl:when test="count(IN1.2.9) > 0">
				<xsl:value-of select="util:element('Insurance Plan ID', IN1.2.9, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(IN1.2.9) = 0 and count(IN1.2.2) > 0">
				<xsl:value-of select="util:element('Insurance Plan ID', IN1.2.2, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(IN1.2.9) = 0 and count(IN1.2.2) = 0 and count(IN1.2.1) > 0">
				<xsl:value-of select="util:element('Insurance Plan ID', IN1.2.1, $ind1)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:element('Insurance Plan ID', '', $ind1)"/>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:value-of select="util:element('Insurance Company ID', IN1.3.1, $ind1)"/>
		<xsl:value-of select="util:element('Insurance Company Name', IN1.4.1, $ind1)"/>
		
		<xsl:value-of select="util:format-address-multilines('Insurance Company Address', .//IN1.5.1.1, .//IN1.5.2, concat(util:format-with-space(.//IN1.5.3), util:format-with-space(.//IN1.5.4), util:format-with-space(.//IN1.5.5)), .//IN1.5.6, $ind1)" />
		
		<xsl:value-of select="util:element('Group Number', IN1.8, $ind1)"/>
		<xsl:value-of select="util:element('Insured''s Group Employer Name', IN1.11, $ind1)"/>
		<xsl:value-of select="util:element('Plan Expiration Date', IN1.13, $ind1)"/>
		<xsl:value-of select="util:element('Name Of Insured', concat(util:format-with-space(.//IN1.16.2), util:format-with-space(.//IN1.16.3), util:format-with-space(.//IN1.16.1.1), util:format-with-space(.//IN1.16.4)), $ind1)"/>
		
		<xsl:choose>
			<xsl:when test="count(IN1.17.9) > 0">
				<xsl:value-of select="util:element('Insured''s Relationship To Patient', IN1.17.9, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(IN1.2.9) = 0 and count(IN1.17.2) > 0">
				<xsl:value-of select="util:element('Insured''s Relationship To Patient', IN1.17.2, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(IN1.17.9) = 0 and count(IN1.17.2) = 0 and count(IN1.17.1) > 0">
				<xsl:value-of select="util:element('Insured''s Relationship To Patient', IN1.17.1, $ind1)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:element('Insured''s Relationship To Patient', '', $ind1)"/>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:value-of select="util:element('Insured''s Date Of Birth',util:format-date(.//IN1.18.1), $ind1)"/>
		
		<xsl:value-of select="util:format-address-multilines('Insured Address', .//IN1.19.1.1, .//IN1.19.2, concat(util:format-with-space(.//IN1.19.3), util:format-with-space(.//IN1.19.4), util:format-with-space(.//IN1.19.5)), .//IN1.19.6, $ind1)" />
		
		<xsl:value-of select="util:element('Type Of Agreement Code', IN1.31, $ind1)"/>
		<xsl:value-of select="util:element('Policy Number', IN1.36, $ind1)"/>

		<xsl:value-of select="util:end-elements($ind1, $vertical-orientation, false())"/>
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
		<xsl:value-of select="util:title('title', concat('Patient Information', $counter), 'Patient Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('Patient Name', concat(util:format-with-space (.//QPD.4.2), util:format-with-space(.//QPD.4.3), .//QPD.4.1.1), $ind1)"/>
		<xsl:value-of select="util:element('Mother''s Maiden Name', .//QPD.5.1.1, $ind1)"/>
		<xsl:value-of select="util:element('ID Number', concat(util:format-with-space (.//QPD.3.1[1]), .//QPD.3.1[2]), $ind1)"/>
		<xsl:value-of select="util:element('Date/Time of Birth', util:format-date (.//QPD.6.1), $ind1)"/>
		<xsl:value-of select="util:element('Sex', util:admin-sex(.//QPD.7), $ind1)"/>
		<xsl:value-of select="util:element('Patient Address', util:format-address(.//QPD.8.1.1, .//QPD.8.3, .//QPD.8.4, .//QPD.8.5, .//QPD.8.6), $ind1)"/>
		<xsl:value-of select="util:element('Patient Phone', util:format-tel (.//QPD.9.6, .//QPD.9.7), $ind1)"/>
		<xsl:value-of select="util:element('Birth Indicator',util:yes-no(.//QPD.10), $ind1)"/>
		<xsl:value-of select="util:last-element('Birth Order',.//QPD.11, $ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Immunization Registry information - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:template match="PD1">
			<xsl:param name="vertical-orientation" as="xs:boolean"/>
			<xsl:param name="counter"/>
			<xsl:value-of select="util:title('title', concat('Immunization Registry Information', $counter), 'Immunization Registry Information', $ind1, true(), $vertical-orientation, false())"/>
			<xsl:value-of select="util:elements($ind1)"/>
			<xsl:value-of select="util:element('Immunization Registry Status', util:imm-reg-status(.//PD1.16), $ind1)"/>
			<xsl:value-of select="util:element('Immunization Registry Status Effective Date', util:format-date(.//PD1.17), $ind1)"/>
			<xsl:value-of select="util:element('Publicity Code', .//PD1.11.2, $ind1)"/>
			<xsl:value-of select="util:element('Publicity Code Effective Date', util:format-date(.//PD1.18), $ind1)"/>
			<xsl:value-of select="util:element('Protection Indicator', util:protection-indicator(.//PD1.12), $ind1)"/>
			<xsl:value-of select="util:last-element('Protection Indicator Effective Date', util:format-date(.//PD1.13), $ind1, $vertical-orientation, false())"/>
		</xsl:template>

		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->

		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - Vaccine Administration Information - - - - - - - - - - - -->
		<!-- Note the OBX subtable. Also, that the grouping based on OBX.4 -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:template match="RXA">
			<xsl:param name="vertical-orientation" as="xs:boolean"/>
			<xsl:param name="counter"/>
			<xsl:value-of select="util:title('title', concat('Vaccine Administration Information', $counter), 'Vaccine Administration Information', $ind1, true(), $vertical-orientation, false())"/>
			<xsl:value-of select="util:elements($ind1)"/>
			<xsl:value-of select="util:element('Administered Vaccine', .//RXA.5.2, $ind1)"/>
			<xsl:value-of select="util:element('Date/Time Start of Administration', util:format-date(.//RXA.3.1), $ind1)"/>
			<xsl:value-of select="util:element('Administered Amount', .//RXA.6, $ind1)"/>
			<xsl:value-of select="util:element('Administered Units', .//RXA.7.2, $ind1)"/>
			<xsl:value-of select="util:element('Administration Notes', 	.//RXA.9.2, $ind1)"/>
			<xsl:value-of select="util:element('Administering Provider', concat(util:format-with-space(.//RXA.10.3), .//RXA.10.2.1), $ind1)"/>
			<xsl:value-of select="util:element('Substance Lot Number', .//RXA.15, $ind1)"/>
			<xsl:value-of select="util:element('Substance Expiration Date',	util:format-date(.//RXA.16.1), $ind1)"/>
			<xsl:value-of select="util:element('Substance Manufacturer Name', .//RXA.17.2, $ind1)"/>
			<xsl:value-of select="util:element('Substance/Treatment Refusal Reason', util:sub-refusal-reason(.//RXA.18.2), $ind1)"/>
			<xsl:value-of select="util:element('Completion Status', util:completion-status(.//RXA.20), $ind1)"/>
			<xsl:value-of select="util:element('Action Code', util:action-code(.//RXA.21), $ind1)"/>
			<xsl:value-of select="util:element('Route', ..//RXR.1.2, $ind1)"/>
			<xsl:value-of select="util:element('Administration Site', ..//RXR.2.2, $ind1)"/>
			<xsl:value-of select="util:element('Entering Organization', ..//ORC.17.2, $ind1)"/>
			<xsl:value-of select="util:element('Entered By', concat(util:format-with-space(..//ORC.10.3),..//ORC.10.2.1), $ind1)"/>
			<xsl:value-of select="util:element('Ordered By', concat(util:format-with-space(..//ORC.12.3),..//ORC.12.2.1), $ind1)"/>
			<xsl:choose>
				<xsl:when test="count(..//OBX) > 0">
					<xsl:value-of select="util:end-table($ind1)"/>
					<xsl:value-of select="util:begin-sub-table($ind2)"/>
					<xsl:variable name="recordname" select="replace(.//RXA.9.2, '^(New immunization record)|(New record)$', 'Observations', 'i')"/>
					<xsl:value-of select="util:title-no-tab('title', $recordname, $recordname, $ind2, false())"/>
					<xsl:value-of select="util:elements($ind2)"/>
					<xsl:for-each-group select="..//OBX" group-by="OBX.4">
						<xsl:for-each select="current-group()">
							<xsl:apply-templates select="."/>
						</xsl:for-each>
						<!-- grey line after the group -->
						<xsl:if test="position () != last()">
							<xsl:value-of select="util:end-obx-group($ind2)"/>
						</xsl:if>
					</xsl:for-each-group>
					<xsl:choose>
						<xsl:when test="$generate-plain-html">
							<xsl:value-of select="util:end-sub-table($ind2, $vertical-orientation)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($nl, $indent, util:end-sub-table($ind2, $vertical-orientation), $ind2, '}', $nl, $ind2, '}', $nl, $ind1, ']', $nl)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="util:end-elements($ind1, $vertical-orientation, false())"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!--  Observation Table: The title is from RXA -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:template match="OBX">
			<xsl:variable name="obX.value">
				<xsl:choose>
					<xsl:when test=".//OBX.2= 'CE'">
						<xsl:value-of select=".//OBX.5.2"/>
					</xsl:when>
					<xsl:when test=".//OBX.2 = 'TS' or .//OBX.2 = 'DT'">
						<xsl:value-of select="util:format-date(.//OBX.5.1)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="util:element(.//OBX.3.2, $obX.value, $ind2)"/>
		</xsl:template>
		<xsl:template match="OBX" mode="Syndromic">
			<xsl:param name="vertical-orientation" as="xs:boolean"/>
			<xsl:param name="counter"/>
			<xsl:value-of select="util:title('title', concat('Observation Results Information', $counter), 'Observation Results Information', $ind1, true(), $vertical-orientation, false())"/>
			<xsl:value-of select="util:elements($ind1)"/>
			<xsl:value-of select="util:element('Observation  Identifier', util:valueset(.//OBX.3.1, 'Observation Identifier Syndromic Surveillance'), $ind1)"/>
			<xsl:variable name="observation-value">
				<xsl:choose>
					<xsl:when test=".//OBX.3.1 = 'SS003' and (..//PV1.2 = 'O' or ..//PV1.2 = 'E' or ..//PV1.2 = 'I')">
						<xsl:value-of select="util:value-or-valueset(.//OBX.5.2, .//OBX.5.1, 'PHVS_FacilityVisitType_SyndromicSurveillance')"/>
					</xsl:when>
					<xsl:when test=".//OBX.3.1 = '72166-2'">
						<xsl:value-of select="util:value-or-valueset(.//OBX.5.2, .//OBX.5.1, 'PHVS_SmokingStatus_MU')"/>
					</xsl:when>
					<xsl:when test=".//OBX.3.1 = '56816-2'">
						<xsl:value-of select="util:value-or-valueset(.//OBX.5.2, .//OBX.5.1, 'NHSNHealthcareServiceLocationCode')"/>
					</xsl:when>
					<xsl:when test=".//OBX.3.1 = 'SS002'">
						<xsl:value-of select="concat(.//OBX.5.1, .//OBX.5.3, util:valueset(.//OBX.5.4, 'PHVS_State_FIPS_5-2'), .//OBX.5.5, util:valueset(.//OBX.5.6, 'PHVS_Country_ISO_3166-1'), .//OBX.5.9)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select=".//OBX.5"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="util:element('Observation Value', $observation-value, $ind1)"/>
			<xsl:variable name="units">
				<xsl:choose>
					<xsl:when test=".//OBX.3.1 = '21612-7'">
						<xsl:value-of select="util:value-or-valueset(.//OBX.6.2 , .//OBX.6.1, 'PHVS_AgeUnit_SyndromicSurveillance')"/>
					</xsl:when>
					<xsl:when test=".//OBX.3.1 = '8302-2'">
						<xsl:value-of select="util:value-or-valueset(.//OBX.6.2 , .//OBX.6.1, 'PHVS_HeightUnit_UCUM')"/>
					</xsl:when>
					<xsl:when test=".//OBX.3.1 = '3141-9'">
						<xsl:value-of select="util:value-or-valueset(.//OBX.6.2 , .//OBX.6.1, 'PHVS_WeightUnit_UCUM')"/>
					</xsl:when>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="util:element('Units', $units, $ind1)"/>
			<xsl:value-of select="util:last-element('Observation Results Status', util:valueset(.//OBX.11, 'HL70085'), $ind1, $vertical-orientation, false())"/>
			<!--filter mask="OBX.6.1" title="Units" codeSystems="PHVS_TemperatureUnit_UCUM:PHVS_PulseOximetryUnit_UCUM:PHVS_AgeUnit_SyndromicSurveillance"/-->
		</xsl:template>
		<xsl:template match="ORC" mode="LRI">
			<xsl:param name="vertical-orientation" as="xs:boolean"/>
			<xsl:param name="counter"/>
			<xsl:value-of select="util:title('title', concat('Order Observation', $counter), 'Order Observation', $ind1, true(), $vertical-orientation, false())"/>

			<!-- Ordering Provider subtable -->
			<xsl:value-of select="util:begin-sub-table($ind2)"/> 
			<xsl:value-of select="util:title-no-tab('title', 'Ordering Provider', 'Ordering Provider', $ind2, false())"/>
			<xsl:value-of select="util:elements($ind2)"/>
			<xsl:value-of select="util:element('Name', concat(util:format-with-space(.//ORC.12.6), util:format-with-space(.//ORC.12.3), util:format-with-space(.//ORC.12.4), util:format-with-space(.//ORC.12.2.1), .//ORC.12.5), $ind1)"/>
			<xsl:value-of select="util:element('Identifier number', .//ORC.12.1, $ind1)"/>
			<xsl:value-of select="util:end-table-fieldset($ind1)"/>

			<!-- Observation Details subtable -->
			<xsl:value-of select="util:begin-sub-table($ind2)"/>
			<xsl:value-of select="util:title-no-tab('title', 'Observation Details', 'Observation Details', $ind2, false())"/>
			<xsl:value-of select="util:elements($ind2)"/>
			<xsl:value-of select="util:single-element('Observation General Information', $ind1)"/>
			<xsl:value-of select="util:element('Placer Order Number', .//ORC.2.1, $ind1)"/>
			<xsl:value-of select="util:element('Filler Order Number', .//ORC.3.1, $ind1)"/>
			<xsl:value-of select="util:element('Placer Group Number', .//ORC.4.1, $ind1)"/>
			<xsl:value-of select="util:element('&#160;', '&#160;',  $ind1)"/>
			<xsl:value-of select="util:single-element('Parent Universal Service Identifier', $ind1)"/>
			<xsl:value-of select="util:element('Identifier', .//ORC.31.1, $ind1)"/>
			<xsl:value-of select="util:element('Text', .//ORC.31.2, $ind1)"/>
			<xsl:value-of select="util:element('Alt Identifier', .//ORC.31.4, $ind1)"/>
			<xsl:value-of select="util:element('Alt Text', .//ORC.31.5, $ind1)"/>
			<xsl:value-of select="util:element('Original Text', .//ORC.31.9, $ind1)"/>
			<xsl:value-of select="util:element('&#160;', '&#160;',  $ind1)"/>
			<xsl:value-of select="util:single-element('Observation Details', $ind1)"/>
			<xsl:value-of select="util:element('Universal Service Identifier', ..//OBR.4.2, $ind1)"/>
			<xsl:value-of select="util:element('Observation Date/Time', util:format-time(..//OBR.7.1), $ind1)"/>
			<xsl:value-of select="util:element('Observation end Date/Time', util:format-time(..//OBR.8.1), $ind1)"/>
			<xsl:value-of select="util:element('Specimen Action Code', ..//OBR.11, $ind1)"/>
			<xsl:value-of select="util:element('Relevant Clinical Information', ..//OBR.13.2, $ind1)"/>
			<xsl:value-of select="util:element('Relevant Clinical Information Original Text', ..//OBR.13.9, $ind1)"/>
			<xsl:value-of select="util:element('&#160;', '&#160;',  $ind1)"/>
			<xsl:value-of select="util:single-element('Observation Result Information', $ind1)"/>
			<xsl:value-of select="util:element('Result Status', ..//OBR.25, $ind1)"/>
			<xsl:value-of select="util:element('Results Report/Status Change - Date/Time', util:format-time(..//OBR.22.1), $ind1)"/>
			<xsl:value-of select="util:element('&#160;', '&#160;',  $ind1)"/>

			<xsl:for-each select="..//OBR.28">
				<xsl:value-of select="util:single-element(concat('Results Copy To', util:blank-if-1-variant2(position(), count(..//OBR.28))), $ind1)"/>
				<xsl:value-of select="util:element('Name', concat(util:format-with-space(OBR.28.6), util:format-with-space(OBR.28.3), util:format-with-space(OBR.28.4), util:format-with-space(OBR.28.2.1), OBR.28.5), $ind1)"/>
				<xsl:value-of select="util:element('Identifier', OBR.28.1, $ind1)"/>
				<xsl:value-of select="util:element('&#160;', '&#160;',  $ind1)"/>
			</xsl:for-each>

			<xsl:value-of select="util:single-element('Results Handling', $ind1)"/>
			<xsl:value-of select="util:element('Standard', ..//OBR.49.9, $ind1)"/>
			<xsl:value-of select="util:element('&#160;', '&#160;',  $ind1)"/>
			<xsl:value-of select="util:single-element('Observation Notes', $ind1)"/>
			<xsl:for-each select="../NTE">
				<xsl:value-of select="util:element('Notes and comments', replace(.//NTE.3, '\\\\.br\\\\', $br), $ind1)"/>
			</xsl:for-each>
			<xsl:value-of select="util:single-element('', $ind1)"/>
			<xsl:value-of select="util:end-table-fieldset($ind1)"/> 

			<!-- Timing/Quantity Information subtable -->
			<xsl:value-of select="util:begin-sub-table($ind1)"/>
			<xsl:value-of select="util:title-no-tab('title', 'Timing/Quantity Information', 'Timing/Quantity Information', $ind1, false())"/>
			<xsl:value-of select="util:elements($ind2)"/>
			<xsl:value-of select="util:element('Priority', ..//TQ1.9.2, $ind2)"/>
			<xsl:value-of select="util:element('Start Date/time	', util:format-time(..//TQ1.7.1), $ind2)"/>
			<xsl:value-of select="util:element('End Date/time', util:format-time(..//TQ1.8.1), $ind2)"/>
			<xsl:value-of select="util:end-table-fieldset($ind1)"/>

			<!-- <xsl:variable name="multiple-obx" select="count(..//OBX) > 1"/>
				<xsl:for-each select="..//OBX">
					<xsl:variable name="index">
						<xsl:if test="$multiple-obx">
							<xsl:value-of select="concat(' - ', position())"/>
						</xsl:if>
					</xsl:variable>
					<xsl:value-of select="util:begin-sub-table($ind2)"/>
					<xsl:value-of select="util:title-no-tab('title', concat('Results Performing Laboratory', $index), concat('Results Performing Laboratory',  $index), $ind2, false())"/>
					<xsl:value-of select="util:elements($ind2)"/>
					<xsl:value-of select="util:element('Laboratory Name', .//OBX.23.1, $ind1)"/>
					<xsl:value-of select="util:element('Organization identifier', .//OBX.23.10, $ind1)"/>
					<xsl:value-of select="util:element('Address', util:format-address(.//OBX.24.1.1, .//OBX.24.2, concat(.//OBX.24.3, ' ', .//OBX.24.4), .//OBX.24.5, .//OBX.24.6), $ind1)"/>
					<xsl:value-of select="util:element('Director Name', concat(util:format-with-space(.//OBX.25.6), util:format-with-space(.//OBX.25.3), util:format-with-space(.//OBX.25.4), util:format-with-space(.//OBX.25.2.1), util:format-with-space(.//OBX.25.5)), $ind1)"/>
					<xsl:value-of select="util:element('Director identifier', .//OBX.25.1, $ind1)"/>
					<xsl:value-of select="util:end-table-fieldset($ind1)"/>
				</xsl:for-each> -->
				
			<xsl:variable name="at-least-one-obx" select="count(..//OBX) &gt; 0"/>
				<xsl:if test="$at-least-one-obx">
					<xsl:for-each select="..//OBX">
						<xsl:if test="position() = 1 ">
							<!-- Results Performing Laboratory subtable -->
							<xsl:value-of select="util:begin-sub-table($ind2)"/>
							<xsl:value-of select="util:title-no-tab('title', 'Results Performing Laboratory', 'Results Performing Laboratory', $ind2, false())"/>
							<xsl:value-of select="util:elements($ind2)"/>
							<xsl:value-of select="util:element('Laboratory Name', .//OBX.23.1, $ind1)"/>
							<xsl:value-of select="util:element('Organization identifier', .//OBX.23.10, $ind1)"/>
							<xsl:value-of select="util:element('Address', util:format-address(.//OBX.24.1.1, .//OBX.24.2, concat(.//OBX.24.3, ' ', .//OBX.24.4), .//OBX.24.5, .//OBX.24.6), $ind1)"/>
							<xsl:value-of select="util:element('Director Name', concat(util:format-with-space(.//OBX.25.6), util:format-with-space(.//OBX.25.3), util:format-with-space(.//OBX.25.4), util:format-with-space(.//OBX.25.2.1), util:format-with-space(.//OBX.25.5)), $ind1)"/>
							<xsl:value-of select="util:element('Director identifier', .//OBX.25.1, $ind1)"/>
							<xsl:value-of select="util:end-table-fieldset($ind1)"/>
						</xsl:if>
					</xsl:for-each>				
				</xsl:if>
				<xsl:variable name="multiple-specimens" select="count(..//SPM) > 1"/>
					<xsl:for-each select="..//SPM">
						<xsl:variable name="index">
							<xsl:if test="$multiple-specimens">
								<xsl:value-of select="concat(' - ', position())"/>
							</xsl:if>
						</xsl:variable>
						<!-- Specimen Information -->
						<xsl:value-of select="util:begin-sub-table($ind2)"/>
						<xsl:value-of select="util:title-no-tab('title', concat('Specimen Information', $index), concat('Specimen Information', $index), $ind2, false())"/>
						<xsl:value-of select="util:elements($ind2)"/>
						<xsl:value-of select="util:element('Specimen Type', .//SPM.4.2, $ind1)"/>
						<xsl:value-of select="util:element('Alt Specimen Type', .//SPM.4.5, $ind1)"/>
						<xsl:value-of select="util:element('Specimen Original Text', .//SPM.4.9, $ind1)"/>
						<xsl:value-of select="util:element('Start date/time', .//SPM.17.1.1, $ind1)"/>
						<xsl:for-each select="..//SPM.21">
							<xsl:value-of select="util:element(concat('Specimen Reject Reason', util:blank-if-1-variant2(position(), count(..//SPM.21))), SPM.21.2, $ind1)"/>
							<xsl:value-of select="util:element(concat('Alt Specimen Reject Reason', util:blank-if-1-variant2(position(), count(..//SPM.21))), SPM.21.5, $ind1)"/>
							<xsl:value-of select="util:element(concat('Reject Reason Original Text', util:blank-if-1-variant2(position(), count(..//SPM.21))), SPM.21.9, $ind1)"/>
						</xsl:for-each>
						<xsl:for-each select="..//SPM.24">
							<xsl:value-of select="util:element(concat('Specimen Condition', util:blank-if-1-variant2(position(), count(..//SPM.24))), SPM.24.2, $ind1)"/>
							<xsl:value-of select="util:element(concat('Alt Specimen Condition', util:blank-if-1-variant2(position(), count(..//SPM.24))), SPM.24.5, $ind1)"/>
							<xsl:value-of select="util:element(concat('Condition Original Text', util:blank-if-1-variant2(position(), count(..//SPM.24))), SPM.24.9, $ind1)"/>
						</xsl:for-each>
						<xsl:value-of select="util:end-table-fieldset($ind1)"/>
					</xsl:for-each>

					<!-- Lab results -->
					<xsl:value-of select="util:begin-sub-table($ind2)"/>
					<xsl:value-of select="util:title-no-tab('title',  'Lab results', 'Lab results', $ind2, false())"/>
					<xsl:value-of select="util:elements-with-colspan(9, $ind2)"/>
					<xsl:value-of select="util:element-var-cols('Test performed', util:or5(..//OBR.4.9, ..//OBR.4.2, ..//OBR.4.5, '', ''), 9, $ind1)"/>
					<xsl:value-of select="util:element-var-cols('Test Report date', util:format-date(..//OBR.22.1), 9, $ind1)"/>

					<xsl:variable name="at-least-one-obx" select="count(..//OBX) > 0"/>

						<xsl:if test="$at-least-one-obx" >

							<xsl:value-of select="util:elements9-header('Result Observation Name',  'Result', 'UOM', 'Range', 'Abnormal Flag', 'Status', 'Date/Time of Observation', 'Date/Time of Analysis', 'Notes', $ind2)"/>

							<xsl:for-each select="..//OBX">
								<xsl:variable name="notes">
									<xsl:for-each select="..//NTE">
										<xsl:value-of select="concat(replace(current()/NTE.3, '\\.br\\', $br), $nl)" />
									</xsl:for-each>
								</xsl:variable>
								<xsl:value-of select="util:elements9(util:or5(.//OBX.3.9, ..//OBX.3.2, ..//OBX.3.5, '', ''), util:obx-result(current()), util:or5(.//OBX.6.9, .//OBX.6.2, .//OBX.6.5, .//OBX.6.1, .//OBX.6.4), .//OBX.7, .//OBX.8, .//OBX.11, util:format-date(.//OBX.14.1), util:format-date(.//OBX.19.1), $notes, '', $ind2)"/>	
							</xsl:for-each>


						</xsl:if>

						<xsl:value-of select="util:end-table-fieldset($ind1)"/>


						<xsl:value-of select="util:end-tab($ind1, $vertical-orientation)"/>
					</xsl:template>
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!--  Observation Table: The title is from RXA -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<xsl:template match="OBX">
						<xsl:variable name="obX.value">
							<xsl:choose>
								<xsl:when test=".//OBX.2= 'CE'">
									<xsl:value-of select=".//OBX.5.2"/>
								</xsl:when>
								<xsl:when test=".//OBX.2 = 'TS' or .//OBX.2 = 'DT'">
									<xsl:value-of select="util:format-date(.//OBX.5.1)"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="util:element(.//OBX.3.2, $obX.value, $ind2)"/>
					</xsl:template>
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  Iincludes - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<xsl:include href="_util.xsl"/>
					<xsl:include href="_plain-html.xsl"/>
					<xsl:include href="_ng-tab-html.xsl"/>
					<xsl:include href="_main-html.xsl"/>
					<xsl:include href="_css_tds.xsl"/>
					<xsl:include href="_hl7tables_min2.xsl"/>
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
					<!--  to nullify the effects of the unmatched segments due to apply-templates -->
					<xsl:template match="*" mode="Syndromic">
					</xsl:template>
					<xsl:template match="*" mode="LRI">
					</xsl:template>
				</xsl:stylesheet>
				