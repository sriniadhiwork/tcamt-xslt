<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:util="http://www.nist.gov/er7" exclude-result-prefixes="xsl xs util fn xhtml">
	<xsl:variable name="version">
		<xsl:text>	 
			Version 1.0: Code transfer to sriniadhi.work@gmail.com - restructuring with imports and comments; no change of functionality.
						1.1: Updates changing the Parent/Child order and other updates from the latest template.
						1.2: added nte after orc, fixed "Parent Information" in the title not being included in the Order contd
						1.3: Dropped the S-MA references, and added the media print formatting regarding line breaks.
						1.4: Fixed a bug in parent child.
						1.5: 	- added Race (PID-10) in Patient Information - Display Verification 
								- removed Results Report Status header row  in Lab Results – Display Verification
								- removed “(Note 2)” for OBR-28 in Order Information - Incorporate Verification 
								- removed “Note 2” and associated verbiage at the end of the Order Information - Incorporate Verification
						1.6:	- fixed C&amp;S and Hepatatatis parent-child incorporsate display
								- removed references to $generate-plain-html
						2.0: 	- change to the Parent/Child templates
								- added TQ1-9.2 to Order Information - Display Verification
								- added TQ1-9.1, .2, .3, and .9 elements to the Timing/Quantity Information - Incorporate 
								- added ED Data Type for OBX-2 in the Incorporate Verification

		</xsl:text>
	</xsl:variable>
	<xsl:output method="html" encoding="UTF-8" indent="yes" use-character-maps="tags"/>
	<xsl:param name="segmentName"/>
	<xsl:param name="testCaseName" select="//MSH.10"/>
	<xsl:param name="output" select="'plain-html'"/>
	<!-- <xsl:param name="output" select="'ng-tab-html'"/>-->
	<xsl:character-map name="tags">
		<xsl:output-character character="&lt;" string="&lt;"/>
		<xsl:output-character character="&gt;" string="&gt;"/>
	</xsl:character-map>
	<xsl:variable name="ACK" select="'ACK'"/>
	<xsl:variable name="ORU_R01" select="'ORU_R01'"/>
	<xsl:include href="_css_jurorDoc_LRIv2.xsl"/>
	<xsl:include href="_util_jurorDoc_LRIv2.xsl"/>
	<xsl:include href="_alltemplates_jurorDoc_LRIv2.xsl"/>
	<xsl:template name="buildJurorDoc">
		<xsl:param name="messageID" select="$testCaseName"/>
		<!--- message type is either ORU_R01 or ACK, based on the root tag -->
		<xsl:variable name="message-type">
			<xsl:choose>
				<xsl:when test="starts-with(name(.), 'ORU_R01')">
					<xsl:value-of select="$ORU_R01"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'ACK')">
					<xsl:value-of select="$ACK"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="messageHeader">
			<xsl:with-param name="er7MsgId">
				<xsl:value-of select="$testCaseName"/>
			</xsl:with-param>
		</xsl:call-template>
		<br/>
		<!--
			ORU_R01 template
		-->
		<xsl:if test="$message-type = $ORU_R01">
			<fieldset>
				<p>This Test Case-specific Juror Document provides a checklist for the Tester to use
                    during testing for assessing the Health IT Module&apos;s ability to display and
                    incorporate required data elements from the information received in the LRI
                    message. Additional data from the message or from the Health IT Module are
                    permitted to be displayed and incorporated by the Module. Grayed-out fields in
                    the Juror Document indicate where no data for that data element were included in
                    the LRI message for the given Test Case. </p>
				<p>The format of the Display Verification section of this Juror Document is for
                    ease-of-use by the Tester and does not indicate how the Health IT Module display
                    must be designed. </p>
			</fieldset>
			<h2>Display Verification</h2>
			<fieldset>
				<h4 align="left">Legend for Display Requirement</h4>
				<p>Data in <font color="red">
						<b>bold red</b>
					</font> text: HIT Module must display
                    exact version of stored data</p>
				<p>Data in <b>
						<i>bold black italics</i>
					</b> text: HIT Module must display exact
                    version of data received in the LRI message</p>
				<p>Data in regular text: HIT Module may display equivalent version of stored
                    data</p>
			</fieldset>
			<br/>
			<!-- Patient Information – Display Verification -->
			<xsl:call-template name="patientInfo-DV">
				<xsl:with-param name="pidSegments" select="//PID"/>
			</xsl:call-template>
			<br/>
			<!--Lab Results – Display Verification -->
			<!-- TODO : different for C and S and maybe hepatitis -->
			<xsl:choose>
				<xsl:when test="util:isParentChild_CS_TestCase($messageID) = fn:true()">
				<xsl:variable name="parentOrder" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]"/>
				<xsl:variable name="childOrder1" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[2]"/>
				<xsl:variable name="childOrder2" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[3]"/>

					<!-- PARENT OBX 1 -->
					<xsl:call-template name="labResults-DV">
							<xsl:with-param name="order" select="$parentOrder/OBR"/>
							<xsl:with-param name="orderNotes" select="$parentOrder/NTE"/>
							<xsl:with-param name="results" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]"/>
							<xsl:with-param name="specimen" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN[1]/SPM"/>
						</xsl:call-template>
					<!-- PARENT OBX 2 -->
						<xsl:call-template name="labResults-DV">
							<xsl:with-param name="order" select="$parentOrder/OBR"/>
							<xsl:with-param name="orderNotes" select="$parentOrder/NTE"/>
							<xsl:with-param name="results" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[2]"/>
							<xsl:with-param name="specimen" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN[1]/SPM"/>
							<xsl:with-param name="childOrder" select="$childOrder1/OBR"/>
							<xsl:with-param name="childResults" select="$childOrder1/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION"/>
						</xsl:call-template>
					<!-- PARENT OBX 3 -->
						<xsl:call-template name="labResults-DV">
							<xsl:with-param name="order" select="$parentOrder/OBR"/>
							<xsl:with-param name="orderNotes" select="$parentOrder/NTE"/>
							<xsl:with-param name="results" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[3]"/>
							<xsl:with-param name="specimen" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN[1]/SPM"/>
							<xsl:with-param name="childOrder" select="$childOrder2"/>
							<xsl:with-param name="childResults" select="$childOrder2/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION"/>
						</xsl:call-template>

				</xsl:when>
				<xsl:when test="util:isParentChild_Hepatitis_TestCase($messageID) = fn:true()">
					<xsl:for-each select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION">
						<xsl:call-template name="labResults-DV">
							<xsl:with-param name="order" select="OBR"/>
							<xsl:with-param name="orderNotes" select="NTE"/>
							<xsl:with-param name="results" select="ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION"/>
							<xsl:with-param name="specimen" select="(ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN/SPM)[1]"/>
						</xsl:call-template>
					</xsl:for-each>
				
			</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION">
						<xsl:call-template name="labResults-DV">
							<xsl:with-param name="order" select="OBR"/>
							<xsl:with-param name="orderNotes" select="NTE"/>
							<xsl:with-param name="results" select="ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION"/>
							<xsl:with-param name="specimen" select="(ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN/SPM)[1]"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
			<br/>
			<!--Performing Organization Information – Display Verification-->
			<xsl:call-template name="performingOrganizationNameAdd-DV">
				<xsl:with-param name="obxSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]/OBX[1]"/>
			</xsl:call-template>
			<br/>
			<!--Performing Organization Medical Director Information – Display Verification-->
			<xsl:call-template name="performingOrganizationMedDr-DV">
				<xsl:with-param name="obxSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]/OBX[1]"/>
			</xsl:call-template>
			<br/>
			<!--Specimen Information – Display Verification-->
			<xsl:call-template name="specimenInfo-DV">
				<xsl:with-param name="spmSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN[1]/SPM"/>
			</xsl:call-template>
			<br/>
			<!--Order Information – Display Verification-->
			<xsl:call-template name="orderInformation-DV">
				<xsl:with-param name="orcSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/ORC[1]"/>
			</xsl:call-template>
			<br/>
			<!-- <xsl:call-template name="notes-DV">
                        <xsl:with-param name="nteSegment" select="//NTE"/>
                    </xsl:call-template>
                    <br/>

                    <xsl:call-template name="time-DV">
                        <xsl:with-param name="timeSegment" select="//TQ1"/>
                    </xsl:call-template>  -->
			<h2>Incorporate Verification</h2>
			<fieldset>
				<h4 align="left">Legend for Store Requirement</h4>
				<p> S-EX : Store exact</p>
				<p> S-TR-R : Translate and store translation (exact value can be re-created from
                    translation any time)</p>
				<p> S-EX-A : Store exact by association</p>
				<p> S-RC : Process and re-create</p>
				<p> S-EQ : Store equivalent</p>
				<!--p> S-MA : Made available for specific processing</p-->
				<p>(See <b> &quot;Instructions to Testers for Verification of Store
                        Requirements&quot;</b> at the end of this Juror Document for additional
                    details.)</p>
			</fieldset>
			<br/>
			<!--Patient Information Details – Incorporate Verification -->
			<xsl:call-template name="patientInfo-IV">
				<xsl:with-param name="pidSegment" select="//PID"/>
			</xsl:call-template>
			<br/>
			<!--Order Information – Incorporate Verification -->
			<xsl:call-template name="orderInfo-IV">
				<xsl:with-param name="orcSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/ORC[1]"/>
			</xsl:call-template>
			<!--Note - Incorporate Verification-->
			<xsl:call-template name="note-IV">
				<xsl:with-param name="nteSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/ORC[1]/following-sibling::NTE"/>
			</xsl:call-template>
			<br/>
			<!--Performing Organization Information - Incorporate Verification-->
			<xsl:call-template name="performingOrderInfo-IV">
				<xsl:with-param name="obxSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]/OBX[1]"/>
			</xsl:call-template>
			<br/>
			<xsl:choose>
				<!-- Culture and Susceptibility Parent/Child -->
				<xsl:when test="util:isParentChild_CS_TestCase($messageID) = fn:true()">
					<!-- Parent ORDER -->
					<xsl:variable name="parentOrder" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]"/>
					<!-- Child ORDER 1 -->
					<xsl:variable name="childOrder1" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[2]"/>
					<!-- Child ORDER 2 -->
					<xsl:variable name="childOrder2" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[3]"/>
					<!-- Order Information (cont’d) Parent Information - Incorporate Verification -->
					<xsl:call-template name="orderInfocontd-IV">
						<xsl:with-param name="messageID" select="$messageID"/>
						<xsl:with-param name="obrSegment" select="$parentOrder/OBR"/>
					</xsl:call-template>
					<h4 align="center">PARENT - <xsl:value-of select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]/OBX/OBX.1"/>
					</h4>
					<!-- Result Information - Incorporate Verification PARENT-1 -->
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]"/>
					</xsl:call-template>
					<h4 align="center">PARENT - <xsl:value-of select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[2]/OBX/OBX.1"/>
					</h4>
					<!-- Result Information - Incorporate Verification PARENT-2 -->
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[2]"/>
					</xsl:call-template>
					<!-- Order Information (cont’d) Child Information - Incorporate Verification -->
					<xsl:call-template name="orderInfocontd_child-IV">
						<xsl:with-param name="obrSegment" select="$childOrder1/OBR"/>
						<xsl:with-param name="messageID" select="$messageID"/>
					</xsl:call-template>
					<!-- Result Information - Incorporate Verification CHILD-1 -->
					<h4 align="center">CHILD - <xsl:value-of select="$childOrder1/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]/OBX/OBX.1"/>
					</h4>
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$childOrder1/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]"/>
					</xsl:call-template>
					<!-- Result Information - Incorporate Verification CHILD-2 -->
					<h4 align="center">CHILD - <xsl:value-of select="$childOrder1/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[2]/OBX/OBX.1"/>
					</h4>
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$childOrder1/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[2]"/>
					</xsl:call-template>
					<!-- Result Information - Incorporate Verification CHILD-3 -->
					<h4 align="center">CHILD - <xsl:value-of select="$childOrder1/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[3]/OBX/OBX.1"/>
					</h4>
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$childOrder1/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[3]"/>
					</xsl:call-template>
					<h4 align="center">PARENT - <xsl:value-of select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[3]/OBX/OBX.1"/>
					</h4>
					<!-- Result Information - Incorporate Verification PARENT-3 -->
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[3]"/>
					</xsl:call-template>
					<!-- Order Information (cont’d) Child Information - Incorporate Verification -->
					<xsl:call-template name="orderInfocontd_child-IV">
						<xsl:with-param name="obrSegment" select="$childOrder2/OBR"/>
						<xsl:with-param name="messageID" select="$messageID"/>
					</xsl:call-template>
					<!-- Result Information - Incorporate Verification CHILD-1 -->
					<h4 align="center">CHILD - <xsl:value-of select="$childOrder2/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]/OBX/OBX.1"/>
					</h4>
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$childOrder2/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[1]"/>
					</xsl:call-template>
				</xsl:when>
				<!-- Hepatitis Parent/Child -->
				<xsl:when test="util:isParentChild_Hepatitis_TestCase($messageID) = fn:true()">
					<!-- Parent ORDER -->
					<xsl:variable name="parentOrder" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]"/>
					<!-- Child ORDER 1 -->
					<xsl:variable name="childOrder" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[2]"/>
					<!-- Order Information (cont’d) Parent Information - Incorporate Verification -->
					<xsl:call-template name="orderInfocontd-IV">
						<xsl:with-param name="messageID" select="$messageID"/>
						<xsl:with-param name="obrSegment" select="$parentOrder/OBR"/>
					</xsl:call-template>
					<!-- Result Information - Incorporate Verification -->
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[not(fn:position() = 9)]"/>
					</xsl:call-template>
					<h4 align="center">PARENT INFORMATION</h4>
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$parentOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION[9]"/>
					</xsl:call-template>
					<!-- CHILD INFORMATION-->
					<h4 align="center">CHILD INFORMATION</h4>
					<!-- Order Information (cont’d) Child Information - Incorporate Verification -->
					<xsl:call-template name="orderInfocontd_child-IV">
						<xsl:with-param name="obrSegment" select="$childOrder/OBR"/>
						<xsl:with-param name="messageID" select="$messageID"/>
					</xsl:call-template>
					<!-- Result Information - Incorporate Verification -->
					<xsl:call-template name="resultInfo-Generic-IV">
						<xsl:with-param name="observationGroups" select="$childOrder/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION"/>
					</xsl:call-template>
				</xsl:when>
				<!-- Generic -->
				<xsl:otherwise>
					<xsl:for-each select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION">
						<!--Generic : Order Information (cont’d) - Incorporate Verification-->
						<xsl:call-template name="orderInfocontd-IV">
							<xsl:with-param name="messageID" select="$messageID"/>
							<xsl:with-param name="obrSegment" select="OBR[1]"/>
						</xsl:call-template>
						<br/>
						<!--Generic : Result Information - Incorporate Verification-->
						<xsl:call-template name="resultInfo-Generic-IV">
							<xsl:with-param name="observationGroups" select="ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION"/>
						</xsl:call-template>
						<br/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
			<!--Specimen Information - Incorporate Verification-->
			<xsl:call-template name="specimentInfo-IV">
				<xsl:with-param name="spmSegment" select="(//SPM)[1]"/>
			</xsl:call-template>
			<br/>
			<!-- Parent-Child test cases : Order Information (cont’d) Parent Information - Incorporate Verification-->
			<!--			<xsl:call-template name="orderInfocontd-IV">
				<xsl:with-param name="er7XMLMessage" select="$er7XMLMessage"/>
				<xsl:with-param name="messageID" select="$messageID"/>
				<xsl:with-param name="obrSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/OBR[1]"/>
			</xsl:call-template>
			<br/>-->
			<!-- TODO switch based on test case and get rid of $groupedLabResults -->
			<!--			<xsl:for-each select="$groupedLabResults/lab-results/observations">
				<br/>
				<br/>
				-->
			<!--Result Information - Incorporate Verification-->
			<!--
				<xsl:call-template name="resultInfo-IV">
					<xsl:with-param name="er7XMLMessage" select="$er7XMLMessage"/>
					<xsl:with-param name="messageID" select="$messageID"/>
					<xsl:with-param name="obxSegment" select="ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION | ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION | 
                        OBR"/>
				</xsl:call-template>
			</xsl:for-each>
			<br/>-->
			<!--Specimen Information - Incorporate Verification-->
			<!--		<xsl:call-template name="specimentInfo-IV">
				<xsl:with-param name="spmSegment" select="//ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION[1]/ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN[1]/SPM"/>
			</xsl:call-template>
			<br/>-->
			<!--  <xsl:call-template name="note-IV">
                            <xsl:with-param name="nteSegment" select="//NTE"/>
                        </xsl:call-template>
                        <br/>-->
			<!--Timing/Quantity Information - Incorporate Verification-->
			<xsl:call-template name="time-IV">
				<xsl:with-param name="timeSegment" select="//TQ1[1]"/>
			</xsl:call-template>
			<br/>
			<xsl:call-template name="instructions"/>
		</xsl:if>
		<!--
				ACK template
		-->
		<xsl:if test="$message-type = $ACK">
			<fieldset>
				<p>This Test Case-specific Juror Document provides a checklist for the Tester to use
                    during certification testing for assessing the health information
                    technology&apos;s ability to receive and process an Acknowledgement message
                    related to laboratory result messaging in which NO Error is returned in the ACK
                    message. </p>
				<p>The exact wording and format of the display in the health information technology
                    (HIT) is not in-scope for this test.</p>
			</fieldset>
			<br/>
			<fieldset>
				<table>
					<thead>
						<tr>
							<th>Process an Acknowledgement</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<p>The receiving HIT system being tested shall process the ACK
                                    message correctly; a positive notification indicating that the
                                    ACK message was processed correctly <u>need not be made
                                        visible</u> in the system.</p>
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
