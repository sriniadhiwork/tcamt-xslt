<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:util="http://www.nist.gov/er7" exclude-result-prefixes="xsl xs util fn xhtml">
	<xsl:function name="util:parseText">
		<xsl:param name="content"/>
		<xsl:choose>
			<xsl:when test="contains($content, '\.br\')">
				<!--  <xsl:variable name="text" select="substring-before($content,'\.br\')"/>
                <xsl:variable name="text2" select="substring-after($content,'\.br\')"/>
                <xsl:copy-of select="concat($text,'&lt;/br&gt;',$text2)"></xsl:copy-of> -->
				<xsl:variable name="text" select="replace($content, '\\.br\\', '&lt;br/>')"/>
				<xsl:copy-of select="$text"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$content"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:parseDate">
		<xsl:param name="elementDataIn"/>
		<xsl:variable name="elementData" select="concat($elementDataIn, '                ')"/>
		<xsl:if test="string-length(normalize-space($elementData)) > 0">
			<xsl:variable name="year" select="substring($elementData, 1, 4)"/>
			<xsl:variable name="month" select="concat(substring($elementData, 5, 2), '/')"/>
			<xsl:variable name="day" select="concat(substring($elementData, 7, 2), '/')"/>
			<xsl:value-of select="concat($month, $day, $year)"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:dateTime">
		<xsl:param name="dateS"/>
		<xsl:variable name="dateformat" select="
                xs:dateTime(concat(
                substring($dateS, 1, 4), '-',
                substring($dateS, 5, 2), '-',
                substring($dateS, 7, 2), 'T',
                substring($dateS, 9, 2), ':',
                substring($dateS, 11, 2), ':',
                substring($dateS, 13, 2)
                ))"/>
		<xsl:value-of select="format-dateTime($dateformat, '[M01]/[D01]/[Y0001] at [H01]:[m01]:[s01]')"/>
	</xsl:function>
	<xsl:function name="util:formatDateTime">
		<xsl:param name="elementDataIn"/>
		<xsl:variable name="elementData" select="concat($elementDataIn, '                ')"/>
		<xsl:if test="string-length(normalize-space($elementData)) > 0">
			<xsl:variable name="year" select="substring($elementData, 1, 4)"/>
			<xsl:variable name="month" select="concat(substring($elementData, 5, 2), '/')"/>
			<xsl:variable name="day" select="concat(substring($elementData, 7, 2), '/')"/>
			<xsl:variable name="hours" select="concat(' ', substring($elementData, 9, 2))"/>
			<xsl:variable name="minutes" select="concat(':', substring($elementData, 11, 2))"/>
			<xsl:variable name="seconds" select="concat(':', substring($elementData, 13, 2))"/>
			<xsl:value-of select="concat($month, $day, $year, $hours, $minutes, $seconds)"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:formatData">
		<xsl:param name="content"/>
		<xsl:param name="class"/>
		<xsl:variable name="formattedData">
			<xsl:choose>
				<xsl:when test="string-length(normalize-space($content)) = 0">
					<td class="noData"/>
				</xsl:when>
				<xsl:otherwise>
					<td class="{$class}">
						<xsl:value-of select="$content"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:copy-of select="$formattedData"/>
	</xsl:function>
	<xsl:function name="util:formatDataLab">
		<xsl:param name="content"/>
		<xsl:param name="class"/>
		<xsl:param name="rowspan"/>
		<xsl:variable name="formattedData">
			<xsl:choose>
				<xsl:when test="string-length(normalize-space($content)) = 0">
					<td class="noData" rowspan="{$rowspan}"/>
				</xsl:when>
				<xsl:otherwise>
					<td class="{$class}" rowspan="{$rowspan}">
						<xsl:value-of select="$content"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:copy-of select="$formattedData"/>
	</xsl:function>
	<xsl:function name="util:displayCond">
		<xsl:param name="seg9"/>
		<xsl:param name="seg5"/>
		<xsl:param name="seg2"/>
		<xsl:choose>
			<xsl:when test="exists($seg9)">
				<xsl:copy-of select="util:formatData($seg9, 'bold')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="exists($seg5)">
						<xsl:copy-of select="util:formatData($seg5, 'boldItalic')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="util:formatData($seg2, 'boldItalic')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:ID-text-format">
		<xsl:param name="ID"/>
		<xsl:param name="text"/>
		<xsl:param name="storeReq"/>
		<xsl:param name="data"/>
		<xsl:param name="indent"/>
		<xsl:param name="font"/>
		<xsl:variable name="temp">
			<tr>
				<th style="text-indent: {$indent}; font-weight:{$font}">
					<xsl:value-of select="$ID"/>
				</th>
				<td>
					<xsl:value-of select="$text"/>
				</td>
				<td>
					<xsl:value-of select="$storeReq"/>
				</td>
				<xsl:choose>
					<xsl:when test="string-length(normalize-space($data)) = 0">
						<td class="noData"/>
					</xsl:when>
					<xsl:otherwise>
						<td>
							<xsl:value-of select="$data"/>
						</td>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="commentTemplate"/>
			</tr>
		</xsl:variable>
		<xsl:copy-of select="$temp"/>
	</xsl:function>
	<xsl:function name="util:tabs">
		<xsl:param name="tabName"/>
		<xsl:param name="displayVerification"/>
		<xsl:param name="displayDescription"/>
		<xsl:param name="incorporateVerification"/>
		<xsl:param name="incorporateDescription"/>
		<xsl:if test="exists($displayDescription)">
			<xsl:value-of select="util:start-tab($tabName)"/>
			<h3>
				<xsl:value-of select="$displayVerification"/>
			</h3>
			<xsl:copy-of select="$displayDescription"/>
			<xsl:if test="exists($incorporateDescription)">
				<h3>
					<xsl:value-of select="$incorporateVerification"/>
				</h3>
				<xsl:copy-of select="$incorporateDescription"/>
			</xsl:if>
			<xsl:value-of select="util:end-tab()"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:start">
		<xsl:param name="div"/>
		<!-- output version number and profile info at the start with the comment -->
		<xsl:value-of select="concat('&lt;div class=&quot;', $div, ' &quot;>')"/>
		<xsl:if test="$output = 'ng-tab-html'">
			<xsl:value-of select="'&lt;tabset>'"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:end">
		<xsl:if test="$output = 'ng-tab-html'">
			<xsl:value-of select="'&lt;/tabset>'"/>
		</xsl:if>
		<xsl:value-of select="'&lt;/div>'"/>
	</xsl:function>
	<xsl:function name="util:start-tab">
		<xsl:param name="tabName"/>
		<!-- output version number and profile info at the start with the comment -->
		<xsl:if test="$output = 'ng-tab-html'">
			<xsl:value-of select="concat('&lt;tab heading=&quot;', $tabName, '&quot;>')"/>
			<xsl:value-of select="'&lt;div class=&quot;panel-body&quot;>'"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:end-tab">
		<xsl:if test="$output = 'ng-tab-html'">
			<xsl:value-of select="'&lt;/div>'"/>
			<xsl:value-of select="'&lt;/tab>'"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:isParentChild_CS_TestCase">
		<xsl:param name="messageID"/>
		<xsl:choose>
			<xsl:when test="($messageID = 'LRI_4.1_2.1-GU_FRU') or ($messageID = 'LRI_4.1_3.1-GU_FRU') or ($messageID = 'LRI_4.1_4.1-GU_FRU') or ($messageID = 'LRI_4.1_2.1-NG_FRU') or ($messageID = 'LRI_4.1_3.1-NG_FRU') or ($messageID = 'LRI_4.1_4.1-NG_FRU')
                                        or ($messageID = 'LRI_4.2_2.1-GU_FRN') or ($messageID = 'LRI_4.2_3.1-GU_FRN') or ($messageID = 'LRI_4.2_4.1-GU_FRN') or ($messageID = 'LRI_4.2_2.1-NG_FRN') or ($messageID = 'LRI_4.2_3.1-NG_FRN') or ($messageID = 'LRI_4.2_4.1-NG_FRN')">
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:isParentChild_Hepatitis_TestCase">
		<xsl:param name="messageID"/>
		<xsl:choose>
			<xsl:when test="($messageID = 'LRI_5.0_2.1-GU_FRU') or ($messageID = 'LRI_5.1_2.1-GU_FRN') or ($messageID = 'LRI_5.0_2.1-NG_FRU') or ($messageID = 'LRI_5.1_2.1-NG_FRN')">
				<xsl:value-of select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="false()"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
</xsl:stylesheet>
