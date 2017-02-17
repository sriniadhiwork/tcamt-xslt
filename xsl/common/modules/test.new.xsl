<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:util="http://hl7.nist.gov/data-specs/util" xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <!--<xsl:include href="_format.new.xsl"/>-->
    <!-- param: output   values: plain-html    default: ng-tab-html -->
    <!--Generates html output to test results-->
    <xsl:param name="output" select="'ng-tab-html'"/>
    <!--<xsl:param name="output"  select="'plain-html'" />-->
    <xsl:param name="status" select="'online'"></xsl:param>
    <!--<xsl:param name="status" select="'offline'"></xsl:param>-->
    
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:apply-templates>
            <xsl:with-param name="output" select="$output"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
    <!-- - - - - - - - - - - - - - - - - - - - - -  Includes & param - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - -->
    <xsl:include href="_css_tds.new.xsl"/>
    <xsl:include href="_tdspec_loi.xsl"/>
    
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
                <xsl:value-of select="concat('Unkwnown output: ', $output)" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
    <!-- plain-html : create a head with css and a body around the "main" template to make it a plain html -->
    <!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
    <xsl:template name="plain-html">
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
                        <xsl:with-param name="output" select="$output"/>
                    </xsl:call-template>
                </xsl:element>
                
            </xsl:element>
        </xsl:element>
        
    </xsl:template>
    <!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
    
    <!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
    <!-- ng-tab-html : create a head with css and a body around the "main" template -->
    <!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
    <xsl:template name="ng-tab-html">
        <xsl:element name="html">
            <xsl:element name="head">
                <xsl:element name="title">tds-tcamt</xsl:element>
                <xsl:choose>
                    <xsl:when test="$status = 'offline'">
                        <xsl:element name="script">
                            <xsl:attribute name="src">
                                <xsl:text>../lib/angular.js</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                        <xsl:element name="script">
                            <xsl:attribute name="src">
                                <xsl:text>../lib/angular-animate.js</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                        <xsl:element name="script">
                            <xsl:attribute name="src">
                                <xsl:text>../lib/ui-bootstrap-tpls-0.13.4.js</xsl:text>
                            </xsl:attribute>
                        </xsl:element>
                        <xsl:element name="link">
                            <xsl:attribute name="href">
                                <xsl:text>../lib/bootstrap.min.css</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="rel">
                                <xsl:text>stylesheet</xsl:text>
                            </xsl:attribute>
                        </xsl:element>  
                    </xsl:when>
                    <xsl:otherwise>
                        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
                            <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>-->
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
                    </xsl:otherwise>
                </xsl:choose>
                
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
                        <xsl:with-param name="output" select="$output"/>
                    </xsl:call-template>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
    <xsl:template name="main">
        <xsl:param name="output"/>
        <!--<xsl:param name="version"/>
            <xsl:comment>
            <xsl:value-of select="concat('generated by common_tdspec.xslt Version:', $version, '   Profile:', name(.))" />
            </xsl:comment>-->
        
        <xsl:element name="fieldset">
            <xsl:element name="div">
                <xsl:attribute name="class">
                    <xsl:text>test-data-specs-main</xsl:text>
                </xsl:attribute>
                <xsl:if test="$output = 'ng-tab-html'">
                    <xsl:element name="tabset">						
                        <xsl:element name="tab">
                            <xsl:attribute name="heading">
                                <xsl:value-of select="'FULL'"/>
                            </xsl:attribute>
                            <xsl:element name="div">
                                <xsl:attribute name="class">
                                    <xsl:text>panel panel-info</xsl:text>
                                </xsl:attribute>
                                <xsl:element name="div">
                                    <xsl:attribute name="class">
                                        <xsl:text>panel-body</xsl:text>
                                    </xsl:attribute>
                                    <xsl:call-template name="_main">
                                        <xsl:with-param name="output" select="'plain-html'"/>
                                    </xsl:call-template>
                                    
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                        <xsl:call-template name="_main">
                            <xsl:with-param name="output" select="$output"/>
                        </xsl:call-template>
                    </xsl:element>
                </xsl:if>
                <xsl:if test="$output = 'plain-html'">
                    <xsl:call-template name="_main">
                        <xsl:with-param name="output" select="$output"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <!-- - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - -->
    <!-- - - - - - display-segment-in-groups - - - - - - - - - - - -->
    <xsl:template name="display-repeating-segment-in-accordion">
        <xsl:param name="segments"/>
        <xsl:param name="output" />
        <xsl:variable name="multiple-segs" as="xs:boolean">
            <xsl:value-of select="count($segments) > 1"/>
        </xsl:variable>
        <xsl:variable name="tabname">
            <xsl:if test="$multiple-segs">
                <xsl:value-of select="concat(util:segdesc(name($segments[1])), '[*]')"/>
            </xsl:if>
            <xsl:if test="not($multiple-segs)">
                <xsl:value-of select="util:segdesc(name($segments[1]))"/>
            </xsl:if>
        </xsl:variable>
        
        <xsl:call-template name="util:title">
            <xsl:with-param name="tabname" select="$tabname"/>
            <xsl:with-param name="multiple-segs" select="$multiple-segs"/>
            <xsl:with-param name="output" select="$output"/>
            <xsl:with-param name="segments" select="$segments"/>
        </xsl:call-template>	
    </xsl:template>	
    
</xsl:stylesheet>
