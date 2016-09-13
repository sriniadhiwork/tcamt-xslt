<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:util="http://hl7.nist.gov/data-specs/util"  exclude-result-prefixes="xs" version="2.0">
	<!-- param: output   values: json | jquery-tab-html | ng-tab-html    default: plain-html -->
	<!--xsl:param name="output" select="'json'" /-->
	<!--xsl:param name="output" select="'jquery-tab-html'" -->
	<!--xsl:param name="output" select="'plain-html'"/-->
	<xsl:param name="output" select="'ng-tab-html'" />
	<xsl:variable name="version" select="'1.5'"/>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- Release notes author:sriniadhi.work@gmail.com
	
	1.1: changed to use DRU.1.1 for deciding the title
	1.2 reversed substitution allowed yes-no
    1.4: using string in the yes-no instead of integer
    1.5: Substitution allowed bug
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
		<xsl:for-each-group select="//DRU" group-by=".//DRU.1.1">
			<xsl:call-template name="display-repeating-segment-in-accordion">
				<xsl:with-param name="segments" select="current-group()"/>
			</xsl:call-template>
		</xsl:for-each-group>
					
		<xsl:call-template name="display-repeating-segment-in-accordion">
			<xsl:with-param name="segments" select="//PVD[1]"/>
		</xsl:call-template>
		<xsl:call-template name="display-repeating-segment-in-accordion">
			<xsl:with-param name="segments" select="//PVD[2]"/>
		</xsl:call-template>
		<xsl:call-template name="display-repeating-segment-in-accordion">
			<xsl:with-param name="segments" select="//PTT"/>
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
		<xsl:message>testing0 <xsl:value-of select="$segments" /></xsl:message>
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
		<xsl:message>testing</xsl:message>
		<xsl:choose>
			<xsl:when test="$mode = ''">
				<xsl:apply-templates select=".">
					<xsl:with-param name="vertical-orientation" as="xs:boolean" select="$vertical-orientation"/>
					<xsl:with-param name="counter" select="$counter"/>
				</xsl:apply-templates>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:function name="util:yes-0-no-1">
	<xsl:param name="val"/>
	<xsl:choose>
		<xsl:when test="$val = '0' or $val = 'y' or $val = 'Y'"> <xsl:value-of select="'Yes'" /> </xsl:when>
		<xsl:otherwise> <xsl:value-of select="'No'" /> </xsl:otherwise>
	</xsl:choose>
	</xsl:function>

	<xsl:template match="DRU">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:variable name="prescription-type">
			<xsl:choose>
				<xsl:when test=".//DRU.1.1 = 'R'">Requested Medication</xsl:when>
				<xsl:when test=".//DRU.1.1 = 'P'">Prescribed Medication</xsl:when>
				<xsl:when test=".//DRU.1.1 = 'D'">Dispensed Medication</xsl:when>
				<xsl:otherwise>Medication</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="util:title('title', concat($prescription-type, $counter), $prescription-type, $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('Medication Name', .//DRU.1.2, $ind1)"/>
		<xsl:value-of select="util:element('Directions', concat(.//DRU.3.2, .//DRU.3.3), $ind1)"/>
		<xsl:value-of select="util:element('Quantity', .//DRU.2.2, $ind1)"/>
		<xsl:value-of select="util:element('Refills', .//DRU.6.2, $ind1)"/>
		<xsl:value-of select="util:last-element('Substitution Allowed?', util:yes-0-no-1(.//DRU.5.1), $ind1, $vertical-orientation, false())"/>
	</xsl:template>
	
	<xsl:template name="DRUG" >
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
	</xsl:template>
	
	<xsl:template match="PVD[1]">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Prescriber Information', $counter), 'Prescriber Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('First Name', .//PVD.5.2, $ind1)"/>
		<xsl:value-of select="util:element('Middle Name', .//PVD.5.3, $ind1)"/>
		<xsl:value-of select="util:element('Last Name', .//PVD.5.1, $ind1)"/>
		<xsl:value-of select="util:element('Clinic Name', .//PVD.7.1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 1', .//PVD.8.1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 2', .//PVD.8.1[2], $ind1)"/>
		<xsl:value-of select="util:element('City', .//PVD.8.2, $ind1)"/>
		<xsl:value-of select="util:element('State', .//PVD.8.3, $ind1)"/>
		<xsl:value-of select="util:element('ZIP Code', .//PVD.8.4, $ind1)"/>
		<xsl:value-of select="util:element('Phone', .//PVD.9.1, $ind1)"/>
		<xsl:value-of select="util:element('NPI', .//PVD.2.2.1, $ind1)"/>
		<xsl:value-of select="util:last-element('DEA Number', .//PVD.2.1.1, $ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<xsl:template match="PVD[2]">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Pharmacy Information', $counter), 'Pharmacy Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('Pharmacy Name', .//PVD.7.1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 1', .//PVD.8.1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 2', .//PVD.8.1[2], $ind1)"/>
		<xsl:value-of select="util:element('City', .//PVD.8.2, $ind1)"/>
		<xsl:value-of select="util:element('State', .//PVD.8.3, $ind1)"/>
		<xsl:value-of select="util:element('ZIP Code', .//PVD.8.4, $ind1)"/>
		<xsl:value-of select="util:element('Phone', .//PVD.9.1, $ind1)"/>
		<xsl:value-of select="util:element('NPI', .//PVD.2.2.1, $ind1)"/>
		<xsl:value-of select="util:last-element('NCPDP ID', .//PVD.2.1.1, $ind1, $vertical-orientation, false())"/>
	</xsl:template>
	<xsl:template match="PTT">
		<xsl:param name="vertical-orientation" as="xs:boolean"/>
		<xsl:param name="counter"/>
		<xsl:value-of select="util:title('title', concat('Patient Information', $counter), 'Patient Information', $ind1, false(), $vertical-orientation, false())"/>
		<xsl:value-of select="util:elements($ind1)"/>
		<xsl:value-of select="util:element('First Name', .//PTT.3.2, $ind1)"/>
		<xsl:value-of select="util:element('Middle Name', .//PTT.3.3, $ind1)"/>
		<xsl:value-of select="util:element('Last Name', .//PTT.3.1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 1', .//PTT.6.1, $ind1)"/>
		<xsl:value-of select="util:element('Address Line 2', .//PTT.6.1[2], $ind1)"/>
		<xsl:value-of select="util:element('City', .//PTT.6.2, $ind1)"/>
		<xsl:value-of select="util:element('State', .//PTT.6.3, $ind1)"/>
		<xsl:value-of select="util:element('ZIP Code', .//PTT.6.4, $ind1)"/>
		<xsl:value-of select="util:element('Phone', .//PTT.7.1, $ind1)"/>
		<xsl:value-of select="util:element('Date of Birth', .//PTT.2.1, $ind1)"/>
		<xsl:value-of select="util:last-element('Gender', .//PTT.4.1, $ind1, $vertical-orientation, false())"/>
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
