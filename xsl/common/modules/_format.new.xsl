<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  Includes & papram - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - -->
	<xsl:include href="_css_tds.new.xsl"/>
	<xsl:include href="_common_tdspec_with_imports.new.xsl"/>
	<xsl:param name="output" select="'ng-tab-html'"/>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!--  ROOT TEMPLATE. Call corresponding sub templates based on the output desired (parametrized) -->
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
				<xsl:value-of select="concat('Unkwnown output', $output)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- plain-html : create a head with css and a body around the "main" template to make it a plain html -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="plain-html">
		<xsl:param name="output"/>
		<xsl:element name="html">
			<xsl:element name="head">
				<xsl:element name="title">tds-tcamt</xsl:element>
				<xsl:call-template name="css"/>
			</xsl:element>
			<xsl:element name="body">
				<xsl:element name="div">
					<xsl:attribute name="class">
						<xsl:text>test-data-specs-main</xsl:text>
					</xsl:attribute>
					<xsl:call-template name="main">
					</xsl:call-template>;
				</xsl:element>

			</xsl:element>
		</xsl:element>

	</xsl:template>
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->

	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<!-- ng-tab-html : create a head with css and a body around the "main" template -->
	<!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
	<xsl:template name="ng-tab-html">
		<xsl:param name="output"/>
		<xsl:element name="html">
			<xsl:element name="head">
				<xsl:element name="title">tds-tcamt</xsl:element>
				<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
					<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>-->
				<xsl:element name="script">
					<xsl:attribute name="src">
						<!--<xsl:text>https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.js</xsl:text>-->
						<xsl:text>../lib/angular.js</xsl:text>
					</xsl:attribute>
				</xsl:element>
				<xsl:element name="script">
					<xsl:attribute name="src">
						<!--<xsl:text>https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular-animate.js</xsl:text>-->
						<xsl:text>../lib/angular-animate.js</xsl:text>
					</xsl:attribute>
				</xsl:element>
				<xsl:element name="script">
					<xsl:attribute name="src">
						<!--<xsl:text>https://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.13.4.js</xsl:text>-->
						<xsl:text>../lib/ui-bootstrap-tpls-0.13.4.js</xsl:text>
					</xsl:attribute>
				</xsl:element>
				<xsl:element name="link">
					<xsl:attribute name="href">
						<!--<xsl:text>https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css</xsl:text>-->
						<xsl:text>../lib/bootstrap.min.css</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="rel">
						<xsl:text>stylesheet</xsl:text>
					</xsl:attribute>
				</xsl:element>
				<xsl:element name="script">
					<xsl:attribute name="type">
						<xsl:text>text/javascript</xsl:text>
					</xsl:attribute>
					<xsl:text>var app = angular.module('tcamt.tds.demo', ['ngAnimate', 'ui.bootstrap']);
						app.controller('AccordionDemoCtrl', function ($scope) {});</xsl:text>
				</xsl:element>
				<xsl:call-template name="css"/>
			</xsl:element>
			<xsl:element name="body">
				<xsl:attribute name="ng-app">
					<xsl:text>tcamt.tds.demo</xsl:text>
				</xsl:attribute>

				<xsl:element name="div">
					<xsl:attribute name="ng-controller">
						<xsl:text>AccordionDemoCtrl</xsl:text>
					</xsl:attribute>
					<xsl:call-template name="main">
					</xsl:call-template>;
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
