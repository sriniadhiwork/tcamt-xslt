<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="_format.new.xsl"/>
    <!-- param: output   values: plain-html    default: ng-tab-html -->
    <!--Generates html output to test results-->
    <!--<xsl:param name="output" select="'ng-tab-html'"/>-->
    <xsl:param name="output" select="'plain-html'"/>
    
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
</xsl:stylesheet>
