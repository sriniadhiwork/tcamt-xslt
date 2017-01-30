<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xi="http://www.w3.org/2001/XInclude"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xs" version="2.0">
	<!-- param: output   values: json | jquery-tab-html | ng-tab-html    default: plain-html -->
	<!--xsl:param name="output" select="'jquery-tab-html'" -->
	<!--<xsl:param name="output" select="'plain-html'"/>-->
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
	<xsl:variable name="generate-plain-html"
		select="$output = 'plain-html' or $output = 'ng-tab-html'"/>
	<!--  Use this section for supportd profiles -->
	<xsl:variable name="ACK" select="'ACK'"/>
	<xsl:variable name="LOI" select="'LOI'"/>
	<xsl:variable name="OML" select="'OML'"/>
	<xsl:variable name="ORL" select="'ORL'"/>

	<xsl:variable name="br">
		<xsl:value-of select="util:tag('br/', '')"/>
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
		<xsl:value-of select="util:start(name(.), 'test-data-specs-main')"/>
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
				<xsl:when test="starts-with(name(.), 'OML')">
					<xsl:value-of select="$OML"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'ORL')">
					<xsl:value-of select="$ORL"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<!-- - - - - - Acknolwedgement profiles - - - - - - - - - - - -->
		<xsl:if test="$message-type = $ACK">
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//MSA"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//ERR"/>
			</xsl:call-template>
		</xsl:if>

		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - OML display - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:if test="$message-type = $OML">
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
		</xsl:if>

		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - ORL display - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
		<xsl:if test="$message-type = $ORL">
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//MSA"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//ERR"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//PID"/>
			</xsl:call-template>
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="//ORC"/>
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
	<xsl:template name="display-repeating-segment-in-accordion">
		<xsl:param name="segments"/>
		<xsl:param name="mode"/>
		<xsl:variable name="multiple-segs" as="xs:boolean">
			<xsl:value-of select="count($segments) > 1"/>
		</xsl:variable>
		<xsl:if test="$multiple-segs">
			<xsl:value-of
				select="util:title('title', concat(util:segdesc(name($segments[1])), '[*]'), concat(util:segdesc(name($segments[1])), '[*]'), $ind1, false(), false(), false())"/>
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
					<xsl:with-param name="vertical-orientation" as="xs:boolean"
						select="$vertical-orientation"/>
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
		<xsl:value-of
			select="util:title('title', concat('Patient Information', $counter), concat('Patient Information', $counter), $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of
			select="util:element('Patient Name', concat(util:format-with-space(.//PID.5.2), util:format-with-space(.//PID.5.3), util:format-with-space(.//PID.5.1.1), .//PID.5.4), $ind1)"/>
		<xsl:value-of
			select="util:element('Mother''s Maiden Name', concat(util:format-with-space(.//PID.6.2), util:format-with-space(.//PID.6.3), util:format-with-space(.//PID.6.1.1), .//PID.6.4), $ind1)"/>
		<xsl:value-of select="util:element('Administrative Sex', util:admin-sex(.//PID.8), $ind1)"/>
		<xsl:value-of
			select="util:element('Date/Time of Birth', util:format-time(.//PID.7.1), $ind1)"/>
		<xsl:value-of select="util:element('Death Date/Time', util:format-time(.//PID.29.1), $ind1)"/>

		<xsl:for-each select=".//PID.11">
			<xsl:value-of
				select="util:format-address-multilines('Patient Address', .//PID.11.1.1, .//PID.11.2, concat(util:format-with-space(.//PID.11.3), util:format-with-space(.//PID.11.4), util:format-with-space(.//PID.11.5)), .//PID.11.6, $ind1)"
			/>
		</xsl:for-each>

		<xsl:for-each select=".//PID.13">
			<xsl:choose>
				<xsl:when test=".//PID.13.3 = 'PH'">
					<xsl:value-of
						select="util:element('Home phone number', util:format-tel2(.//PID.13.6, .//PID.13.7, .//PID.13.8), $ind1)"
					/>
				</xsl:when>
				<xsl:when test=".//PID.13.3 = 'X.400' or .//PID.13.3 = 'Internet'">
					<xsl:value-of select="util:element('Email address', .//PID.13.4, $ind1)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>

		<xsl:for-each select=".//PID.14">
			<xsl:choose>
				<xsl:when test=".//PID.14.3 = 'PH'">
					<xsl:value-of
						select="util:element('Business phone number', util:format-tel2(.//PID.14.6, .//PID.14.7, .//PID.14.8), $ind1)"
					/>
				</xsl:when>
				<xsl:when test=".//PID.14.3 = 'X.400' or .//PID.14.3 = 'Internet'">
					<xsl:value-of
						select="util:element('Business email address', .//PID.14.4, $ind1)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>

		<xsl:for-each select=".//PID.10">
			<xsl:value-of
				select="util:chooseAmongThree('Race', .//PID.10.9, .//PID.10.2, .//PID.10.1, $ind1)"
			/>
		</xsl:for-each>

		<xsl:for-each select=".//PID.22">
			<xsl:value-of
				select="util:chooseAmongThree('Ethnic group', .//PID.22.9, .//PID.22.2, .//PID.22.1, $ind1)"
			/>
		</xsl:for-each>

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
		<xsl:value-of
			select="util:title('title', concat('Next of kin information', $counter), concat('Next of kin information', $counter), $ind1, true(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:for-each select=".//NK1.3">
			<xsl:value-of
				select="util:chooseAmongThree('Relationship', .//NK1.3.9, .//NK1.3.2, .//NK1.3.1, $ind1)"
			/>
		</xsl:for-each>

		<xsl:if test="count(.//NK1.2)">
			<xsl:value-of
				select="util:element('Name', concat(util:format-with-space(.//NK1.2.2), util:format-with-space(.//NK1.2.3), util:format-with-space(.//NK1.2.1.1), .//NK1.2.4), $ind1)"
			/>
		</xsl:if>
		<xsl:value-of select="util:element('Organization name', .//NK1.13.1, $ind1)"/>
		<xsl:value-of select="util:element('Organization identifier', .//NK1.13.10, $ind1)"/>
		<xsl:value-of
			select="util:element('Contact person''s name', concat(util:format-with-space(.//NK1.30.2), util:format-with-space(.//NK1.30.3), util:format-with-space(.//NK1.30.1.1), util:format-with-space(.//NK1.30.4)), $ind1)"/>

		<xsl:if test="count(.//NK1.32)">
			<xsl:value-of
				select="util:format-address-multilines('Contact person''s address', .//NK1.32.1.1, .//NK1.32.2, concat(util:format-with-space(.//NK1.32.3), util:format-with-space(.//NK1.32.4), util:format-with-space(.//NK1.32.5)), .//NK1.32.6, $ind1)"
			/>
		</xsl:if>

		<xsl:for-each select=".//NK1.4">
			<xsl:value-of
				select="util:format-address-multilines('Address', .//NK1.4.1.1, .//NK1.4.2, concat(util:format-with-space(.//NK1.4.3), util:format-with-space(.//NK1.4.4), util:format-with-space(.//NK1.4.5)), .//NK1.4.6, $ind1)"
			/>
		</xsl:for-each>

		<xsl:for-each select=".//NK1.5">
			<xsl:choose>
				<xsl:when test=".//NK1.5.3 = 'PH'">
					<xsl:value-of
						select="util:element('Phone number', util:format-tel2(.//NK1.5.6, .//NK1.5.7, .//NK1.5.8), $ind1)"
					/>
				</xsl:when>
				<xsl:when test=".//NK1.5.3 = 'X.400' or .//NK1.5.3 = 'Internet'">
					<xsl:value-of select="util:element('Email address', .//NK1.5.4, $ind1)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
		<xsl:value-of
			select="util:chooseAmongThree('Contact role', .//NK1.7.9, .//NK1.7.2, .//NK1.7.1, $ind1)"/>
		<xsl:value-of
			select="util:element('Next of kin/Associated parties job code/Class', .//NK1.11.3, $ind1)"/>
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
		<xsl:value-of
			select="util:title('title', concat('Visit Information', $counter), concat('Visit Information', $counter), $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>

		<xsl:value-of select="util:element('Patient Class', .//PV1.2, $ind1)"/>
		<xsl:value-of select="util:element('Financial Class', .//PV1.20.1, $ind1)"/>

		<xsl:for-each select=".//PV1.22">
			<xsl:choose>
				<xsl:when test="count(.//PV1.22.9) > 0">
					<xsl:value-of select="util:element('Courtesy Code', .//PV1.22.9, $ind1)"/>
				</xsl:when>
				<xsl:when test="count(.//PV1.22.9) = 0 and count(.//PV1.22.2) > 0">
					<xsl:value-of select="util:element('Courtesy Code', .//PV1.22.2, $ind1)"/>
				</xsl:when>
				<xsl:when
					test="count(.//PV1.22.9) = 0 and count(.//PV1.22.2) = 0 and count(.//PV1.22.1) > 0">
					<xsl:value-of select="util:element('Courtesy Code', .//PV1.22.1, $ind1)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>

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
		<xsl:value-of
			select="util:title('title', concat('Insurance Information', $counter), 'Insurance Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>

		<xsl:for-each select=".//IN1.2">
			<xsl:choose>
				<xsl:when test="count(.//IN1.2.9) > 0">
					<xsl:value-of select="util:element('Insurance Plan ID', .//IN1.2.9, $ind1)"/>
				</xsl:when>
				<xsl:when test="count(.//IN1.2.9) = 0 and count(.//IN1.2.2) > 0">
					<xsl:value-of select="util:element('Insurance Plan ID', .//IN1.2.2, $ind1)"/>
				</xsl:when>
				<xsl:when
					test="count(.//IN1.2.9) = 0 and count(.//IN1.2.2) = 0 and count(.//IN1.2.1) > 0">
					<xsl:value-of select="util:element('Insurance Plan ID', .//IN1.2.1, $ind1)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>

		<xsl:value-of select="util:element('Insurance Company ID', .//IN1.3.1, $ind1)"/>
		<xsl:value-of select="util:element('Insurance Company Name', .//IN1.4.1, $ind1)"/>

		<xsl:value-of
			select="util:format-address-multilines('Insurance Company Address', .//IN1.5.1.1, .//IN1.5.2, concat(util:format-with-space(.//IN1.5.3), util:format-with-space(.//IN1.5.4), util:format-with-space(.//IN1.5.5)), .//IN1.5.6, $ind1)"/>

		<xsl:value-of select="util:element('Group Number', .//IN1.8, $ind1)"/>
		<xsl:value-of select="util:element('Insured s Group Employer Name', .//IN1.11.1, $ind1)"/>
		<xsl:value-of
			select="util:element('Insured s Group Employer Identifier', .//IN1.11.10, $ind1)"/>
		<xsl:value-of select="util:element('Plan Expiration Date', .//IN1.13, $ind1)"/>
		<xsl:value-of
			select="util:element('Name Of Insured', concat(util:format-with-space(.//IN1.16.2), util:format-with-space(.//IN1.16.3), util:format-with-space(.//IN1.16.1.1), util:format-with-space(.//IN1.16.4)), $ind1)"/>

		<xsl:choose>
			<xsl:when test="count(.//IN1.17.9) > 0">
				<xsl:value-of
					select="util:element('Insured s Relationship To Patient', .//IN1.17.9, $ind1)"/>
			</xsl:when>
			<xsl:when test="count(.//IN1.2.9) = 0 and count(.//IN1.17.2) > 0">
				<xsl:value-of
					select="util:element('Insured''s Relationship To Patient', .//IN1.17.2, $ind1)"
				/>
			</xsl:when>
			<xsl:when
				test="count(.//IN1.17.9) = 0 and count(.//IN1.17.2) = 0 and count(.//IN1.17.1) > 0">
				<xsl:value-of
					select="util:element('Insured''s Relationship To Patient', .//IN1.17.1, $ind1)"
				/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="util:element('Insured''s Relationship To Patient', '', $ind1)"
				/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:value-of
			select="util:element('Insured''s Date Of Birth', util:format-time(.//IN1.18.1), $ind1)"/>

		<xsl:value-of
			select="util:format-address-multilines('Insured Address', .//IN1.19.1.1, .//IN1.19.2, concat(util:format-with-space(.//IN1.19.3), util:format-with-space(.//IN1.19.4), util:format-with-space(.//IN1.19.5)), .//IN1.19.6, $ind1)"/>

		<xsl:value-of select="util:element('Type Of Agreement Code', .//IN1.31, $ind1)"/>
		<xsl:value-of select="util:element('Policy Number', .//IN1.36, $ind1)"/>

		<xsl:value-of select="util:end-elements($ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->



	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - 	Guarantor information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="GT1">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of
			select="util:title('title', concat('Guarantor Information', $counter), 'Guarantor Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of
			select="util:element('Guarantor Name', concat(util:format-with-space(.//GT1.3.2), util:format-with-space(.//GT1.3.3), util:format-with-space(.//GT1.3.1.1), .//GT1.3.4), $ind1)"/>
		<xsl:value-of
			select="util:format-address-multilines('Guarantor Address', .//GT1.5.1.1, .//GT1.5.2, concat(util:format-with-space(.//GT1.5.3), util:format-with-space(.//GT1.5.4), util:format-with-space(.//GT1.5.5)), .//GT1.5.6, $ind1)"/>

		<xsl:for-each select=".//GT1.11">
			<xsl:choose>
				<xsl:when test="count(.//GT1.11.9) > 0">
					<xsl:value-of
						select="util:element('Guarantor Relationship', .//GT1.11.9, $ind1)"/>
				</xsl:when>
				<xsl:when test="count(.//GT1.11.9) = 0 and count(.//GT1.11.2) > 0">
					<xsl:value-of
						select="util:element('Guarantor Relationship', .//GT1.11.2, $ind1)"/>
				</xsl:when>
				<xsl:when
					test="count(.//GT1.11.9) = 0 and count(.//GT1.11.2) = 0 and count(.//GT1.11.1) > 0">
					<xsl:value-of
						select="util:element('Guarantor Relationship', .//GT1.11.1, $ind1)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>

		<xsl:value-of select="util:element('Guarantor Organization Name', .//GT1.21.1, $ind1)"/>

		<xsl:value-of select="util:end-elements($ind1, $vertical-orientation, false())"/>

	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->



	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - 	Order  - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
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
						select="util:element('Call Back Phone number', util:format-tel2(.//ORC.14.6, .//ORC.14.7, .//ORC.14.8), $ind1)"
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
						select="util:element('Ordering Facility Phone number', util:format-tel2(.//ORC.23.6, .//ORC.23.7, .//ORC.23.8), $ind1)"
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
		<xsl:value-of
			select="util:element('Universal Service Identifier', util:format-time(..//OBR.4.2), $ind1)"/>
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
				<xsl:variable name="comment" select="replace(./NTE.3, '\\br\\', '&lt;br &#47;&gt;')"/>
				<xsl:value-of select="util:element('Comments', $comment, $ind1)"/>
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
			<xsl:for-each select=".//PRT.14">
				<xsl:value-of
					select="util:format-address-multilines('Address', ./PRT.14.1/PRT.14.1.1, ./PRT.14.2, concat(util:format-with-space(./PRT.14.3), util:format-with-space(./PRT.14.4), util:format-with-space(./PRT.14.5)), ./PRT.14.6, $ind1)"/>
			</xsl:for-each>
			<xsl:for-each select=".//PRT.15">
				<xsl:choose>
					<xsl:when test=".//PRT.15.3 = 'PH'">
						<xsl:value-of
							select="util:element('Phone Number', util:format-tel2(.//PRT.15.6, .//PRT.15.7, .//PRT.15.8), $ind1)"
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
	<!-- - - - - - Acknoledgment information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="MSA">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:value-of
			select="util:title('title', 'Acknowledgment', 'Acknowledgment', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>

		<xsl:value-of
			select="util:last-element('Acknowledgment code', .//MSA.1, $ind1, $vertical-orientation, false())"
		/>
	</xsl:template>

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - Error details information - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="ERR">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of
			select="util:title('title', concat('Error details', $counter), concat('Error details', $counter), $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>

		<xsl:value-of select="util:single-element('Error Location', $ind1)"/>
		<xsl:value-of select="util:element(concat($ind2, 'Segment ID'), .//ERR.2.1, $ind2)"/>
		<xsl:value-of select="util:element(concat($ind2, 'Segment Sequence'), .//ERR.2.2, $ind2)"/>
		<xsl:value-of select="util:element('Field Position', .//ERR.2.3, $ind2)"/>
		<xsl:value-of select="util:element('Field Repetition ', .//ERR.2.4, $ind2)"/>
		<xsl:value-of select="util:element('Component number', .//ERR.2.5, $ind2)"/>
		<xsl:value-of select="util:element('Sub-Component number', .//ERR.2.6, $ind2)"/>

		<xsl:value-of
			select="util:chooseAmongThree('HL7 Error Code', .//ERR.3.9, .//ERR.3.2, .//ERR.3.1, $ind1)"/>

		<xsl:value-of select="util:element('Severity', .//ERR.4, $ind1)"/>

		<xsl:value-of
			select="util:chooseAmongThree('Application Error Code', .//ERR.5.9, .//ERR.5.2, .//ERR.5.1, $ind1)"/>
		<xsl:value-of select="util:element('Diagnostic information', .//ERR.7, $ind1)"/>
		<xsl:value-of
			select="util:last-element('User message', .//ERR.8, $ind1, $vertical-orientation, false())"
		/>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->


	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  Includes - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:include href="_util.xsl"/>
	<xsl:include href="_plain-html.xsl"/>
	<xsl:include href="_ng-tab-html.xsl"/>
	<xsl:include href="_main-html.xsl"/>
	<xsl:include href="_css_tds.xsl"/>
	<xsl:include href="_hl7tables_min2.xsl"/>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  to nullify the effects of the unmatched segments due to apply-templates -->
	<!--<xsl:template match="*" mode="Syndromic"> </xsl:template>
	<xsl:template match="*" mode="LRI"> </xsl:template>-->
</xsl:stylesheet>
