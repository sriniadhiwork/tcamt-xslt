<?altova_samplexml file:///C:/Users/sna10/DEV/Source/xslt/nistmu2hl7xslt/trunk/xml/e-rx/Test%20data%20specification%201.xml?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:util="http://hl7.nist.gov/data-specs/util" xpath-default-namespace="http://www.ncpdp.org/schema/SCRIPT" exclude-result-prefixes="xs" version="2.0">
	<!-- param: output   values: json | jquery-tab-html | ng-tab-html    default: plain-html -->
	<!--xsl:param name="output" select="'json'" /-->
	<!--xsl:param name="output" select="'jquery-tab-html'" -->
	<xsl:param name="output" select="'plain-html'"/>
	<!--xsl:param name="output" select="'ng-tab-html'"/-->
	<xsl:variable name="version" select="'1.0'"/>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- Release notes author:sriniadhi.work@gmail.com


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
	<!--  This is the example format for the JSON output -->
	<!-- Example format: { "tables": [ { "title": "Patient Information", "elements": 
		[ { "element" : "Patient Name", "data" : "Madelynn Ainsley" }, { "element" 
		: "Mother's Maiden Name", "data" : "Morgan" }, { "element" : "ID Number", 
		"data" : "A26376273 D26376273 " }, { "element" : "Date/Time of Birth", "data" 
		: "07/02/2015" }, ... ] }, ] }
	 -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  ROOT TEMPLATE. Call corresponding sub templates based on the output desired (parametrized) -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template match="*">
	<xsl:variable name="filename" select="replace(base-uri(), 'xml$', 'html')" />
	
	<xsl:result-document href="{$filename}" method="html">
		<xsl:choose>
			<xsl:when test="$output = 'json'">
				<xsl:call-template name="main"/>
			</xsl:when>
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
	</xsl:result-document>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- This generates the structured DATA (json if output is 'json' and html if it is 'plain-html'. Note that the main-html/jquery-tab-html call this in return -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="main">
		<!-- Add profile information if it is json -->
		<xsl:value-of select="util:start(name(.), 'test-data-specs-main')"/>
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
		<xsl:call-template name="display-repeating-segment-in-accordion">
			<xsl:with-param name="segments" select="//MedicationPrescribed"/>
		</xsl:call-template>
		<xsl:call-template name="display-repeating-segment-in-accordion">
			<xsl:with-param name="segments" select="//Prescriber"/>
		</xsl:call-template>
		<xsl:call-template name="display-repeating-segment-in-accordion">
			<xsl:with-param name="segments" select="//Pharmacy"/>
		</xsl:call-template>
		<xsl:call-template name="display-repeating-segment-in-accordion">
			<xsl:with-param name="segments" select="//Patient"/>
		</xsl:call-template>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- Indentation values so that the output is readable -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:variable name="ind1" select="'&#x9;&#x9;'"/>
	<xsl:variable name="ind2" select="'&#x9;&#x9;&#x9;&#x9;&#x9;'"/>
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
			<xsl:value-of select="count($segments) &gt; 1"/>
		</xsl:variable>
		<xsl:if test="$multiple-segs">
			<xsl:value-of select="util:title('title', concat(util:segdesc(name($segments[1])), '[*]'),  concat(util:segdesc(name($segments[1])), '[*]'), $ind1, false(), false(), false())"/>
			<xsl:value-of select="util:tag('accordion', '')"/>
		</xsl:if>
		<xsl:for-each select="$segments">
		<xsl:message>testing</xsl:message>
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
	<xsl:template match="MedicationPrescribed">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Prescription Information', $counter), 'Prescription Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('Medication Name', DrugDescription, $ind1)"/>
		<xsl:value-of select="util:element('Directions', Directions, $ind1)"/>
		<xsl:value-of select="util:element('Quantity', Quantity/Value, $ind1)"/>
		<xsl:value-of select="util:element('Refills', Refills/Value, $ind1)"/>
		<xsl:value-of select="util:last-element('Substitution Allowed?', Substitutions, $ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<xsl:template match="Prescriber">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Prescriber Information', $counter), 'Prescriber Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('First Name', Name/FirstName, $ind1)"/>
		<xsl:value-of select="util:element('Middle Name', Name/MiddleName, $ind1)"/>
		<xsl:value-of select="util:element('Last Name', Name/LastName, $ind1)"/>
		<xsl:value-of select="util:element('Clinic Name', ClinicName, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 1', Address/AddressLine1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 2', Address/AddressLine2, $ind1)"/>
		<xsl:value-of select="util:element('City', Address/City, $ind1)"/>
		<xsl:value-of select="util:element('State', Address/State, $ind1)"/>
		<xsl:value-of select="util:element('ZIP Code', Address/ZipCode, $ind1)"/>
		<xsl:value-of select="util:element('Phone', CommunicationNumbers/Communication/Number, $ind1)"/>
		<xsl:value-of select="util:element('NPI', Identification/NPI, $ind1)"/>
		<xsl:value-of select="util:last-element('DEA Number', Identification/DEANumber, $ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<xsl:template match="Pharmacy">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Pharmacy Information', $counter), 'Pharmacy Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('Pharmacy Name', StoreName, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 1', Address/AddressLine1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 2', Address/AddressLine2, $ind1)"/>
		<xsl:value-of select="util:element('City', Address/City, $ind1)"/>
		<xsl:value-of select="util:element('State', Address/State, $ind1)"/>
		<xsl:value-of select="util:element('ZIP Code', Address/ZipCode, $ind1)"/>
		<xsl:value-of select="util:element('Phone', CommunicationNumbers/Communication/Number, $ind1)"/>
		<xsl:value-of select="util:element('NPI', Identification/NPI, $ind1)"/>
		<xsl:value-of select="util:last-element('NCPDP ID', Identification/NCPDPID, $ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<xsl:template match="Patient">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Patient Information', $counter), 'Patient Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('First Name', Name/FirstName, $ind1)"/>
		<xsl:value-of select="util:element('Middle Name', Name/MiddleName, $ind1)"/>
		<xsl:value-of select="util:element('Last Name', Name/LastName, $ind1)"/>
		<xsl:value-of select="util:element('Clinic Name', ClinicName, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 1', Address/AddressLine1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 2', Address/AddressLine2, $ind1)"/>
		<xsl:value-of select="util:element('City', Address/City, $ind1)"/>
		<xsl:value-of select="util:element('State', Address/State, $ind1)"/>
		<xsl:value-of select="util:element('ZIP Code', Address/ZipCode, $ind1)"/>
		<xsl:value-of select="util:element('Phone', CommunicationNumbers/Communication/Number, $ind1)"/>
		<xsl:value-of select="util:element('Date of Birth', DateOfBirth/Date, $ind1)"/>
		<xsl:value-of select="util:last-element('Gender', Gender, $ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  Iincludes - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:include href="../../common/modules/_plain-html.xsl"/>
	<xsl:include href="../../common/modules/_ng-tab-html.xsl"/>
	<xsl:include href="../../common/modules/_main-html.xsl"/>
	<xsl:include href="../../common/modules/_css_tds.xsl"/>
	<xsl:include href="../../common/modules/_hl7tables_min2.xsl"/>
	<xsl:include href="../../common/modules/_util.xsl"/>
</xsl:stylesheet>
