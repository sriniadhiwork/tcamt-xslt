<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="_common_tdspec_with_imports.xsl"/>
    <!-- param: output   values: plain-html    default: ng-tab-html -->
    <!--Generates html output to test results-->
    <xsl:param name="output" select="'ng-tab-html'"/>
    
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:element name="html">

            <xsl:element name="head">
                <xsl:if test="$output = 'ng-tab-html'">
                    <xsl:element name="script">
                        <xsl:attribute name="src">
                            <xsl:text>https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.js</xsl:text>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="script">
                        <xsl:attribute name="src">
                            <xsl:text>https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular-animate.js</xsl:text>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="script">
                        <xsl:attribute name="src">
                            <xsl:text>https://angular-ui.github.io/bootstrap/ui-bootstrap-tpls-0.13.4.js</xsl:text>
                        </xsl:attribute>
                    </xsl:element>
                    <xsl:element name="link">
                        <xsl:attribute name="href">
                            <xsl:text>https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css</xsl:text>
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
                </xsl:if>
            </xsl:element>

            <xsl:element name="title">tds-tcamt</xsl:element>

            <xsl:element name="body">
                <xsl:if test="$output = 'ng-tab-html'">
                    <xsl:attribute name="ng-app">
                        <xsl:text>tcamt.tds.demo</xsl:text>
                    </xsl:attribute>
                </xsl:if>

                <xsl:element name="div">
                    <xsl:if test="$output = 'ng-tab-html'">
                        <xsl:attribute name="ng-controller">
                            <xsl:text>AccordionDemoCtrl</xsl:text>
                        </xsl:attribute>
                    </xsl:if>

                    <xsl:apply-templates>
                        <xsl:with-param name="output">plain-html</xsl:with-param>
                        <!--<xsl:with-param name="output">ng-tab-html</xsl:with-param>-->
                    </xsl:apply-templates>

                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
