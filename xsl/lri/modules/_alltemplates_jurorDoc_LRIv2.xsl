<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:util="http://www.nist.gov/er7" exclude-result-prefixes="xsl xs util fn xhtml">
	<xsl:template match="*">
		<xsl:choose>
			<xsl:when test="$output = 'plain-html'">
				<xsl:call-template name="plain-html"/>
			</xsl:when>
			<xsl:when test="$output = 'ng-tab-html'">
				<xsl:call-template name="ng-tab-html"/>
			</xsl:when>
		</xsl:choose>
		
		
					<!-- <xsl:result-document href="groupedLabResults.xml">
							<groupedLabResults>
					<xsl:copy-of select="$groupedLabResults"/>
					</groupedLabResults>
					</xsl:result-document>				-->
					
	</xsl:template>
	<xsl:template name="plain-html">
		<html>
			<head>
				<xsl:call-template name="jurorAppearance"/>
			</head>
			<body>
				<xsl:call-template name="main"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="ng-tab-html">
		<xsl:call-template name="jurorAppearance"/>
		<xsl:call-template name="main"/>
	</xsl:template>
	<xsl:template name="main">
		<xsl:copy-of select="util:start('jurorContainer')"/>
		<xsl:variable name="full">
			<xsl:call-template name="buildJurorDoc">
<!--				<xsl:with-param name="er7XMLMessage" select="/"/>
--><!--				<xsl:with-param name="groupedLabResults" select="$groupedLabResults"/>
-->			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$output = 'ng-tab-html'">
			<xsl:copy-of select="util:tabs('FULL', '', $full, '', '')"/>
			<xsl:copy-of select="util:tabs('Patient Information', 'Display Verification', $full/fieldset[@id = 'PatientInfo-DV'], 'Incorporate Verification', $full/fieldset[@id = 'PatientInfo-IV'])"/>
			<xsl:copy-of select="util:tabs('Lab Results', 'Display Verification', $full/fieldset[@id = 'LabResults-DV'], 'Incorporate Verification', $full/fieldset[@id = 'ResultInfo-IV'])"/>
			<xsl:copy-of select="util:tabs('Performing Organization Information', 'Display Verification', $full/fieldset[@id = 'PerformingOrg-DV'], 'Incorporate Verification', $full/fieldset[@id = 'PerformingOrderInfo-IV'])"/>
			<xsl:copy-of select="util:tabs('Performing Organization Medical Director Information', 'Display Verification', $full/fieldset[@id = 'PerformingOrgMedDr-DV'], '', '')"/>
			<xsl:copy-of select="util:tabs('Specimen Information', 'Display Verification', $full/fieldset[@id = 'SpecimenInfo-DV'], 'Incorporate Verification', $full/fieldset[@id = 'SpecimenInfo-IV'])"/>
			<xsl:copy-of select="util:tabs('Order Information', 'Display Verification', $full/fieldset[@id = 'OrderInfo-DV'], 'Incorporate Verification', $full/fieldset[@id = 'OrderInfo-IV'])"/>
		</xsl:if>
		<xsl:if test="$output = 'plain-html'">
			<xsl:copy-of select="$full"/>
		</xsl:if>
		<xsl:copy-of select="util:end()"/>
	</xsl:template>
	<!--- plain textarea -->
	<xsl:template name="commentTemplate">
		<td bgcolor="#F2F2F2">
			<!--    <div contentEditable="true"
                style="width: 100%; height: 100%; border: none; resize: none; max-width: 300px">
                <xsl:text disable-output-escaping="yes">&amp;</xsl:text>nbsp;</div> -->
			<textarea maxLength="100" style="width: 100%; height: 100%; border: 1px; background: 1px  #F2F2F2; resize:vertical; overflow-y:hidden " rows="1"> </textarea>
		</td>
	</xsl:template>
	<!-- header table with placeholder -->
	<xsl:template name="messageHeader">
		<xsl:param name="er7MsgId"/>
		<div style="display:none">
			<xsl:value-of select="$version"/>
		</div>
		<fieldset>
			<table id="headerTable">
				<thead>
					<tr>
						<th colspan="2">HL7 v2.5 ORU^R01^ORU_R01 Message: Incorporation of
                            Laboratory Results</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>Test Case ID</th>
						<td>
							<xsl:value-of select="$er7MsgId"/>
						</td>
					</tr>
					<tr>
						<th>Juror ID</th>
						<td>
							<input style="background: 1px  #E2E2E2;" type="text" maxlength="50" value=""/>
						</td>
					</tr>
					<tr>
						<th>Juror Name</th>
						<td>
							<input style="background: 1px  #E2E2E2;" type="text" maxlength="50" value=""/>
						</td>
					</tr>
					<tr>
						<th>HIT System Tested</th>
						<td>
							<input style="background: 1px  #E2E2E2;" type="text" maxlength="50" value=""/>
						</td>
					</tr>
					<tr>
						<th>Inspection Date/Time</th>
						<td>
							<input style="background: 1px  #E2E2E2;" type="text" maxlength="50" value=""/>
						</td>
					</tr>
					<tr>
						<th>Inspection Settlement (Pass/Fail)</th>
						<td>
							<table id="inspectionStatus">
								<thead>
									<tr>
										<th>Pass</th>
										<th>Fail</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input type="checkbox" value=""/>
										</td>
										<td>
											<input type="checkbox" value=""/>
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<th>Reason Failed</th>
						<td>
							<input style="background: 1px  #E2E2E2;" type="text" maxlength="50" value=""/>
						</td>
					</tr>
					<tr>
						<th>Juror Comments</th>
						<td>
							<input style="background: 1px  #E2E2E2;" type="text" maxlength="50" value=""/>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>
	</xsl:template>
	<xsl:template name="patientInfo-DV">
		<xsl:param name="pidSegments" as="node()*"/>
		<xsl:for-each select="$pidSegments">
			<fieldset id="PatientInfo-DV">
				<table id="patientInformationDisplay">
					<thead>
						<tr>
							<th colspan="6">Patient Information - Display Verification</th>
						</tr>
						<tr>
							<th>Patient Identifier</th>
							<th>Patient Name</th>
							<th>DOB</th>
							<th>Sex</th>
							<th>Race</th>
							<th>Tester Comment</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<xsl:copy-of select="util:formatData(PID.3/PID.3.1, 'boldItalic')"/>
							<xsl:copy-of select="util:formatData(concat(PID.5/PID.5.2, ' ', PID.5/PID.5.3, ' ', PID.5/PID.5.1/PID.5.1.1, ' ', PID.5/PID.5.4), 'boldItalic')"/>
							<xsl:copy-of select="util:formatData(util:parseDate(PID.7/PID.7.1), 'normal')"/>
							<xsl:copy-of select="util:formatData(PID.8, 'normal')"/>
							<xsl:variable name="race">
								<xsl:for-each select="PID.10">
									<xsl:value-of select="./PID.10.2"/>
									<xsl:if test="not(position() = last())">
										<xsl:value-of select="'; '"/>
									</xsl:if>
								</xsl:for-each>
							</xsl:variable>
							<xsl:copy-of select="util:formatData($race, 'bold')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<td colspan="5">When a given patient has more than one Patient ID
                                Number, the HIT module may display the ID Number that is most
                                appropriate for the context (e.g., inpatient ID Number versus
                                ambulatory ID Number.) </td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="labResults-DV">
		<xsl:param name="order" as="node()"/>
		<xsl:param name="orderNotes" as="node()*"/>
		<xsl:param name="results" as="node()+"/>
		<xsl:param name="specimen" as="node()?"/>
		<xsl:param name="childOrder" as="node()?"/>
		<xsl:param name="childResults" as="node()*"/>
		
		<!-- <xsl:param name="messageID"/> -->
		<fieldset id="LabResults-DV">
				<table id="labResultsDisplay">
					<thead>
						<tr>
							<th colspan="10">Lab Results - Display Verification</th>
						</tr>
						<tr>
							<th width="15%">Test Performed:</th>
							<xsl:choose>
								<xsl:when test="exists($order/OBR.4/OBR.4.9)">
									<td colspan="9" width="75%" style="font-weight:bold; color:red">
										<xsl:value-of select="$order/OBR.4/OBR.4.9"/>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="exists($order/OBR.4/OBR.4.5)">
											<td colspan="9" width="75%" style="font-style:italic;font-weight:bold;">
												<xsl:value-of select="$order/OBR.4/OBR.4.5"/>
											</td>
										</xsl:when>
										<xsl:otherwise>
											<td colspan="9" width="75%" style="font-style:italic;font-weight:bold;">
												<xsl:value-of select="$order/OBR.4/OBR.4.2"/>
											</td>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</tr>
						<tr>
							<th width="15%">Test Report Date:</th>
							<td colspan="9" width="75%" style="font-weight:normal;">
								<xsl:value-of select="util:formatDateTime($order/OBR.22/OBR.22.1)"/>
							</td>
						</tr>
						<tr>
							<th width="15%">Result Report Status</th>
							<td colspan="9" width="75%" style="font-weight:normal;">
								<xsl:value-of select="$order/OBR.25"/>
							</td>
						</tr>
						<xsl:for-each select="$orderNotes">
							<tr>
								<th width="15%">Note:</th>
								<td colspan="9" width="75%">
									<xsl:copy-of select="util:parseText(NTE.3)"/>
								</td>
							</tr>
						</xsl:for-each>
						<tr>
							<td colspan="10" class="addSpace"/>
						</tr>
						<tr>
							<th width="15%">Result Observation Name</th>
							<th width="5%">Result Value</th>
							<th width="5%">UOM</th>
							<th width="7%">Reference Range</th>
							<th width="7%">Abnormal Flag</th>
							<th width="6%">Status</th>
							<th width="10%">Date/Time of Observation</th>
							<th width="10%">End Date/Time of Observation</th>
							<th width="10%">Date/Time of Analysis</th>
							<th width="20%">Tester Comment</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$results/OBX">
							<xsl:variable name="OBX_5">
								<xsl:choose>
									<xsl:when test="OBX.2 = 'NM'">
										<xsl:copy-of select="util:formatData(OBX.5, 'boldItalic')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'SN'">
										<xsl:choose>
											<xsl:when test="exists(OBX.5)">
												<td>
													<xsl:copy-of select="concat(concat('&lt;font color=&quot;red&quot;>&lt;b>', OBX.5/OBX.5.1, '&lt;/b>&lt;/font>'), ' ', concat('&lt;font color=&quot;black&quot;>&lt;b>&lt;i>', OBX.5/OBX.5.2, '&lt;/i>&lt;/b>&lt;/font>'), ' ', concat('&lt;font color=&quot;red&quot;>&lt;b>', OBX.5/OBX.5.3, '&lt;/b>&lt;/font>'), ' ', concat('&lt;font color=&quot;black&quot;>&lt;b>&lt;i>', OBX.5/OBX.5.4, '&lt;/i>&lt;/b>&lt;/font>'))"/>
												</td>
											</xsl:when>
											<xsl:otherwise>
												<td class="noData"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:when test="OBX.2 = 'FT'">
										<xsl:copy-of select="util:formatData(OBX.5, 'bold')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'ST'">
										<xsl:copy-of select="util:formatData(OBX.5, 'bold')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'TX'">
										<xsl:copy-of select="util:formatData(OBX.5, 'bold')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'DT'">
										<xsl:copy-of select="util:formatData(OBX.5, 'normal')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'TS'">
										<xsl:copy-of select="util:formatData(OBX.5, 'normal')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'TM'">
										<xsl:copy-of select="util:formatData(OBX.5, 'normal')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'CWE'">
										<xsl:copy-of select="util:displayCond(OBX.5/OBX.5.9, OBX.5/OBX.5.5, OBX.5/OBX.5.2)"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'ED'">
										<td>PDF is created</td>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="util:formatData(OBX.5, 'normal')"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<tr>
								<xsl:copy-of select="util:displayCond(OBX.3/OBX.3.9, OBX.3/OBX.3.5, OBX.3/OBX.3.2)"/>
								<xsl:copy-of select="$OBX_5"/>
								<xsl:copy-of select="util:displayCond(OBX.6/OBX.6.9, OBX.6/OBX.6.5, OBX.6/OBX.6.2)"/>
								<xsl:copy-of select="util:formatData(OBX.7, 'bold')"/>
								<xsl:copy-of select="util:formatData(OBX.8, 'normal')"/>
								<xsl:copy-of select="util:formatData(OBX.11, 'normal')"/>
								<xsl:variable name="observationDateTime">
									<xsl:choose>
										<xsl:when test="OBX.14/OBX.14.1">
											<xsl:value-of select="OBX.14/OBX.14.1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:choose>
												<xsl:when test="$order/OBR.7/OBR.7.1">
													<xsl:value-of select="$order/OBR.7/OBR.7.1"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:if test="$specimen/SPM.17/SPM.17.1/SPM.17.1.1">
														<xsl:value-of select="$specimen/SPM.17/SPM.17.1/SPM.17.1.1"/>
													</xsl:if>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>								
								</xsl:variable>
								<xsl:copy-of select="util:formatData(util:formatDateTime($observationDateTime), 'normal')"/>
								<xsl:copy-of select="util:formatData(util:formatDateTime($order/OBR.8/OBR.8.1), 'normal')"/>
								<xsl:copy-of select="util:formatData(util:formatDateTime(OBX.19/OBX.19.1), 'normal')"/>
								<xsl:call-template name="commentTemplate"/>
							</tr>
							<xsl:for-each select="following-sibling::NTE">
								<tr>
									<td>Note</td>
									<td colspan="8">
										<xsl:value-of select="util:parseText(NTE.3)"/>
									</td>
									<xsl:call-template name="commentTemplate"/>
								</tr>
							</xsl:for-each>
						</xsl:for-each>
						
						<!-- TODO insert child results here -->


						<xsl:for-each select="$childResults/OBX">
															<xsl:variable name="OBX_5">
								<xsl:choose>
									<xsl:when test="OBX.2 = 'NM'">
										<xsl:copy-of select="util:formatData(OBX.5, 'boldItalic')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'SN'">
										<xsl:choose>
											<xsl:when test="exists(OBX.5)">
												<td>
													<xsl:copy-of select="concat(concat('&lt;font color=&quot;red&quot;>&lt;b>', OBX.5/OBX.5.1, '&lt;/b>&lt;/font>'), ' ', concat('&lt;font color=&quot;black&quot;>&lt;b>&lt;i>', OBX.5/OBX.5.2, '&lt;/i>&lt;/b>&lt;/font>'), ' ', concat('&lt;font color=&quot;red&quot;>&lt;b>', OBX.5/OBX.5.3, '&lt;/b>&lt;/font>'), ' ', concat('&lt;font color=&quot;black&quot;>&lt;b>&lt;i>', OBX.5/OBX.5.4, '&lt;/i>&lt;/b>&lt;/font>'))"/>
												</td>
											</xsl:when>
											<xsl:otherwise>
												<td class="noData"/>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:when test="OBX.2 = 'FT'">
										<xsl:copy-of select="util:formatData(OBX.5, 'bold')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'ST'">
										<xsl:copy-of select="util:formatData(OBX.5, 'bold')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'TX'">
										<xsl:copy-of select="util:formatData(OBX.5, 'bold')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'DT'">
										<xsl:copy-of select="util:formatData(OBX.5, 'normal')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'TS'">
										<xsl:copy-of select="util:formatData(OBX.5, 'normal')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'TM'">
										<xsl:copy-of select="util:formatData(OBX.5, 'normal')"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'CWE'">
										<xsl:copy-of select="util:displayCond(OBX.5/OBX.5.9, OBX.5/OBX.5.5, OBX.5/OBX.5.2)"/>
									</xsl:when>
									<xsl:when test="OBX.2 = 'ED'">
										<td>PDF is created</td>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="util:formatData(OBX.5, 'normal')"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
						<tr>
								<xsl:copy-of select="util:displayCond(OBX.3/OBX.3.9, OBX.3/OBX.3.5, OBX.3/OBX.3.2)"/>
								<xsl:copy-of select="$OBX_5"/>
								<xsl:copy-of select="util:displayCond(OBX.6/OBX.6.9, OBX.6/OBX.6.5, OBX.6/OBX.6.2)"/>
								<xsl:copy-of select="util:formatData(OBX.7, 'bold')"/>
								<xsl:copy-of select="util:formatData(OBX.8, 'normal')"/>
								<xsl:copy-of select="util:formatData(OBX.11, 'normal')"/>
								<xsl:copy-of select="util:formatData(util:formatDateTime($childOrder/OBR.7/OBR.7.1), 'normal')"/>
								<xsl:copy-of select="util:formatData(util:formatDateTime($childOrder/OBR.8/OBR.8.1), 'normal')"/>
								<xsl:copy-of select="util:formatData(util:formatDateTime(OBX.19/OBX.19.1), 'normal')"/>
								<xsl:call-template name="commentTemplate"/>
							</tr> 
						<!-- <xsl:for-each select="following-sibling::NTE">
							<tr>
									<td>Note</td>
									<td colspan="8">
										<xsl:value-of select="util:parseText(NTE.3)"/>
									</td>
									<xsl:call-template name="commentTemplate"/>
								</tr>
							</xsl:for-each> -->
						</xsl:for-each>
						
						<xsl:if test="OBX.2 = 'NM'">
							<tr>
								<td colspan="10">For all numeric Result values that are less than 1,
                                    the displayed data must include a pre-decimal &quot;0&quot; and
                                    the decimal point (e.g., &quot;.5&quot; must be displayed as
                                    &quot;0.5&quot;. The displayed data cannot change the level of
                                    precision of a numeric Result value (e.g., &quot;6&quot; cannot
                                    be displayed as &quot;6.0&quot;).</td>
							</tr>
						</xsl:if>
						<br/>
					</tbody>
				</table>
		</fieldset>
	</xsl:template>
	<xsl:template name="performingOrganizationNameAdd-DV">
		<xsl:param name="obxSegment"/>
		<fieldset id="PerformingOrg-DV">
			<table id="performingOrganizationNameAdd">
				<thead>
					<tr>
						<th colspan="3">Performing Organization Information - Display
                            Verification</th>
					</tr>
					<tr>
						<th width="30%">Data Element Name</th>
						<th width="30%">Data</th>
						<th width="40%">Tester Comment</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>Organization Name</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.23/OBX.23.1, 'bold')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th colspan="3">Organization Address</th>
					</tr>
					<tr>
						<th class="embSpace">Street address</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.24/OBX.24.1/OBX.24.1.1, 'boldItalic')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th class="embSpace">Other designation</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.24/OBX.24.2, 'boldItalic')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th class="embSpace">City</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.24/OBX.24.3, 'boldItalic')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th class="embSpace">State</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.24/OBX.24.4, 'boldItalic')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th class="embSpace">Zip code</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.24/OBX.24.5, 'boldItalic')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
				</tbody>
			</table>
		</fieldset>
	</xsl:template>
	<xsl:template name="performingOrganizationMedDr-DV">
		<xsl:param name="obxSegment"/>
		<fieldset id="PerformingOrgMedDr-DV">
			<table id="performingOrganizationMedDr">
				<thead>
					<tr>
						<th colspan="3">Performing Organization Medical Director Information -
                            Display Verification</th>
					</tr>
					<tr>
						<th width="30%">Data Element Name</th>
						<th width="30%">Data</th>
						<th width="40%">Tester Comment</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th colspan="3">Medical Director Name</th>
					</tr>
					<tr>
						<th colspan="3" class="embSpace">Family Name</th>
					</tr>
					<tr>
						<th class="embSpace">Surname</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.25/OBX.25.2/OBX.25.2.1, 'normal')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th class="embSpace">Given Name</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.25/OBX.25.3, 'normal')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th class="embSpace">Second and Further Given Names or Initials Thereof</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.25/OBX.25.4, 'normal')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th class="embSpace">Suffix (e.g., JR or III)</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.25/OBX.25.5, 'normal')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th class="embSpace">Prefix (e.g., DR)</th>
						<xsl:copy-of select="util:formatData($obxSegment/OBX.25/OBX.25.6, 'normal')"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
				</tbody>
			</table>
		</fieldset>
	</xsl:template>
	<xsl:template name="localCode">
		<xsl:param name="seg9"/>
		<xsl:param name="seg2"/>
		<xsl:param name="seg5"/>
		<xsl:param name="seg3"/>
		<xsl:param name="seg6"/>
		<xsl:param name="localCode"/>
		<xsl:choose>
			<xsl:when test="($seg9 != $seg2) or ($seg9 != $seg5)">
				<xsl:copy-of select="util:formatData($seg9, 'bold')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="($seg3 = $localCode)">
						<xsl:copy-of select="util:formatData($seg2, 'boldItalic')"/>
					</xsl:when>
					<xsl:when test="($seg6 = $localCode)">
						<xsl:copy-of select="util:formatData($seg5, 'boldItalic')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="util:formatData($seg2, 'boldItalic')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="specimenInfo-DV">
		<xsl:param name="spmSegment"/>
		<fieldset id="SpecimenInfo-DV">
			<xsl:for-each select="$spmSegment">
				<table id="specimenInformation">
					<thead>
						<tr>
							<th colspan="3">Specimen Information - Display Verification</th>
						</tr>
						<tr>
							<th width="30%">Data Element Name</th>
							<th width="30%">Data</th>
							<th width="40%">Tester Comment</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>Specimen Type(Specimen Source)</th>
							<!--   <xsl:call-template name="localCode">
                                <xsl:with-param name="seg9" select="$spmSegment/SPM.4/SPM.4.9"/>
                                <xsl:with-param name="seg2" select="$spmSegment/SPM.4/SPM.4.2"/>
                                <xsl:with-param name="seg5" select="$spmSegment/SPM.4/SPM.4.5"/>
                                <xsl:with-param name="seg3" select="$spmSegment/SPM.4/SPM.4.3"/>
                                <xsl:with-param name="seg6" select="$spmSegment/SPM.4/SPM.4.6"/>
                                <xsl:with-param name="localCode" select="'99USA'"/>
                            </xsl:call-template> -->
							<xsl:copy-of select="util:displayCond($spmSegment/SPM.4/SPM.4.9, $spmSegment/SPM.4/SPM.4.5, $spmSegment/SPM.4/SPM.4.2)"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th>Specimen Collection Date/Time - Start</th>
							<xsl:copy-of select="util:formatData(util:formatDateTime($spmSegment/SPM.17/SPM.17.1/SPM.17.1.1), 'normal')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th>Specimen Collection Date/Time - End</th>
							<xsl:copy-of select="util:formatData(util:formatDateTime($spmSegment/SPM.17/SPM.17.2/SPM.17.2.1), 'normal')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th>Specimen Reject Reason</th>
							<!--  <xsl:call-template name="localCode">
                                <xsl:with-param name="seg9" select="$spmSegment/SPM.21/SPM.21.9"/>
                                <xsl:with-param name="seg2" select="$spmSegment/SPM.21/SPM.21.2"/>
                                <xsl:with-param name="seg5" select="$spmSegment/SPM.21/SPM.21.5"/>
                                <xsl:with-param name="seg3" select="$spmSegment/SPM.21/SPM.21.3"/>
                                <xsl:with-param name="seg6" select="$spmSegment/SPM.21/SPM.21.6"/>
                                <xsl:with-param name="localCode" select="'99USA'"/>
                            </xsl:call-template> -->
							<xsl:copy-of select="util:displayCond($spmSegment/SPM.21/SPM.21.9, $spmSegment/SPM.21/SPM.21.5, $spmSegment/SPM.21/SPM.21.2)"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th>Specimen Condition</th>
							<!--  <xsl:call-template name="localCode">
                                <xsl:with-param name="seg9" select="$spmSegment/SPM.24/SPM.24.9"/>
                                <xsl:with-param name="seg2" select="$spmSegment/SPM.24/SPM.24.2"/>
                                <xsl:with-param name="seg5" select="$spmSegment/SPM.24/SPM.24.5"/>
                                <xsl:with-param name="seg3" select="$spmSegment/SPM.24/SPM.24.3"/>
                                <xsl:with-param name="seg6" select="$spmSegment/SPM.24/SPM.24.6"/>
                                <xsl:with-param name="localCode" select="'99USA'"/>
                            </xsl:call-template> -->
							<xsl:copy-of select="util:displayCond($spmSegment/SPM.24/SPM.24.9, $spmSegment/SPM.24/SPM.24.5, $spmSegment/SPM.24/SPM.24.2)"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
					</tbody>
				</table>
			</xsl:for-each>
		</fieldset>
	</xsl:template>
	<xsl:template name="orderInformation-DV">
		<xsl:param name="orcSegment"/> <!-- ORC Segment -->
		<fieldset id="OrderInfo-DV">
			<xsl:for-each select="$orcSegment/..">
				<table id="orderInformation">
					<thead>
						<tr>
							<th colspan="3">Order Information - Display Verification</th>
						</tr>
						<tr>
							<th width="30%">Data Element Name</th>
							<th width="30%">Data</th>
							<th width="40%">Tester Comment</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>Relevant Clinical Information</th>
							<xsl:choose>
								<xsl:when test="exists($orcSegment/following-sibling::OBR[1]/OBR.13/OBR.13.9)">
									<xsl:copy-of select="util:formatData($orcSegment/following-sibling::OBR[1]/OBR.13/OBR.13.9, 'bold')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="util:formatData($orcSegment/following-sibling::OBR[1]/OBR.13/OBR.13.2, 'boldItalic')"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th>Placer Order Number Entity ID</th>
							<xsl:copy-of select="util:formatData($orcSegment/ORC.2/ORC.2.1, 'bold')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th colspan="3">Ordering Provider</th>
						</tr>
						<tr>
							<th colspan="3" class="embSpace">Family Name</th>
						</tr>
						<tr>
							<th class="embSpace">Surname</th>
							<xsl:copy-of select="util:formatData($orcSegment/ORC.12/ORC.12.2/ORC.12.2.1, 'bold')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th class="embSpace">Given Name</th>
							<xsl:copy-of select="util:formatData($orcSegment/ORC.12/ORC.12.3, 'bold')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th class="embSpace">Second and Further Given Names or Initials
                                Thereof</th>
							<xsl:copy-of select="util:formatData($orcSegment/ORC.12/ORC.12.4, 'bold')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th class="embSpace">Suffix (e.g., JR or III)</th>
							<xsl:copy-of select="util:formatData($orcSegment/ORC.12/ORC.12.5, 'bold')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th class="embSpace">Prefix (e.g., DR)</th>
							<xsl:copy-of select="util:formatData($orcSegment/ORC.12/ORC.12.6, 'bold')"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<xsl:choose>
							<xsl:when test="$orcSegment/following-sibling::OBR[1]/OBR.49/OBR.49.1[. = 'CC']">
								<tr>
									<th colspan="3">Results Copies To</th>
								</tr>
								<xsl:for-each select="$orcSegment/following-sibling::OBR[1]/OBR.28">
									<tr>
										<th colspan="3" class="embSpace">Family Name</th>
									</tr>
									<tr>
										<th class="embSpace">Surname</th>
										<xsl:copy-of select="util:formatData(OBR.28.2/OBR.28.2.1, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
									<tr>
										<th class="embSpace">Given Name</th>
										<xsl:copy-of select="util:formatData(OBR.28.3, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
									<tr>
										<th class="embSpace">Second and Further Given Names or
                                            Initials Thereof</th>
										<xsl:copy-of select="util:formatData(OBR.28.4, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
									<tr>
										<th class="embSpace">Suffix (e.g., JR or III)</th>
										<xsl:copy-of select="util:formatData(OBR.28.5, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
									<tr>
										<th class="embSpace">Prefix (e.g., DR)</th>
										<xsl:copy-of select="util:formatData(OBR.28.6, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
								</xsl:for-each>
							</xsl:when>
							<xsl:when test="$orcSegment/following-sibling::OBR[1]/OBR.49/OBR.49.1[. = 'BCC']">
								<tr>
									<th colspan="3">Results Copies To</th>
								</tr>
								<xsl:for-each select="$orcSegment/following-sibling::OBR[1]/OBR.28">
									<tr>
										<th colspan="3" class="embSpace">Family Name</th>
									</tr>
									<tr>
										<th class="embSpace">Surname</th>
										<xsl:copy-of select="util:formatData(OBR.28.2/OBR.28.2.1, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
									<tr>
										<th class="embSpace">Given Name</th>
										<xsl:copy-of select="util:formatData(OBR.28.3, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
									<tr>
										<th class="embSpace">Second and Further Given Names or
                                            Initials Thereof</th>
										<xsl:copy-of select="util:formatData(OBR.28.4, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
									<tr>
										<th class="embSpace">Suffix (e.g., JR or III)</th>
										<xsl:copy-of select="util:formatData(OBR.28.5, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
									<tr>
										<th class="embSpace">Prefix (e.g., DR)</th>
										<xsl:copy-of select="util:formatData(OBR.28.6, 'normal')"/>
										<xsl:call-template name="commentTemplate"/>
									</tr>
								</xsl:for-each>
							</xsl:when>
						</xsl:choose>
						<xsl:if test="exists($orcSegment/following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.TIMING_QTY[1]/TQ1)">
							<tr>
								<th colspan="3">Timing/Quantity Information</th>
							</tr>
							<tr>
								<th class="embSpace">Start Date/Time</th>
								<xsl:copy-of select="util:formatData(util:formatDateTime($orcSegment/following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.TIMING_QTY[1]/TQ1/TQ1.7/TQ1.7.1), 'normal')"/>
								<xsl:call-template name="commentTemplate"/>
							</tr>
							<tr>
								<th class="embSpace">End Date/Time</th>
								<xsl:copy-of select="util:formatData(util:formatDateTime($orcSegment/following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.TIMING_QTY[1]/TQ1/TQ1.8/TQ1.8.1), 'normal')"/>
								<xsl:call-template name="commentTemplate"/>
							</tr>
							<tr>
								<th class="embSpace">Priority</th>
								<xsl:copy-of select="util:formatData($orcSegment/following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.TIMING_QTY[1]/TQ1/TQ1.9/TQ1.9.2, 'normal')"/>
								<xsl:call-template name="commentTemplate"/>
							</tr>

						</xsl:if>
					</tbody>
				</table>
			</xsl:for-each>
		</fieldset>
	</xsl:template>
	<!--   <xsl:template name="notes-DV">
        <xsl:param name="nteSegment"/>
        <xsl:if test="exists($nteSegment)">
            <fieldset>
                <table id="notes">
                    <thead>
                        <tr>
                            <th colspan="3">Note - Display Verification</th>
                        </tr>
                        <tr>
                            <th width="30%">Data Element Name</th>
                            <th width="30%">Data</th>
                            <th width="40%">Comment</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="$nteSegment">
                            <tr>
                                <th>Note/Comment</th>
                                <xsl:copy-of select="util:formatData(NTE.3, 'bold')"/>
                                <xsl:call-template name="commentTemplate"/>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </fieldset>
        </xsl:if>
    </xsl:template> -->
	<!-- <xsl:template name="time-DV">
        <xsl:param name="timeSegment"/>
        <xsl:if test="exists($timeSegment)">
            <fieldset>
                <table id="time">
                    <thead>
                        <tr>
                            <th colspan="3">Time/Quantity - Display Verification</th>
                        </tr>
                        <tr>
                            <th width="30%">Data Element Name</th>
                            <th width="30%">Data</th>
                            <th width="40%">Comment</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <tr>
                                <th class="embSpace">Start Date/Time</th>
                                <xsl:copy-of
                                    select="util:formatData(util:formatDateTime($timeSegment/TQ1.7/TQ1.7.1), 'normal')"/>
                                <xsl:call-template name="commentTemplate"/>
                            </tr>
                            <tr>
                                <th class="embSpace">End Date/Time</th>
                                <xsl:copy-of
                                    select="util:formatData(util:formatDateTime($timeSegment/TQ1.8/TQ1.8.1), 'normal')"/>
                                <xsl:call-template name="commentTemplate"/>
                            </tr>
                        </tr>
                    </tbody>
                </table>
            </fieldset>
        </xsl:if>
    </xsl:template>  -->
	<xsl:template name="headerforIV">
		<xsl:param name="title"/>
		<thead>
			<tr>
				<th colspan="5">
					<xsl:value-of select="$title"/>
				</th>
			</tr>
			<tr>
				<th width="15%">Location</th>
				<th width="20%">Data Element Name</th>
				<th width="5%">Store Requirement</th>
				<th width="20%">Data</th>
				<th width="40%">Tester Comment</th>
			</tr>
		</thead>
	</xsl:template>
	<xsl:template name="patientInfo-IV">
		<xsl:param name="pidSegment"/>
		<fieldset id="PatientInfo-IV">
			<table id="identifierInformation">
				<xsl:call-template name="headerforIV">
					<xsl:with-param name="title">Patient Information Details- Incorporate Verification</xsl:with-param>
				</xsl:call-template>
				<tbody>
					<tr>
						<th>PID-3</th>
						<th>Patient Identifier List</th>
						<th/>
						<th/>
						<th/>
					</tr>
					<xsl:copy-of select="util:ID-text-format('PID-3.1', 'ID Number', 'S-EX-A', $pidSegment/PID.3/PID.3.1, '20px', 'normal')"/>
					<tr>
						<th style="text-indent:20px">PID-3.4</th>
						<th>Assigning Property</th>
						<th/>
						<th/>
						<th/>
					</tr>
					<xsl:copy-of select="util:ID-text-format('PID-3.4.1', 'Namespace ID', 'S-EX-A', $pidSegment/PID.3/PID.3.4/PID.3.4.1, '30px', 'normal')"/>
					<xsl:copy-of select="util:ID-text-format('PID-3.4.2', 'Universal ID', 'S-EX-A', $pidSegment/PID.3/PID.3.4/PID.3.4.2, '30px', 'normal')"/>
					<xsl:copy-of select="util:ID-text-format('PID-3.4.3', 'Universal ID Type', 'S-EX-A', $pidSegment/PID.3/PID.3.4/PID.3.4.3, '30px', 'normal')"/>
					<xsl:copy-of select="util:ID-text-format('PID-3.5', 'Identifier Type Code', 'S-RC', $pidSegment/PID.3/PID.3.5, '20px', 'normal')"/>
					<tr>
						<th>PID-5</th>
						<th>Patient Name</th>
						<th/>
						<th/>
						<th/>
					</tr>
					<tr>
						<th style="text-indent:20px">PID-5.1</th>
						<th>Family Name</th>
						<th/>
						<th/>
						<th/>
					</tr>
					<xsl:copy-of select="util:ID-text-format('PID-5.1.1', 'Surname', 'S-EX-A', $pidSegment/PID.5/PID.5.1/PID.5.1.1, '30px', 'normal')"/>
					<xsl:copy-of select="util:ID-text-format('PID-5.2', 'Given Name', 'S-EX-A', $pidSegment/PID.5/PID.5.2, '20px', 'normal')"/>
					<xsl:copy-of select="util:ID-text-format('PID-5.3', 'Second and Further Given Names or Initials Thereof', 'S-EX-A', $pidSegment/PID.5/PID.5.3, '20px', 'normal')"/>
					<xsl:copy-of select="util:ID-text-format('PID-5.4', 'Suffix (e.g., JR or III)', 'S-EX-A', $pidSegment/PID.5/PID.5.4, '20px', 'normal')"/>
					<xsl:copy-of select="util:ID-text-format('PID-5.7', 'Name Type Code', 'S-RC', $pidSegment/PID.5/PID.5.7, '20px', 'normal')"/>
					<tr>
						<th>PID-7</th>
						<th>Date/Time of Birth</th>
						<th/>
						<th/>
						<th/>
					</tr>
					<xsl:copy-of select="util:ID-text-format('PID-7.1', 'Time', 'S-EQ', util:parseDate($pidSegment/PID.7/PID.7.1), '20px', 'normal')"/>
					<xsl:copy-of select="util:ID-text-format('PID-8', 'Administrative Sex', 'S-TR-R', $pidSegment/PID.8, '0px', 'normal')"/>
					<xsl:for-each select="$pidSegment/PID.10">
						<tr>
							<th>PID-10</th>
							<th>Race</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('PID-10.1', 'Identifier', 'S-RC', PID.10.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('PID-10.2', 'Text', 'S-RC', PID.10.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('PID-10.3', 'Name of Coding System', 'S-RC', PID.10.3, '20px', 'normal')"/>
					</xsl:for-each>
				</tbody>
			</table>
		</fieldset>
	</xsl:template>
	<!-- 	Order Information - Incorporate 
			Used in the generic template, the CS FRU, the CS FRN, the Hepatitis FRU and the Hepatitis FRN
	-->
	<xsl:template name="orderInfo-IV">
		<xsl:param name="orcSegment"/>
		<xsl:for-each select="$orcSegment">
			<fieldset id="OrderInfo-IV">
				<table id="orderInformation">
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">Order Information - Incorporate Verification</xsl:with-param>
					</xsl:call-template>
					<tbody>
						<tr>
							<th> ORC-2/OBR-2 </th>
							<th>Placer Order Number</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<!-- This seems useless because ORC-2 = OBR-2 per conformance statement  -->
						<!-- <xsl:copy-of select="
                                util:ID-text-format('ORC-2.1/OBR-2.1', 'Entity Identifier', 'S-EX-A', if ($orcSegment/ORC.2/ORC.2.1 = $orcSegment/following-sibling::OBR[1]/OBR.2/OBR.2.1) then
                                    $orcSegment/ORC.2/ORC.2.1
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.2/OBR.2.1, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-2.2/OBR-2.2', 'Namespace ID', 'S-EX-A', if ($orcSegment/ORC.2/ORC.2.2 = $orcSegment/following-sibling::OBR[1]/OBR.2/OBR.2.2) then
                                    $orcSegment/ORC.2/ORC.2.2
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.2/OBR.2.2, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-2.3/OBR-2.3', 'Universal ID', 'S-EX-A', if ($orcSegment/ORC.2/ORC.2.3 = $orcSegment/following-sibling::OBR[1]/OBR.2/OBR.2.3) then
                                    $orcSegment/ORC.2/ORC.2.3
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.2/OBR.2.3, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-2.4/OBR-2.4', 'Universal ID Type', 'S-EX-A', if ($orcSegment/ORC.2/ORC.2.4 = $orcSegment/following-sibling::OBR[1]/OBR.2/OBR.2.4) then
                                    $orcSegment/ORC.2/ORC.2.4
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.2/OBR.2.4, '20px', 'normal')"/> -->
						<xsl:copy-of select="util:ID-text-format('ORC-2.1/OBR-2.1', 'Entity Identifier', 'S-EX-A', $orcSegment/ORC.2/ORC.2.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-2.2/OBR-2.2', 'Namespace ID', 'S-EX-A', $orcSegment/ORC.2/ORC.2.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-2.3/OBR-2.3', 'Universal ID', 'S-EX-A', $orcSegment/ORC.2/ORC.2.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-2.4/OBR-2.4', 'Universal ID Type', 'S-EX-A', $orcSegment/ORC.2/ORC.2.4, '20px', 'normal')"/>
						<tr>
							<th> ORC-3/OBR-3 </th>
							<th>Filler Order Number</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<!-- This seems useless because ORC-3 = OBR-3 per conformance statement -->
						<!-- <xsl:copy-of select="
                                util:ID-text-format('ORC-3.1/OBR-3.1', 'Entity Identifier', 'S-EX', if ($orcSegment/ORC.3/ORC.3.1 = $orcSegment/following-sibling::OBR[1]/OBR.3/OBR.3.1) then
                                    $orcSegment/ORC.3/ORC.3.1
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.3/OBR.3.1, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-3.2/OBR-3.2', 'Namespace ID', 'S-EX-A', if ($orcSegment/ORC.3/ORC.3.2 = $orcSegment/following-sibling::OBR[1]/OBR.3/OBR.3.2) then
                                    $orcSegment/ORC.3/ORC.3.2
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.3/OBR.3.2, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-3.3/OBR-3.3', 'Universal ID', 'S-EX-A', if ($orcSegment/ORC.3/ORC.3.3 = $orcSegment/following-sibling::OBR[1]/OBR.3/OBR.3.3) then
                                    $orcSegment/ORC.3/ORC.3.3
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.3/OBR.3.3, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-3.4/OBR-3.4', 'Universal ID Type', 'S-EX-A', if ($orcSegment/ORC.3/ORC.3.4 = $orcSegment/following-sibling::OBR[1]/OBR.3/OBR.3.4) then
                                    $orcSegment/ORC.3/ORC.3.4
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.3/OBR.3.4, '20px', 'normal')"/> -->
						<xsl:copy-of select="util:ID-text-format('ORC-3.1/OBR-3.1', 'Entity Identifier', 'S-EX', $orcSegment/ORC.3/ORC.3.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-3.2/OBR-3.2', 'Namespace ID', 'S-EX-A', $orcSegment/ORC.3/ORC.3.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-3.3/OBR-3.3', 'Universal ID', 'S-EX-A', $orcSegment/ORC.3/ORC.3.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-3.4/OBR-3.4', 'Universal ID Type', 'S-EX-A', $orcSegment/ORC.3/ORC.3.4, '20px', 'normal')"/>
						<tr>
							<th> ORC-12/OBR-16 </th>
							<th>Ordering Provider</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<!-- This seems useless because ORC-12 = OBR-16 per conformance statement -->
						<!-- <xsl:copy-of select="
                                util:ID-text-format('ORC-12.1/OBR-16.1', 'ID Number', 'S-RC', if ($orcSegment/ORC.12/ORC.12.1 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.1) then
                                    $orcSegment/ORC.12/ORC.12.1
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.1, '20px', 'normal')"/>
						<tr>
							<th style="text-indent:20px">ORC-12.2/OBR-16.2</th>
							<th>Family Name</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.2.1/OBR-16.2.1', 'Surname', 'S-RC', if ($orcSegment/ORC.12/ORC.12.2/ORC.12.2.1 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.2/OBR.16.2.1) then
                                    $orcSegment/ORC.12/ORC.12.2/ORC.12.2.1
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.2/OBR.16.2.1, '30px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.3/OBR-16.3', 'Given Name', 'S-RC', if ($orcSegment/ORC.12/ORC.12.3 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.3) then
                                    $orcSegment/ORC.12/ORC.12.3
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.3, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.4/OBR-16.4', 'Second and Further Given Names or Initials Thereof', 'S-RC', if ($orcSegment/ORC.12/ORC.12.4 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.4) then
                                    $orcSegment/ORC.12/ORC.12.4
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.4, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.5/OBR-16.5', 'Suffix (e.g., JR or III)', 'S-RC', if ($orcSegment/ORC.12/ORC.12.5 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.5) then
                                    $orcSegment/ORC.12/ORC.12.5
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.5, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.6/OBR-16.6', 'Prefix (e.g., DR)', 'S-RC', if ($orcSegment/ORC.12/ORC.12.6 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.6) then
                                    $orcSegment/ORC.12/ORC.12.6
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.6, '20px', 'normal')"/>
						<tr>
							<th style="text-indent:20px">ORC-12.9/OBR-16.9</th>
							<th>Assigning Authority</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.9.1/OBR-16.9.1', 'Namespace ID', 'S-EX-A', if ($orcSegment/ORC.12/ORC.12.9/ORC.12.9.1 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.9/OBR.16.9.1) then
                                    $orcSegment/ORC.12/ORC.12.9/ORC.12.9.1
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.9/OBR.16.9.1, '30px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.9.2/OBR-16.9.2', 'Universal ID', 'S-EX-A', if ($orcSegment/ORC.12/ORC.12.9/ORC.12.9.2 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.9/OBR.16.9.2) then
                                    $orcSegment/ORC.12/ORC.12.9/ORC.12.9.2
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.9/OBR.16.9.2, '30px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.9.3/OBR-16.9.3', 'Universal ID Type', 'S-EX-A', if ($orcSegment/ORC.12/ORC.12.9/ORC.12.9.3 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.9/OBR.16.9.3) then
                                    $orcSegment/ORC.12/ORC.12.9/ORC.12.9.3
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.9/OBR.16.9.3, '30px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.10/OBR-16.10', 'Name Type Code', 'S-RC', if ($orcSegment/ORC.12/ORC.12.10 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.10) then
                                    $orcSegment/ORC.12/ORC.12.10
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.10, '20px', 'normal')"/>
						<xsl:copy-of select="
                                util:ID-text-format('ORC-12.13/OBR-16.13', 'Identifier Type Code', 'S-RC', if ($orcSegment/ORC.12/ORC.12.13 = $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.13) then
                                    $orcSegment/ORC.12/ORC.12.13
                                else
                                    $orcSegment/following-sibling::OBR[1]/OBR.16/OBR.16.13, '20px', 'normal')"/>-->
						<xsl:copy-of select="util:ID-text-format('ORC-12.1/OBR-16.1', 'ID Number', 'S-RC', $orcSegment/ORC.12/ORC.12.1, '20px', 'normal')"/>
						<tr>
							<th style="text-indent:20px">ORC-12.2/OBR-16.2</th>
							<th>Family Name</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('ORC-12.2.1/OBR-16.2.1', 'Surname', 'S-RC',  $orcSegment/ORC.12/ORC.12.2/ORC.12.2.1, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-12.3/OBR-16.3', 'Given Name', 'S-RC', $orcSegment/ORC.12/ORC.12.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-12.4/OBR-16.4', 'Second and Further Given Names or Initials Thereof', 'S-RC', $orcSegment/ORC.12/ORC.12.4, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-12.5/OBR-16.5', 'Suffix (e.g., JR or III)', 'S-RC', $orcSegment/ORC.12/ORC.12.5, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-12.6/OBR-16.6', 'Prefix (e.g., DR)', 'S-RC', $orcSegment/ORC.12/ORC.12.6, '20px', 'normal')"/>
						<tr>
							<th style="text-indent:20px">ORC-12.9/OBR-16.9</th>
							<th>Assigning Authority</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('ORC-12.9.1/OBR-16.9.1', 'Namespace ID', 'S-EX-A', $orcSegment/ORC.12/ORC.12.9/ORC.12.9.1, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-12.9.2/OBR-16.9.2', 'Universal ID', 'S-EX-A', $orcSegment/ORC.12/ORC.12.9/ORC.12.9.2, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-12.9.3/OBR-16.9.3', 'Universal ID Type', 'S-EX-A', $orcSegment/ORC.12/ORC.12.9/ORC.12.9.3, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-12.10/OBR-16.10', 'Name Type Code', 'S-RC',$orcSegment/ORC.12/ORC.12.10, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('ORC-12.13/OBR-16.13', 'Identifier Type Code', 'S-RC', $orcSegment/ORC.12/ORC.12.13, '20px', 'normal')"/>
					</tbody>
				</table>
			</fieldset>
		</xsl:for-each>
	</xsl:template>
	<!-- 
			Order Information (cont'd) - Incorporate 
			Used in the generic template

			Order Information (cont'd) Parent - Incorporate 
			Used in the CS FRU (Parent OBR only), the CS FRN (Parent OBR only)
			Used in the Hepatitis FRU (Parent OBR only),  the Hepatitis FRN (Parent OBR only)
	-->
	<xsl:template name="orderInfocontd-IV">
		<xsl:param name="obrSegment"/>
		<!-- <xsl:param name="er7XMLMessage"/> -->
		<xsl:param name="messageID"/>
		<xsl:for-each select="$obrSegment">
			<fieldset id="OrderInfo-IV">
				<table id="orderInformation">
					<xsl:variable name="title">
						<xsl:choose>
							<!-- CS (FRU/FRN) Parent OBR -->
							<xsl:when test="util:isParentChild_CS_TestCase($messageID) = true() and not(fn:exists($obrSegment/OBR.26))">
								Order Information (cont'd) Parent Information - Incorporate Verification
							</xsl:when>
							<!-- Hepatitis (FRU/FRN) Parent OBR -->
							<xsl:when test="util:isParentChild_Hepatitis_TestCase($messageID) = true() and not(fn:exists($obrSegment/OBR.26))">
								Order Information (cont'd) Parent Information - Incorporate Verification
							</xsl:when>
							<!-- Non parent child test cases -->
							<xsl:otherwise>
								Order Information (cont'd) - Incorporate Verification
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">
							<xsl:value-of select="$title"/>
						</xsl:with-param>
					</xsl:call-template>
					<tbody>
						<!-- <xsl:if test="util:isParentChild_Hepatitis_TestCase($messageID) = true() and fn:exists($obrSegment/OBR.26)">
							<tr>
								<th> ORC-3/OBR-3</th>
								<th>Filler Order Number</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('ORC-3.1/OBR-3.1', 'Entity Identifier', 'S-EX', OBR.3/OBR.3.1 , '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.2/OBR-3.2', 'Namespace ID', 'S-EX-A', OBR.3/OBR.3.2, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.3/OBR-3.3', 'Universal ID', 'S-EX-A', OBR.3/OBR.3.3, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.4/OBR-3.4', 'Universal ID Type', 'S-EX-A',OBR.3/OBR.3.4, '20px', 'normal')"/>
						</xsl:if> -->
						<tr>
							<th>OBR-4</th>
							<th>Universal Service Identifier (Note 1)</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBR-4.1', 'Identifier', 'S-TR-R', OBR.4/OBR.4.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.2', 'Text', 'S-EX-A', OBR.4/OBR.4.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.3', 'Name of the Coding System', 'S-RC', OBR.4/OBR.4.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.4', 'Alternate Identifier', 'S-TR-R', OBR.4/OBR.4.4, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.5', 'Alternate Text', 'S-EX-A', OBR.4/OBR.4.5, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.6', 'Name of Alternate Coding System', 'S-RC', OBR.4/OBR.4.6, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.9', 'Original Text', 'S-EX', OBR.4/OBR.4.9, '20px', 'normal')"/>
						<tr>
							<th> OBR-7/SPM-17.1 </th>
							<th>Observation Date/Time</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="
                                util:ID-text-format('OBR-7.1/SPM-17.1.1', 'Time', 'S-EQ', if ($obrSegment/OBR.7/OBR.7.1 = $obrSegment/following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN/SPM/SPM.17/SPM.17.1/SPM.17.1.1) then
                                    util:formatDateTime($obrSegment/OBR.7/OBR.7.1)
                                else
                                    util:formatDateTime(following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN/SPM/SPM.17/SPM.17.1/SPM.17.1.1), '20px', 'normal')"/>
						<tr>
							<th> OBR-8/SPM-17.2 </th>
							<th>Observation End Date/Time</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="
                                util:ID-text-format('OBR-8.1/SPM-17.2.1', 'Time', 'S-EQ', if ($obrSegment/OBR.8/OBR.8.1 = $obrSegment/following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN/SPM/SPM.17/SPM.17.2/SPM.17.2.1) then
                                    util:formatDateTime($obrSegment/OBR.8/OBR.8.1)
                                else
                                    util:formatDateTime(following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.SPECIMEN/SPM/SPM.17/SPM.17.2/SPM.17.2.1), '20px', 'normal')"/>
						<!--xsl:copy-of
                            select="util:ID-text-format('OBR-11', 'Specimen Action Code', 'S-MA', OBR.4/OBR.4.1, '0px', 'normal')"/-->
						<tr>
							<th> OBR-13 </th>
							<th>Relevant Clinical Information</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBR-13.1', 'Identifier', 'S-TR-R', OBR.13/OBR.13.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-13.2', 'Text', 'S-EX-A', OBR.13/OBR.13.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-13.3', 'Name of the Coding System', 'S-RC', OBR.13/OBX.13.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-13.9', 'Original Text', 'S-EX', OBR.13/OBR.13.9, '20px', 'normal')"/>
						<tr>
							<th> OBR-22 </th>
							<th>Results Rpt/Status Chng - Date/Time</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBR-22.1', 'Time', 'S-EQ', util:formatDateTime(OBR.22/OBR.22.1), '20px', 'normal')"/>
						
						<xsl:copy-of select="util:ID-text-format('OBR-25', 'Result Status', 'S-TR-R', OBR.25, '0px', 'normal')"/>

						<!-- <xsl:if test="exists(OBR.26)">
							<tr>
								<th> OBR-26 </th>
								<th>Parent Result</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<tr>
								<th style="text-indent:20px"> OBR-26.1 </th>
								<th>Parent Observation Identifier (Note 2)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.1', 'Identifier', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.2', 'Text', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.3', 'Name of the Coding System', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.4', 'Alternate Identifier', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.4, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.5', 'Alternate Text', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.5, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.6', 'Name of Alternate Coding System', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.6, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2', 'Parent Observation Sub-Identifier', 'S-EX-A', OBR.26/OBR.26.2, '20px', 'normal')"/>
						</xsl:if> -->
						<xsl:for-each select="OBR.28">
							<tr>
								<th> OBR-28 </th>
								<th>Result Copies To</th>
								<!-- <th>Result Copies To (Note 2)</th>-->
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-28.1', 'ID Number', 'S-RC', OBR.28.1, '20px', 'normal')"/>
							<tr>
								<th style="text-indent:20px"> OBR-28.2 </th>
								<th>Family Name</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-28.2.1', 'Surname', 'S-EX-A', OBR.28.2/OBR.28.2.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-28.3', 'Given Name', 'S-EX-A', OBR.28.3, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-28.4', 'Second and Further Given Names or Initials Thereof', 'S-EX-A', OBR.28.4, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-28.5', 'Suffix (e.g., JR or III)', 'S-EX-A', OBR.28.5, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-28.6', 'Prefix (e.g., DR)', 'S-EX-A', OBR.28.6, '20px', 'normal')"/>
							<tr>
								<th style="text-indent:20px"> OBR-28.9 </th>
								<th>Assigning Authority </th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-28.9.1', 'Namespace ID', 'S-EX-A', OBR.28.9/OBR.28.9.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-28.9.2', 'Universal ID', 'S-EX-A', OBR.28.9/OBR.28.9.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-28.9.3', 'Universal ID Type', 'S-EX-A', OBR.28.9/OBR.28.9.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-28.10', 'Name Type Code', 'S-TR-R', OBR.28.10, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-28.13', 'Identifier Type Code', 'S-RC', OBR.28.13, '20px', 'normal')"/>
						</xsl:for-each>
						<!--  <xsl:if test="exists(OBR.29)">
                            <tr>
                                <th> OBR-29 </th>
                                <th>Parent (Note 2)</th>
                                <th/>
                                <th/>
                                <th/>
                            </tr>
                            <tr>
                                <th style="text-indent:20px"> OBR-29.1 </th>
                                <th>Placer Assigned Identifier </th>
                                <th/>
                                <th/>
                                <th/>
                            </tr>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-29.1.1', 'Entity Identifier', 'S-EX-A', OBR.29/OBR.29.1/OBR.29.1.1, '30px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-29.1.2', 'Namespace ID', 'S-EX-A', OBR.29/OBR.29.1/OBR.29.1.2, '30px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-29.1.3', 'Universal ID', 'S-EX-A', OBR.29/OBR.29.1/OBR.29.1.3, '30px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-29.1.4', 'Universal ID Type', 'S-EX-A', OBR.29/OBR.29.1/OBR.29.1.4, '30px', 'normal')"/>
                            <tr>
                                <th style="text-indent:20px"> OBR-29.2 </th>
                                <th>Filler Assigned Identifier </th>
                                <th/>
                                <th/>
                                <th/>
                            </tr>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-29.2.1', 'Entity Identifier', 'S-EX-A', OBR.29/OBR.29.2/OBR.29.2.1, '30px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-29.2.2', 'Namespace ID', 'S-EX-A', OBR.29/OBR.29.2/OBR.29.2.2, '30px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-29.2.3', 'Universal ID', 'S-EX-A', OBR.29/OBR.29.2/OBR.29.2.3, '30px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-29.2.4', 'Universal ID Type', 'S-EX-A', OBR.29/OBR.29.2/OBR.29.2.4, '30px', 'normal')"
                            />
                        </xsl:if> -->
						<!--tr>
                            <th> OBR-49 </th>
                            <th>Results Handling</th>
                            <th/>
                            <th/>
                            <th/>
                        </tr>
                        <xsl:copy-of
                            select="util:ID-text-format('OBR-49.1', 'Identifier', 'S-MA', OBR.49/OBR.49.1, '20px', 'normal')"/>
                        <xsl:copy-of
                            select="util:ID-text-format('OBR-49.2', 'Text', '', OBR.49/OBR.49.2, '20px', 'normal')"/>
                        <xsl:copy-of
                            select="util:ID-text-format('OBR-49.3', 'Name of Coding System', 'S-MA', OBR.49/OBR.49.3, '20px', 'normal')"/>

                        <xsl:copy-of
                            select="util:ID-text-format('OBR-49.9', 'Original Text', 'S-MA', OBR.49/OBR.49.9, '20px', 'normal')"/-->
						<!--    <xsl:if test="exists(OBR.50)">
                            <tr>
                                <th> OBR-50 </th>
                                <th>Parent Universal Service Identifier (Note 2)</th>
                                <th/>
                                <th/>
                                <th/>
                            </tr>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-50.1', 'Identifier', 'S-EX-A', OBR.50/OBR.50.1, '20px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-50.2', 'Text', 'S-EX-A', OBR.50/OBR.50.2, '20px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-50.3', 'Name of Coding System', 'S-EX-A', OBR.50/OBR.50.3, '20px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-50.4', 'Alternate Identifier', 'S-EX-A', OBR.50/OBR.50.4, '20px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-50.5', 'Alternate Text', 'S-EX-A', OBR.50/OBR.50.5, '20px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-50.6', 'Name of Alternate Coding System', 'S-EX-A', OBR.50/OBR.50.6, '20px', 'normal')"/>
                            <xsl:copy-of
                                select="util:ID-text-format('OBR-50.9', 'Original Text', 'S-EX-A', OBR.50/OBR.50.9, '20px', 'normal')"
                            />
                        </xsl:if> -->
						<tr>
							<td colspan="5">
								<b>Note 1</b> -Store the <u>Identifier</u> and the
                                    <u>Text</u> for each populated triplet using the S-EX-A, S-TR-R,
                                or S-EX store requirement as indicated. If <u>Original Text</u>
                                field is populated, MUST store the exact data received.</td>
						</tr>
						<!-- <tr>
                            <td colspan="5"><b>Note 2 </b>- The HIT Module must display the
                                relationship to the parent, but is not required to store the actual
                                received data. Goal of this field is to be able to establish an
                                association to a specific result, if that cannot be established use
                                S-EX to save the information</td>
                        </tr> -->
						<!-- <tr>
                            <td colspan="5"><b>Note 2</b> - When OBR-49 data = &apos;CC&apos;, then
                                OBR-28 fields = S-RC; when OBR-49 data = &apos;BCC&apos; then OBR-28
                                fields should not be populated, but if populated = S-EX</td>
                        </tr> -->
					</tbody>
				</table>
			</fieldset>
		</xsl:for-each>
	</xsl:template>
	<!-- Caro : orderInfocontd_child-IV-orig does not seem to be used -->
	<!-- <xsl:template name="orderInfocontd_child-IV-orig">
		<xsl:param name="obrSegment"/>
		<xsl:param name="er7XMLMessage"/>
		<xsl:param name="messageID"/>
		<xsl:for-each select="$obrSegment[position() > 1]/OBR">
			<fieldset id="OrderInfo-IV">
				<table id="orderInformation">
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">Order Information (cont'd)- Incorporate
                            Verification</xsl:with-param>
					</xsl:call-template>
					<tbody>
						<xsl:if test="
                                ($messageID = 'LRI_4.1_2.1-GU_FRU') or ($messageID = 'LRI_4.1_3.1-GU_FRU') or ($messageID = 'LRI_4.1_4.1-GU_FRU') or ($messageID = 'LRI_4.1_2.1-NG_FRU') or ($messageID = 'LRI_4.1_3.1-NG_FRU') or ($messageID = 'LRI_4.1_4.1-NG_FRU')
                                or ($messageID = 'LRI_5.0_2.1-GU_FRU') or ($messageID = 'LRI_5.0_2.1-NG_FRU')">
							<tr>
								<th> ORC-3/OBR-3 (Child Information)</th>
								<th>Filler Order Number</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-3.1/OBR-3.1', 'Entity Identifier', 'S-EX', if (OBR.3/OBR.3.1 = preceding::ORC[1]/ORC.3/ORC.3.1) then
                                        OBR.3/OBR.3.1
                                    else
                                        ../preceding::ORC[1]/ORC.3/ORC.3.1, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-3.2/OBR-3.2', 'Namespace ID', 'S-EX-A', if (OBR.3/OBR.3.2 = ../preceding::ORC[1]/ORC.3/ORC.3.2) then
                                        OBR.3/OBR.3.2
                                    else
                                        ../preceding::ORC[1]/ORC.3/ORC.3.2, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-3.3/OBR-3.3', 'Universal ID', 'S-EX-A', if (OBR.3/OBR.3.3 = ../preceding::ORC[1]/ORC.3/ORC.3.3) then
                                        OBR.3/OBR.3.3
                                    else
                                        ../preceding::ORC[1]/ORC.3/ORC.3.3, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-3.4/OBR-3.4', 'Universal ID Type', 'S-EX-A', if (OBR.3/OBR.3.4 = ../preceding::ORC[1]/ORC.3/ORC.3.4) then
                                        OBR.3/OBR.3.4
                                    else
                                        ../preceding::ORC[1]/ORC.3/ORC.3.4, '20px', 'normal')"/>
						</xsl:if>
						<tr>
							<th> OBR-4 <xsl:if test="
                                        ($messageID = 'LRI_4.2_2.1-GU_FRN') or ($messageID = 'LRI_4.2_3.1-GU_FRN') or ($messageID = 'LRI_4.2_4.1-GU_FRN') or ($messageID = 'LRI_4.2_2.1-NG_FRN') or ($messageID = 'LRI_4.2_3.1-NG_FRN') or ($messageID = 'LRI_4.2_4.1-NG_FRN')
                                        or ($messageID = 'LRI_5.1_2.1-GU_FRN') or ($messageID = 'LRI_5.1_2.1-NG_FRN')">
									<xsl:value-of select="'(Child Information)'"/>
								</xsl:if>
							</th>
							<th>Universal Service Identifier (Note 1)</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBR-4.1', 'Identifier', 'S-TR-R', OBR.4/OBR.4.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.2', 'Text', 'S-EX-A', OBR.4/OBR.4.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.3', 'Name of the Coding System', 'S-RC', OBR.4/OBR.4.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.4', 'Alternate Identifier', 'S-TR-R', OBR.4/OBR.4.4, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.5', 'Alternate Text', 'S-EX-A', OBR.4/OBR.4.5, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.6', 'Name of Alternate Coding System', 'S-RC', OBR.4/OBR.4.6, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.9', 'Original Text', 'S-EX', OBR.4/OBR.4.9, '20px', 'normal')"/>
						<xsl:if test="exists(OBR.26)">
							<tr>
								<th> OBR-26 </th>
								<th>Parent Result</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<tr>
								<th style="text-indent:20px"> OBR-26.1 </th>
								<th>Parent Observation Identifier (Note 2)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.1', 'Identifier', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.2', 'Text', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.3', 'Name of the Coding System', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.4', 'Alternate Identifier', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.4, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.5', 'Alternate Text', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.5, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.6', 'Name of Alternate Coding System', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.6, '30px', 'normal')"/>
							<tr>
								<th style="text-indent:20px"> OBR-26.2 </th>
								<th>Parent Observation Sub-Identifier</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.2', 'Group', 'S-EX-A', OBR.26/OBR.26.2/OBR.26.2.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.3', 'Sequence', 'S-EX-A', OBR.26/OBR.26.2/OBR.26.2.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.4', 'Identifier', 'S-EX-A', OBR.26/OBR.26.2/OBR.26.2.4, '30px', 'normal')"/>
						</xsl:if>
						<xsl:if test="exists(OBR.29)">
							<tr>
								<th> OBR-29 </th>
								<th>Parent (Note 2)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<tr>
								<th style="text-indent:20px"> OBR-29.1 </th>
								<th>Placer Assigned Identifier </th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.1', 'Entity Identifier', 'S-EX-A', OBR.29/OBR.29.1/OBR.29.1.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.2', 'Namespace ID', 'S-EX-A', OBR.29/OBR.29.1/OBR.29.1.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.3', 'Universal ID', 'S-EX-A', OBR.29/OBR.29.1/OBR.29.1.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.4', 'Universal ID Type', 'S-EX-A', OBR.29/OBR.29.1/OBR.29.1.4, '30px', 'normal')"/>
							<tr>
								<th style="text-indent:20px"> OBR-29.2 </th>
								<th>Filler Assigned Identifier </th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.1', 'Entity Identifier', 'S-EX-A', OBR.29/OBR.29.2/OBR.29.2.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.2', 'Namespace ID', 'S-EX-A', OBR.29/OBR.29.2/OBR.29.2.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.3', 'Universal ID', 'S-EX-A', OBR.29/OBR.29.2/OBR.29.2.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.4', 'Universal ID Type', 'S-EX-A', OBR.29/OBR.29.2/OBR.29.2.4, '30px', 'normal')"/>
						</xsl:if>
						<xsl:if test="exists(OBR.50) or exists(preceding::ORC[1]/ORC.31)">
							<tr>
								<th> ORC-31/OBR-50 </th>
								<th>Parent Universal Service Identifier</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.1/OBR-50.1', 'Identifier', 'S-EX-A', if (OBR.50/OBR.50.1 = preceding::ORC[1]/ORC.31/ORC.31.1) then
                                        OBR.50/OBR.50.1
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.1, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.2/OBR-50.2', 'Text', 'S-EX-A', if (OBR.50/OBR.50.2 = preceding::ORC[1]/ORC.31/ORC.31.2) then
                                        OBR.50/OBR.50.2
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.2, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.3/OBR-50.3', 'Name of Coding System', 'S-EX-A', if (OBR.50/OBR.50.3 = preceding::ORC[1]/ORC.31/ORC.31.3) then
                                        OBR.50/OBR.50.3
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.3, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.4/OBR-50.4', 'Alternate Identifier', 'S-EX-A', if (OBR.50/OBR.50.4 = preceding::ORC[1]/ORC.31/ORC.31.4) then
                                        OBR.50/OBR.50.4
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.4, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.5/OBR-50.5', 'Alternate Text', 'S-EX-A', if (OBR.50/OBR.50.5 = preceding::ORC[1]/ORC.31/ORC.31.5) then
                                        OBR.50/OBR.50.5
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.5, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.6/OBR-50.6', 'Name of Alternate Coding System', 'S-EX-A', if (OBR.50/OBR.50.6 = preceding::ORC[1]/ORC.31/ORC.31.6) then
                                        OBR.50/OBR.50.6
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.6, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.9/OBR-50.9', 'Original Text', 'S-EX-A', if (OBR.50/OBR.50.7 = preceding::ORC[1]/ORC.31/ORC.31.7) then
                                        OBR.50/OBR.50.7
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.7, '20px', 'normal')"/>
						</xsl:if>
						<tr>
							<td colspan="5">
								<b>Note 1</b> -Store the <u>Identifier</u> and the
                                    <u>Text</u> for each populated triplet using the S-EX-A, S-TR-R,
                                or S-EX store requirement as indicated. If <u>Original Text</u>
                                field is populated, MUST store the exact data received.</td>
						</tr>
						<tr>
							<td colspan="5">
								<b>Note 2 </b>- The HIT Module must display the
                                relationship to the parent, but is not required to store the actual
                                received data when the association to a specific result is achieved,
                                otherwise use S-EX to save the information.</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<br/>
		</xsl:for-each>
	</xsl:template> -->
<!--	<xsl:template name="orderInfocontd_child-IV-2">
		<xsl:param name="obrSegment"/>
		<xsl:param name="er7XMLMessage"/>
		<xsl:param name="messageID"/>
		<xsl:for-each select=".">
			<fieldset id="OrderInfo-IV">
				<table id="orderInformation">
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">Order Information (cont'd) Child Information - Incorporate Verification</xsl:with-param>
					</xsl:call-template>
					<tbody>
						--><!-- Only display ORC-3/OBR-3 for FRU --><!--
						<xsl:if test="
                                ($messageID = 'LRI_4.1_2.1-GU_FRU') or ($messageID = 'LRI_4.1_3.1-GU_FRU') or ($messageID = 'LRI_4.1_4.1-GU_FRU') or 
								($messageID = 'LRI_4.1_2.1-NG_FRU') or ($messageID = 'LRI_4.1_3.1-NG_FRU') or ($messageID = 'LRI_4.1_4.1-NG_FRU') or 
								($messageID = 'LRI_5.0_2.1-GU_FRU') or ($messageID = 'LRI_5.0_2.1-NG_FRU')">
							<tr>
								<th> ORC-3/OBR-3 (Child Information)</th>
								<th>Filler Order Number</th>
								<th/>
								<th/>
								<th/>
							</tr>
						--><!-- 	<xsl:copy-of select="
                                    util:ID-text-format('ORC-3.1/OBR-3.1', 'Entity Identifier', 'S-EX', if ($obrSegment/OBR.3/OBR.3.1 = preceding::ORC[1]/ORC.3/ORC.3.1) then
                                        $obrSegment/OBR.3/OBR.3.1
                                    else
                                        ../preceding::ORC[1]/ORC.3/ORC.3.1, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-3.2/OBR-3.2', 'Namespace ID', 'S-EX-A', if ($obrSegment/OBR.3/OBR.3.2 = ../preceding::ORC[1]/ORC.3/ORC.3.2) then
                                        $obrSegment/OBR.3/OBR.3.2
                                    else
                                        ../preceding::ORC[1]/ORC.3/ORC.3.2, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-3.3/OBR-3.3', 'Universal ID', 'S-EX-A', if ($obrSegment/OBR.3/OBR.3.3 = ../preceding::ORC[1]/ORC.3/ORC.3.3) then
                                        $obrSegment/OBR.3/OBR.3.3
                                    else
                                        ../preceding::ORC[1]/ORC.3/ORC.3.3, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-3.4/OBR-3.4', 'Universal ID Type', 'S-EX-A', if ($obrSegment/OBR.3/OBR.3.4 = ../preceding::ORC[1]/ORC.3/ORC.3.4) then
                                        $obrSegment/OBR.3/OBR.3.4
                                    else
                                        ../preceding::ORC[1]/ORC.3/ORC.3.4, '20px', 'normal')"/>
--><!--
							<xsl:copy-of select="util:ID-text-format('ORC-3.1/OBR-3.1', 'Entity Identifier', 'S-EX', $obrSegment/OBR.3/OBR.3.1, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.2/OBR-3.2', 'Namespace ID', 'S-EX-A', $obrSegment/OBR.3/OBR.3.2, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.3/OBR-3.3', 'Universal ID', 'S-EX-A', $obrSegment/OBR.3/OBR.3.3, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.4/OBR-3.4', 'Universal ID Type', 'S-EX-A', $obrSegment/OBR.3/OBR.3.4, '20px', 'normal')"/>
						</xsl:if>
						<tr>
							<th> OBR-4 
								--><!-- <xsl:if test="
                                        ($messageID = 'LRI_4.2_2.1-GU_FRN') or ($messageID = 'LRI_4.2_3.1-GU_FRN') or ($messageID = 'LRI_4.2_4.1-GU_FRN') or 
										($messageID = 'LRI_4.2_2.1-NG_FRN') or ($messageID = 'LRI_4.2_3.1-NG_FRN') or ($messageID = 'LRI_4.2_4.1-NG_FRN') or 
										($messageID = 'LRI_5.1_2.1-GU_FRN') or ($messageID = 'LRI_5.1_2.1-NG_FRN')">
									<xsl:value-of select="'(Child Information)'"/>
								</xsl:if> --><!--
							</th>
							<th>Universal Service Identifier (Note 1)</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBR-4.1', 'Identifier', 'S-TR-R', $obrSegment/OBR.4/OBR.4.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.2', 'Text', 'S-EX-A', $obrSegment/OBR.4/OBR.4.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.3', 'Name of the Coding System', 'S-RC', $obrSegment/OBR.4/OBR.4.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.4', 'Alternate Identifier', 'S-TR-R', $obrSegment/OBR.4/OBR.4.4, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.5', 'Alternate Text', 'S-EX-A', $obrSegment/OBR.4/OBR.4.5, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.6', 'Name of Alternate Coding System', 'S-RC', $obrSegment/OBR.4/OBR.4.6, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.9', 'Original Text', 'S-EX', $obrSegment/OBR.4/OBR.4.9, '20px', 'normal')"/>
						<xsl:if test="exists($obrSegment/OBR.26)">
							<tr>
								<th> OBR-26 </th>
								<th>Parent Result</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<tr>
								<th style="text-indent:20px"> OBR-26.1 </th>
								<th>Parent Observation Identifier (Note 2)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.1', 'Identifier', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.2', 'Text', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.3', 'Name of the Coding System', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.4', 'Alternate Identifier', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.4, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.5', 'Alternate Text', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.5, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.6', 'Name of Alternate Coding System', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.6, '30px', 'normal')"/>
							<tr>
								<th style="text-indent:20px"> OBR-26.2 </th>
								<th>Parent Observation Sub-Identifier</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.2', 'Group', 'S-EX-A', $obrSegment/OBR.26/OBR.26.2/OBR.26.2.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.3', 'Sequence', 'S-EX-A', $obrSegment/OBR.26/OBR.26.2/OBR.26.2.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.4', 'Identifier', 'S-EX-A', $obrSegment/OBR.26/OBR.26.2/OBR.26.2.4, '30px', 'normal')"/>
						</xsl:if>
						<xsl:if test="exists($obrSegment/OBR.29)">
							<tr>
								<th> OBR-29 </th>
								<th>Parent (Note 2)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<tr>
								<th style="text-indent:20px"> OBR-29.1 </th>
								<th>Placer Assigned Identifier </th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.1', 'Entity Identifier', 'S-EX-A', $obrSegment/OBR.29/OBR.29.1/OBR.29.1.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.2', 'Namespace ID', 'S-EX-A', $obrSegment/OBR.29/OBR.29.1/OBR.29.1.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.3', 'Universal ID', 'S-EX-A', $obrSegment/OBR.29/OBR.29.1/OBR.29.1.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.4', 'Universal ID Type', 'S-EX-A', $obrSegment/OBR.29/OBR.29.1/OBR.29.1.4, '30px', 'normal')"/>
							<tr>
								<th style="text-indent:20px"> OBR-29.2 </th>
								<th>Filler Assigned Identifier </th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.1', 'Entity Identifier', 'S-EX-A', $obrSegment/OBR.29/OBR.29.2/OBR.29.2.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.2', 'Namespace ID', 'S-EX-A', $obrSegment/OBR.29/OBR.29.2/OBR.29.2.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.3', 'Universal ID', 'S-EX-A', $obrSegment/OBR.29/OBR.29.2/OBR.29.2.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.4', 'Universal ID Type', 'S-EX-A', $obrSegment/OBR.29/OBR.29.2/OBR.29.2.4, '30px', 'normal')"/>
						</xsl:if>
						--><!-- <xsl:if test="exists($obrSegment/OBR.50) or exists(preceding::ORC[1]/ORC.31)"> --><!--
						<xsl:if test="exists($obrSegment/OBR.50)">
							<tr>
								<th> ORC-31/OBR-50 </th>
								<th>Parent Universal Service Identifier</th>
								<th/>
								<th/>
								<th/>
							</tr>
							--><!-- <xsl:copy-of select="
                                    util:ID-text-format('ORC-31.1/OBR-50.1', 'Identifier', 'S-EX-A', if ($obrSegment/OBR.50/OBR.50.1 = preceding::ORC[1]/ORC.31/ORC.31.1) then
                                        $obrSegment/OBR.50/OBR.50.1
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.1, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.2/OBR-50.2', 'Text', 'S-EX-A', if ($obrSegment/OBR.50/OBR.50.2 = preceding::ORC[1]/ORC.31/ORC.31.2) then
                                        $obrSegment/OBR.50/OBR.50.2
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.2, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.3/OBR-50.3', 'Name of Coding System', 'S-EX-A', if ($obrSegment/OBR.50/OBR.50.3 = preceding::ORC[1]/ORC.31/ORC.31.3) then
                                        $obrSegment/OBR.50/OBR.50.3
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.3, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.4/OBR-50.4', 'Alternate Identifier', 'S-EX-A', if ($obrSegment/OBR.50/OBR.50.4 = preceding::ORC[1]/ORC.31/ORC.31.4) then
                                        $obrSegment/OBR.50/OBR.50.4
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.4, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.5/OBR-50.5', 'Alternate Text', 'S-EX-A', if ($obrSegment/OBR.50/OBR.50.5 = preceding::ORC[1]/ORC.31/ORC.31.5) then
                                        $obrSegment/OBR.50/OBR.50.5
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.5, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.6/OBR-50.6', 'Name of Alternate Coding System', 'S-EX-A', if ($obrSegment/OBR.50/OBR.50.6 = preceding::ORC[1]/ORC.31/ORC.31.6) then
                                        $obrSegment/OBR.50/OBR.50.6
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.6, '20px', 'normal')"/>
							<xsl:copy-of select="
                                    util:ID-text-format('ORC-31.9/OBR-50.9', 'Original Text', 'S-EX-A', if ($obrSegment/OBR.50/OBR.50.7 = preceding::ORC[1]/ORC.31/ORC.31.7) then
                                        $obrSegment/OBR.50/OBR.50.7
                                    else
                                        preceding::ORC[1]/ORC.31/ORC.31.7, '20px', 'normal')"/> --><!--
                            <xsl:copy-of select="util:ID-text-format('ORC-31.1/OBR-50.1', 'Identifier', 'S-EX-A', $obrSegment/OBR.50/OBR.50.1, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.2/OBR-50.2', 'Text', 'S-EX-A', $obrSegment/OBR.50/OBR.50.2, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.3/OBR-50.3', 'Name of Coding System', 'S-EX-A', $obrSegment/OBR.50/OBR.50.3, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.4/OBR-50.4', 'Alternate Identifier', 'S-EX-A', $obrSegment/OBR.50/OBR.50.4, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.5/OBR-50.5', 'Alternate Text', 'S-EX-A', $obrSegment/OBR.50/OBR.50.5, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.6/OBR-50.6', 'Name of Alternate Coding System', 'S-EX-A', $obrSegment/OBR.50/OBR.50.6, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.9/OBR-50.9', 'Original Text', 'S-EX-A', $obrSegment/OBR.50/OBR.50.7, '20px', 'normal')"/>
						</xsl:if>
						<tr>
							<td colspan="5">
								<b>Note 1</b> -Store the <u>Identifier</u> and the
                                    <u>Text</u> for each populated triplet using the S-EX-A, S-TR-R,
                                or S-EX store requirement as indicated. If <u>Original Text</u>
                                field is populated, MUST store the exact data received.</td>
						</tr>
						<tr>
							<td colspan="5">
								<b>Note 2 </b>- The HIT Module must display the
                                relationship to the parent, but is not required to store the actual
                                received data when the association to a specific result is achieved,
                                otherwise use S-EX to save the information.</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<br/>
		</xsl:for-each>
	</xsl:template>-->
	
	<xsl:template name="orderInfocontd_child-IV">
		<xsl:param name="obrSegment"/>
		<xsl:param name="messageID"/>
			<fieldset id="OrderInfo-IV">
				<table id="orderInformation">
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">Order Information (cont'd) Child Information - Incorporate Verification</xsl:with-param>
					</xsl:call-template>
					<tbody>
						<!-- Only display ORC-3/OBR-3 for FRU -->
						<xsl:if test="fn:ends-with($messageID,'_FRU')">
							<tr>
								<th> ORC-3/OBR-3 </th>
								<th>Filler Order Number</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('ORC-3.1/OBR-3.1', 'Entity Identifier', 'S-EX', $obrSegment/OBR.3/OBR.3.1, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.2/OBR-3.2', 'Namespace ID', 'S-EX-A', $obrSegment/OBR.3/OBR.3.2, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.3/OBR-3.3', 'Universal ID', 'S-EX-A', $obrSegment/OBR.3/OBR.3.3, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-3.4/OBR-3.4', 'Universal ID Type', 'S-EX-A', $obrSegment/OBR.3/OBR.3.4, '20px', 'normal')"/>
						</xsl:if>
						<tr>
							<th> OBR-4 </th>
							<th>Universal Service Identifier (Note 1)</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBR-4.1', 'Identifier', 'S-TR-R', $obrSegment/OBR.4/OBR.4.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.2', 'Text', 'S-EX-A', $obrSegment/OBR.4/OBR.4.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.3', 'Name of the Coding System', 'S-RC', $obrSegment/OBR.4/OBR.4.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.4', 'Alternate Identifier', 'S-TR-R', $obrSegment/OBR.4/OBR.4.4, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.5', 'Alternate Text', 'S-EX-A', $obrSegment/OBR.4/OBR.4.5, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.6', 'Name of Alternate Coding System', 'S-RC', $obrSegment/OBR.4/OBR.4.6, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBR-4.9', 'Original Text', 'S-EX', $obrSegment/OBR.4/OBR.4.9, '20px', 'normal')"/>
						<xsl:if test="exists($obrSegment/OBR.26)">
							<tr>
								<th> OBR-26 </th>
								<th>Parent Result</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<tr>
								<th style="text-indent:20px"> OBR-26.1 </th>
								<th>Parent Observation Identifier (Note 2)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.1', 'Identifier', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.2', 'Text', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.3', 'Name of the Coding System', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.4', 'Alternate Identifier', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.4, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.5', 'Alternate Text', 'S-EX-A', $obrSegment/OBR.26/OBR.26.1/OBR.26.1.5, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.1.6', 'Name of Alternate Coding System', 'S-EX-A', OBR.26/OBR.26.1/OBR.26.1.6, '30px', 'normal')"/>
							<tr>
								<th style="text-indent:20px"> OBR-26.2 </th>
								<th>Parent Observation Sub-Identifier</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.2', 'Group', 'S-EX-A', $obrSegment/OBR.26/OBR.26.2/OBR.26.2.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.3', 'Sequence', 'S-EX-A', $obrSegment/OBR.26/OBR.26.2/OBR.26.2.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-26.2.4', 'Identifier', 'S-EX-A', $obrSegment/OBR.26/OBR.26.2/OBR.26.2.4, '30px', 'normal')"/>
						</xsl:if>
						<xsl:if test="exists($obrSegment/OBR.29)">
							<tr>
								<th> OBR-29 </th>
								<th>Parent (Note 2)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<tr>
								<th style="text-indent:20px"> OBR-29.1 </th>
								<th>Placer Assigned Identifier </th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.1', 'Entity Identifier', 'S-EX-A', $obrSegment/OBR.29/OBR.29.1/OBR.29.1.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.2', 'Namespace ID', 'S-EX-A', $obrSegment/OBR.29/OBR.29.1/OBR.29.1.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.3', 'Universal ID', 'S-EX-A', $obrSegment/OBR.29/OBR.29.1/OBR.29.1.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.1.4', 'Universal ID Type', 'S-EX-A', $obrSegment/OBR.29/OBR.29.1/OBR.29.1.4, '30px', 'normal')"/>
							<tr>
								<th style="text-indent:20px"> OBR-29.2 </th>
								<th>Filler Assigned Identifier </th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.1', 'Entity Identifier', 'S-EX-A', $obrSegment/OBR.29/OBR.29.2/OBR.29.2.1, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.2', 'Namespace ID', 'S-EX-A', $obrSegment/OBR.29/OBR.29.2/OBR.29.2.2, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.3', 'Universal ID', 'S-EX-A', $obrSegment/OBR.29/OBR.29.2/OBR.29.2.3, '30px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('OBR-29.2.4', 'Universal ID Type', 'S-EX-A', $obrSegment/OBR.29/OBR.29.2/OBR.29.2.4, '30px', 'normal')"/>
						</xsl:if>
						<xsl:if test="exists($obrSegment/OBR.50)">
							<tr>
								<th> ORC-31/OBR-50 </th>
								<th>Parent Universal Service Identifier</th>
								<th/>
								<th/>
								<th/>
							</tr>
                            <xsl:copy-of select="util:ID-text-format('ORC-31.1/OBR-50.1', 'Identifier', 'S-EX-A', $obrSegment/OBR.50/OBR.50.1, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.2/OBR-50.2', 'Text', 'S-EX-A', $obrSegment/OBR.50/OBR.50.2, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.3/OBR-50.3', 'Name of Coding System', 'S-EX-A', $obrSegment/OBR.50/OBR.50.3, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.4/OBR-50.4', 'Alternate Identifier', 'S-EX-A', $obrSegment/OBR.50/OBR.50.4, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.5/OBR-50.5', 'Alternate Text', 'S-EX-A', $obrSegment/OBR.50/OBR.50.5, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.6/OBR-50.6', 'Name of Alternate Coding System', 'S-EX-A', $obrSegment/OBR.50/OBR.50.6, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('ORC-31.9/OBR-50.9', 'Original Text', 'S-EX-A', $obrSegment/OBR.50/OBR.50.7, '20px', 'normal')"/>
						</xsl:if>
						<tr>
							<td colspan="5">
								<b>Note 1</b> -Store the <u>Identifier</u> and the
                                    <u>Text</u> for each populated triplet using the S-EX-A, S-TR-R,
                                or S-EX store requirement as indicated. If <u>Original Text</u>
                                field is populated, MUST store the exact data received.</td>
						</tr>
						<tr>
							<td colspan="5">
								<b>Note 2 </b>- The HIT Module must display the
                                relationship to the parent, but is not required to store the actual
                                received data when the association to a specific result is achieved,
                                otherwise use S-EX to save the information.</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<br/>
	</xsl:template>
	<xsl:template name="performingOrderInfo-IV">
		<xsl:param name="obxSegment"/>
		<fieldset id="PerformingOrderInfo-IV">
			<xsl:for-each select="$obxSegment">
				<table id="identifierInformation">
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">Performing Organization Information - Incorporate Verification</xsl:with-param>
					</xsl:call-template>
					<tbody>
						<tr>
							<th>OBX-23</th>
							<th>Performing Organization Name</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBX-23.1', 'Organization Name (Note 1)', 'S-TR-R', $obxSegment/OBX.23/OBX.23.1, '20px', 'normal')"/>
						<tr>
							<th style="text-indent:20px">OBX-23.6</th>
							<th>Assigning Authority (Note 2)</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBX-23.6.1', 'Namespace ID', 'S-EX-A', $obxSegment/OBX.23/OBX.23.6/OBX.23.6.1, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-23.6.2', 'Universal ID', 'S-EX-A', $obxSegment/OBX.23/OBX.23.6/OBX.23.6.2, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-23.6.3', 'Universal ID Type', 'S-EX-A', $obxSegment/OBX.23/OBX.23.6/OBX.23.6.3, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-23.7', 'Identifier Type Code', 'S-RC', $obxSegment/OBX.23/OBX.23.7, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-23.10', 'Organization Identifier', 'S-TR-R', $obxSegment/OBX.23/OBX.23.10, '20px', 'normal')"/>
						<tr>
							<th>OBX-24</th>
							<th>Performing Organization Address</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<tr>
							<th style="text-indent:20px">OBX-24.1</th>
							<th>Street Address</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBX-24.1.1', 'Street or Mailing Address', 'S-EX-A', $obxSegment/OBX.24/OBX.24.1/OBX.24.1.1, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-24.2', 'Other Designation', 'S-EX-A', $obxSegment/OBX.24/OBX.24.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX.24.3', 'City', 'S-EX-A', $obxSegment/OBX.24/OBX.24.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-24.4', 'State or Province', 'S-EX-A', $obxSegment/OBX.24/OBX.24.4, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-24.5', 'Zip or Postal Code', 'S-EX-A', $obxSegment/OBX.24/OBX.24.5, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-24.6', 'Country', 'S-TR-R', $obxSegment/OBX.24/OBX.24.6, '20px', 'normal')"/>
						<tr>
							<th>OBX-25</th>
							<th>Performing Organization Medical Director</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBX-25.1', 'ID Number', 'S-RC', $obxSegment/OBX.25/OBX.25.1, '20px', 'normal')"/>
						<tr>
							<th style="text-indent:20px">OBX-25.2</th>
							<th>Family Name</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBX-25.2.1', 'Surname', 'S-TR-R', $obxSegment/OBX.25/OBX.25.2/OBX.25.2.1, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-25.3', 'Given Name', 'S-TR-R', $obxSegment/OBX.25/OBX.25.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-25.4', 'Second and Further Given Names or Initials Thereof', 'S-TR-R', $obxSegment/OBX.25/OBX.25.4, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-25.5', 'Suffix (e.g., JR or III)', 'S-TR-R', $obxSegment/OBX.25/OBX.25.5, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-25.6', 'Prefix (e.g., DR)', 'S-TR-R', $obxSegment/OBX.23/OBX.25.6, '20px', 'normal')"/>
						<tr>
							<th style="text-indent:20px">OBX-25.9</th>
							<th>Assigning Authority (Note 2)</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('OBX-25.9.1', 'Namespace ID', 'S-EX-A', $obxSegment/OBX.25/OBX.25.9/OBX.25.9.1, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-25.9.2', 'Universal ID', 'S-EX-A', $obxSegment/OBX.25/OBX.25.9/OBX.25.9.2, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-25.9.3', 'Universal ID Type', 'S-EX-A', $obxSegment/OBX.25/OBX.25.9/OBX.25.9.3, '30px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-25.10', 'Name Type Code', 'S-RC', $obxSegment/OBX.25/OBX.25.10, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('OBX-25.13', 'Identifier Type Code', 'S-RC', $obxSegment/OBX.25/OBX.25.13, '20px', 'normal')"/>
						<tr>
							<td colspan="5">
								<b>Note 1</b> - The HIT Module must store the Organization Name or
                                be able to recreate it. If the HIT Module is able to demonstrate
                                Organization Name: ID is always 1:1, then the HIT Module is
                                permitted to store and recreate (S-TR-R). </td>
						</tr>
						<tr>
							<td colspan="5">
								<b>Note 2</b> - Determine requirement for support of 2nd
                                component or 3rd and 4th component based on the EI or HD Profile
                            </td>
						</tr>
					</tbody>
				</table>
			</xsl:for-each>
		</fieldset>
	</xsl:template>
	<!--<xsl:template name="resultInfo-IV">
		<xsl:param name="obxSegment"/>
		<xsl:param name="er7XMLMessage"/>
		<xsl:param name="messageID"/>
		<fieldset id="ResultInfo-IV">
			--><!-- [TODO] caro what is that for ? --><!--
			<xsl:for-each select="$obxSegment/OBX | $obxSegment[name(.) = 'OBR']">
				<xsl:variable name="childobr">
				</xsl:variable>
				<xsl:choose>
					--><!-- [TODO] caro what is that for ? --><!--
					<xsl:when test="name(.) = 'OBR'">
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="resultValue">
							<xsl:choose>
								<xsl:when test="OBX.2 = 'NM'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EQ', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'SN'">
									<tr>
										<th>OBX-5</th>
										<th>Observation Value</th>
										<th/>
										<th/>
										<th/>
									</tr>
									<xsl:copy-of select="util:ID-text-format('OBX-5.1', 'Comparator', 'S-EX', OBX.5/OBX.5.1, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.2', 'Num1', 'S-EQ', OBX.5/OBX.5.2, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.3', 'Separator/Suffix', 'S-EX', OBX.5/OBX.5.3, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.4', 'Num2', 'S-EQ', OBX.5/OBX.5.4, '20px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'FT'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EX', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'ST'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EX', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'TX'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EX', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'DT'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EQ', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'TS'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EQ', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'TM'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EQ', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'CWE'">
									<tr>
										<th>OBX-5</th>
										<th>Observation Value</th>
										<th/>
										<th/>
										<th/>
									</tr>
									<xsl:copy-of select="util:ID-text-format('OBX-5.1', 'Identifier', 'S-TR-R', OBX.5/OBX.5.1, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.2', 'Text', 'S-EX-A', OBX.5/OBX.5.2, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.3', 'Name of the Coding System', 'S-RC', OBX.5/OBX.5.3, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.4', 'Alternate Identifier', 'S-TR-R', OBX.5/OBX.5.4, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.5', 'Alternate Text', 'S-EX-A', OBX.5/OBX.5.5, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.6', 'Name of Alternate Coding System', 'S-RC', OBX.5/OBX.5.6, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.9', 'Original Text', 'S-EX', OBX.5/OBX.5.9, '20px', 'normal')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						--><!--xsl:if
                    test="($messageID = 'LRI_4.1_2.1-GU_FRU') or ($messageID = 'LRI_4.1_3.1-GU_FRU') or ($messageID = 'LRI_4.2_2.1-GU_FRN') or ($messageID = 'LRI_4.2_3.1-GU_FRN')"--><!--
--><!--						<xsl:if test="util:isParentChild_CS_TestCase($messageID) = true()">
							<xsl:choose>
								<xsl:when test="position() &lt; 3">
									<h4 align="center">PARENT - <xsl:value-of select="OBX.1"/>
									</h4>
								</xsl:when>
								<xsl:when test="position() &gt; 2">
									<h4 align="center">CHILD - <xsl:value-of select="OBX.1"/>
									</h4>
								</xsl:when>
							</xsl:choose>
						</xsl:if>--><!--
--><!--						<xsl:if test="util:isParentChild_Hepatitis_TestCase($messageID) = true()">
							<xsl:variable name="obr" select="../../OBR"/>
							<xsl:if test="fn:exists($obr/OBR.26)">
								--><!-- this is a CHILD OBX because it is under a CHILD OBR --><!--
								<h4 align="center">CHILD INFORMATION</h4>
								<xsl:call-template name="orderInfocontd-IV">
									<xsl:with-param name="obrSegment" select="$obr"/>
									<xsl:with-param name="er7XMLMessage" select="$er7XMLMessage"/>
									<xsl:with-param name="messageID" select="$messageID"/>
								</xsl:call-template>
								<h4 align="center">CHILD - <xsl:value-of select="OBX.1"/>
								</h4>
							</xsl:if>
						</xsl:if>--><!--
						<table id="identifierInformation">
							<xsl:call-template name="headerforIV">
								<xsl:with-param name="title">Result Information - Incorporate Verification</xsl:with-param>
							</xsl:call-template>
							<tbody>
								<tr>
									<th>OBX-3</th>
									<th>Observation Identifier (Note 1)</th>
									<th/>
									<th/>
									<th/>
								</tr>
								<xsl:copy-of select="util:ID-text-format('OBX-3.1', 'Identifier', 'S-TR-R', OBX.3/OBX.3.1, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.2', 'Text', 'S-EX-A', OBX.3/OBX.3.2, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.3', 'Name of the Coding System', 'S-RC', OBX.3/OBX.3.3, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.4', 'Alternate Identifier', 'S-TR-R', OBX.3/OBX.3.4, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.5', 'Alternate Text', 'S-EX-A', OBX.3/OBX.3.5, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.6', 'Name of Alternate Coding System', 'S-RC', OBX.3/OBX.3.6, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.9', 'Original Text', 'S-EX', OBX.3/OBX.3.9, '20px', 'normal')"/>
								<xsl:copy-of select="$resultValue"/>
								<tr>
									<th>OBX-6</th>
									<th>Units (Note 2)</th>
									<th/>
									<th/>
									<th/>
								</tr>
								<xsl:copy-of select="util:ID-text-format('OBX-6.1', 'Identifier', 'S-TR-R', OBX.6/OBX.6.1, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.2', 'Text', 'S-TR-R', OBX.6/OBX.6.2, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.3', 'Name of the Coding System', 'S-RC', OBX.6/OBX.6.3, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.4', 'Alternate Identifier', 'S-TR-R', OBX.6/OBX.6.4, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.5', 'Alternate Text', 'S-TR-R', OBX.6/OBX.6.5, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.6', 'Name of Alternate Coding System', 'S-RC', OBX.6/OBX.6.6, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.9', 'Original Text', 'S-EX', OBX.6/OBX.6.9, '20px', 'normal')"/>
								<tr>
									<th>OBX-7</th>
									<th>Reference Range</th>
									<td>S-EX</td>
									<xsl:copy-of select="util:formatData(OBX.7, 'normal')"/>
									<xsl:call-template name="commentTemplate"/>
								</tr>
								<tr>
									<th>OBX-8</th>
									<th>Abnormal Flags</th>
									<td>S-TR-R</td>
									<xsl:copy-of select="util:formatData(OBX.8, 'normal')"/>
									<xsl:call-template name="commentTemplate"/>
								</tr>
								<tr>
									<th>OBX-11</th>
									<th>Observation Result Status</th>
									<td>S-TR-R</td>
									<xsl:copy-of select="util:formatData(OBX.11, 'normal')"/>
									<xsl:call-template name="commentTemplate"/>
								</tr>
								<tr>
									<th>OBX-14</th>
									<th>Date/Time of the Observation</th>
									<th/>
									<th/>
									<th/>
								</tr>
								<xsl:copy-of select="util:ID-text-format('OBX-14.1', 'Time', 'S-EQ', util:formatDateTime(OBX.14/OBX.14.1), '20px', 'normal')"/>
								<tr>
									<th>OBX-19</th>
									<th>Date/Time of the Analysis</th>
									<th/>
									<th/>
									<th/>
								</tr>
								<xsl:copy-of select="util:ID-text-format('OBX-19.1', 'Time', 'S-EQ', util:formatDateTime(OBX.19/OBX.19.1), '20px', 'normal')"/>
								<tr>
									<td colspan="5">
										<b>Note 1</b> - Store the <u>Identifier</u> and the <u>Text</u> for
                                each populated triplet using the S-EX-A, S-TR-R, or S-EX store
                                requirement as indicated. If <u>Original Text</u> field is
                                populated, MUST store the exact data received.</td>
								</tr>
								<tr>
									<td colspan="5">
										<b>Note 2</b> - If both UOM triplets are populated, receiver may
                                choose to store the data received in either triplet; translations
                                must result in equivalent UOM that do not require a change in the
                                numeric result. </td>
								</tr>
							</tbody>
						</table>
						<xsl:if test="exists(following-sibling::NTE)">
							<table id="note">
								<xsl:call-template name="headerforIV">
									<xsl:with-param name="title">Note - Incorporate Verification</xsl:with-param>
								</xsl:call-template>
								<tbody>
									<xsl:for-each select="following-sibling::NTE">
										<xsl:copy-of select="util:ID-text-format('NTE-3', 'Note', 'S-EX', util:parseText(NTE.3), '0px', 'normal')"/>
									</xsl:for-each>
								</tbody>
							</table>
						</xsl:if>
						<br/>
						<xsl:if test="util:isParentChild_CS_TestCase($messageID) = true() and count(../following-sibling::ORU_R01.PATIENT_RESULT.ORDER_OBSERVATION.OBSERVATION) &gt; 0  and name(../preceding-sibling::*[1]) = 'OBR'">
							<xsl:call-template name="orderInfocontd_child-IV-2">
								<xsl:with-param name="obrSegment" select="../preceding-sibling::*[1]"/>
								<xsl:with-param name="er7XMLMessage" select="$er7XMLMessage"/>
								<xsl:with-param name="messageID" select="$messageID"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</fieldset>
	</xsl:template>-->
	
	<xsl:template name="resultInfo-Generic-IV">
		<xsl:param name="observationGroups"/>
		<fieldset id="ResultInfo-IV">
			<xsl:for-each select="$observationGroups/OBX">
						<xsl:variable name="OBX_5">
							<xsl:choose>
								<xsl:when test="OBX.2 = 'NM'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EQ', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'SN'">
									<tr>
										<th>OBX-5</th>
										<th>Observation Value</th>
										<th/>
										<th/>
										<th/>
									</tr>
									<xsl:copy-of select="util:ID-text-format('OBX-5.1', 'Comparator', 'S-EX', OBX.5/OBX.5.1, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.2', 'Num1', 'S-EQ', OBX.5/OBX.5.2, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.3', 'Separator/Suffix', 'S-EX', OBX.5/OBX.5.3, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.4', 'Num2', 'S-EQ', OBX.5/OBX.5.4, '20px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'FT'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EX', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'ST'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EX', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'TX'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EX', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'DT'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EQ', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'TS'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EQ', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'TM'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'S-EQ', OBX.5, '0px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'CWE'">
									<tr>
										<th>OBX-5</th>
										<th>Observation Value</th>
										<th/>
										<th/>
										<th/>
									</tr>
									<xsl:copy-of select="util:ID-text-format('OBX-5.1', 'Identifier', 'S-TR-R', OBX.5/OBX.5.1, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.2', 'Text', 'S-EX-A', OBX.5/OBX.5.2, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.3', 'Name of the Coding System', 'S-RC', OBX.5/OBX.5.3, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.4', 'Alternate Identifier', 'S-TR-R', OBX.5/OBX.5.4, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.5', 'Alternate Text', 'S-EX-A', OBX.5/OBX.5.5, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.6', 'Name of Alternate Coding System', 'S-RC', OBX.5/OBX.5.6, '20px', 'normal')"/>
									<xsl:copy-of select="util:ID-text-format('OBX-5.9', 'Original Text', 'S-EX', OBX.5/OBX.5.9, '20px', 'normal')"/>
								</xsl:when>
								<xsl:when test="OBX.2 = 'ED'">
									<xsl:copy-of select="util:ID-text-format('OBX-5', 'Observation Value', 'PDF is stored', '', '0px', 'normal')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>

						<table id="identifierInformation">
							<xsl:call-template name="headerforIV">
								<xsl:with-param name="title">Result Information - Incorporate Verification</xsl:with-param>
							</xsl:call-template>
							<tbody>
								<tr>
									<th>OBX-3</th>
									<th>Observation Identifier (Note 1)</th>
									<th/>
									<th/>
									<th/>
								</tr>
								<xsl:copy-of select="util:ID-text-format('OBX-3.1', 'Identifier', 'S-TR-R', OBX.3/OBX.3.1, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.2', 'Text', 'S-EX-A', OBX.3/OBX.3.2, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.3', 'Name of the Coding System', 'S-RC', OBX.3/OBX.3.3, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.4', 'Alternate Identifier', 'S-TR-R', OBX.3/OBX.3.4, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.5', 'Alternate Text', 'S-EX-A', OBX.3/OBX.3.5, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.6', 'Name of Alternate Coding System', 'S-RC', OBX.3/OBX.3.6, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-3.9', 'Original Text', 'S-EX', OBX.3/OBX.3.9, '20px', 'normal')"/>
								
								<xsl:copy-of select="$OBX_5"/>
								<tr>
									<th>OBX-6</th>
									<th>Units (Note 2)</th>
									<th/>
									<th/>
									<th/>
								</tr>
								<xsl:copy-of select="util:ID-text-format('OBX-6.1', 'Identifier', 'S-TR-R', OBX.6/OBX.6.1, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.2', 'Text', 'S-TR-R', OBX.6/OBX.6.2, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.3', 'Name of the Coding System', 'S-RC', OBX.6/OBX.6.3, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.4', 'Alternate Identifier', 'S-TR-R', OBX.6/OBX.6.4, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.5', 'Alternate Text', 'S-TR-R', OBX.6/OBX.6.5, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.6', 'Name of Alternate Coding System', 'S-RC', OBX.6/OBX.6.6, '20px', 'normal')"/>
								<xsl:copy-of select="util:ID-text-format('OBX-6.9', 'Original Text', 'S-EX', OBX.6/OBX.6.9, '20px', 'normal')"/>
								<tr>
									<th>OBX-7</th>
									<th>Reference Range</th>
									<td>S-EX</td>
									<xsl:copy-of select="util:formatData(OBX.7, 'normal')"/>
									<xsl:call-template name="commentTemplate"/>
								</tr>
								<tr>
									<th>OBX-8</th>
									<th>Abnormal Flags</th>
									<td>S-TR-R</td>
									<xsl:copy-of select="util:formatData(OBX.8, 'normal')"/>
									<xsl:call-template name="commentTemplate"/>
								</tr>
								<tr>
									<th>OBX-11</th>
									<th>Observation Result Status</th>
									<td>S-TR-R</td>
									<xsl:copy-of select="util:formatData(OBX.11, 'normal')"/>
									<xsl:call-template name="commentTemplate"/>
								</tr>
								<tr>
									<th>OBX-14</th>
									<th>Date/Time of the Observation</th>
									<th/>
									<th/>
									<th/>
								</tr>
								<xsl:copy-of select="util:ID-text-format('OBX-14.1', 'Time', 'S-EQ', util:formatDateTime(OBX.14/OBX.14.1), '20px', 'normal')"/>
								<tr>
									<th>OBX-19</th>
									<th>Date/Time of the Analysis</th>
									<th/>
									<th/>
									<th/>
								</tr>
								<xsl:copy-of select="util:ID-text-format('OBX-19.1', 'Time', 'S-EQ', util:formatDateTime(OBX.19/OBX.19.1), '20px', 'normal')"/>
								<tr>
									<td colspan="5">
										<b>Note 1</b> - Store the <u>Identifier</u> and the <u>Text</u> for
                                each populated triplet using the S-EX-A, S-TR-R, or S-EX store
                                requirement as indicated. If <u>Original Text</u> field is
                                populated, MUST store the exact data received.</td>
								</tr>
								<tr>
									<td colspan="5">
										<b>Note 2</b> - If both UOM triplets are populated, receiver may
                                choose to store the data received in either triplet; translations
                                must result in equivalent UOM that do not require a change in the
                                numeric result. </td>
								</tr>
							</tbody>
						</table>
						<xsl:if test="exists(following-sibling::NTE)">
							<table id="note">
								<xsl:call-template name="headerforIV">
									<xsl:with-param name="title">Note - Incorporate Verification</xsl:with-param>
								</xsl:call-template>
								<tbody>
									<xsl:for-each select="following-sibling::NTE">
										<xsl:copy-of select="util:ID-text-format('NTE-3', 'Note', 'S-EX', util:parseText(NTE.3), '0px', 'normal')"/>
									</xsl:for-each>
								</tbody>
							</table>
						</xsl:if>
						<br/>
			</xsl:for-each>
		</fieldset>
	</xsl:template>	
	
	<xsl:template name="specimentInfo-IV">
		<xsl:param name="spmSegment"/>
		<fieldset id="SpecimenInfo-IV">
			<xsl:for-each select="$spmSegment">
				<table id="specimenInformation">
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">Specimen Information - Incorporate Verification</xsl:with-param>
					</xsl:call-template>
					<tbody>
						<tr>
							<th>SPM-4</th>
							<th>Specimen Type (Note 1)</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('SPM-4.1', 'Identifier', 'S-TR-R', $spmSegment/SPM.4/SPM.4.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('SPM-4.2', 'Text', 'S-EX-A', $spmSegment/SPM.4/SPM.4.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('SPM-4.3', 'Name of the Coding System', 'S-RC', $spmSegment/SPM.4/SPM.4.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('SPM-4.4', 'Alternate Identifier', 'S-TR-R', $spmSegment/SPM.4/SPM.4.4, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('SPM-4.5', 'Alternate Text', 'S-EX-A', $spmSegment/SPM.4/SPM.4.5, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('SPM-4.6', 'Name of Alternate Coding System', 'S-RC', $spmSegment/SPM.4/SPM.4.6, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('SPM-4.9', 'Original Text', 'S-EX', $spmSegment/SPM.4/SPM.4.9, '20px', 'normal')"/>
						<xsl:if test="exists(SPM.21)">
							<tr>
								<th>SPM-21</th>
								<th>Specimen Reject Reason (Note 1)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('SPM-21.1', 'Identifier', 'S-TR-R', $spmSegment/SPM.21/SPM.21.1, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-21.2', 'Text', 'S-EX-A', $spmSegment/SPM.21/SPM.21.2, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-21.3', 'Name of the Coding System', 'S-RC', $spmSegment/SPM.21/SPM.21.3, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-21.4', 'Alternate Identifier', 'S-TR-R', $spmSegment/SPM.21/SPM.21.4, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-21.5', 'Alternate Text', 'S-EX-A', $spmSegment/SPM.21/SPM.21.5, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-21.6', 'Name of Alternate Coding System', 'S-RC', $spmSegment/SPM.21/SPM.21.6, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-21.9', 'Original Text', 'S-EX', $spmSegment/SPM.21/SPM.21.9, '20px', 'normal')"/>
						</xsl:if>
						<xsl:if test="exists(SPM.24)">
							<tr>
								<th>SPM-24</th>
								<th>Specimen Condition (Note 1)</th>
								<th/>
								<th/>
								<th/>
							</tr>
							<xsl:copy-of select="util:ID-text-format('SPM-24.1', 'Identifier', 'S-TR-R', $spmSegment/SPM.24/SPM.24.1, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-24.2', 'Text', 'S-EX-A', $spmSegment/SPM.24/SPM.24.2, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-24.3', 'Name of the Coding System', 'S-RC', $spmSegment/SPM.24/SPM.24.3, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-24.4', 'Alternate Identifier', 'S-TR-R', $spmSegment/SPM.24/SPM.24.4, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-24.5', 'Alternate Text', 'S-EX-A', $spmSegment/SPM.24/SPM.24.5, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-24.6', 'Name of Alternate Coding System', 'S-RC', $spmSegment/SPM.24/SPM.24.6, '20px', 'normal')"/>
							<xsl:copy-of select="util:ID-text-format('SPM-24.9', 'Original Text', 'S-EX', $spmSegment/SPM.24/SPM.24.9, '20px', 'normal')"/>
						</xsl:if>
						<tr>
							<td colspan="5">
								<b>Note 1</b> - The HIT must store the <u>Identifier</u> and the
                                    <u>Text</u> for each populated triplet using the S-EX-A, S-TR-R,
                                or S-EX store requirement as indicated. If <u>Original Text</u>
                                field is populated, MUST store the exact data received. </td>
						</tr>
					</tbody>
				</table>
			</xsl:for-each>
		</fieldset>
	</xsl:template>
	<xsl:template name="note-IV">
		<xsl:param name="nteSegment"/>
		<xsl:if test="exists($nteSegment)">
			<fieldset id="Note-IV">
				<table id="note">
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">Note- Incorporate Verification</xsl:with-param>
					</xsl:call-template>
					<tbody>
						<xsl:for-each select="$nteSegment">
							<xsl:copy-of select="util:ID-text-format('NTE-3', 'Note', 'S-EX', util:parseText(NTE.3), '0px', 'normal')"/>
						</xsl:for-each>
					</tbody>
				</table>
			</fieldset>
		</xsl:if>
	</xsl:template>
	<xsl:template name="time-IV">
		<xsl:param name="timeSegment"/>
		<xsl:if test="exists($timeSegment)">
			<fieldset id="Time-IV">
				<table id="note">
					<xsl:call-template name="headerforIV">
						<xsl:with-param name="title">Timing/Quantity Information- Incorporate Verification</xsl:with-param>
					</xsl:call-template>
					<tbody>
						<tr>
							<th>TQ1-7</th>
							<th>Start Date/Time</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('TQ1-7.1', 'Time', 'S-EQ', util:formatDateTime($timeSegment/TQ1.7/TQ1.7.1), '20px', 'normal')"/>
						<tr>
							<th>TQ1-8</th>
							<th>End Date/Time</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('TQ1-8.1', 'Time', 'S-EQ', util:formatDateTime($timeSegment/TQ1.8/TQ1.8.1), '20px', 'normal')"/>
						
						<tr>
							<th>TQ1-9</th>
							<th>Priority</th>
							<th/>
							<th/>
							<th/>
						</tr>
						<xsl:copy-of select="util:ID-text-format('TQ1-9.1', 'Identifier', 'S-TR-R', $timeSegment/TQ1.9/TQ1.9.1, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('TQ1-9.2', 'Text', 'S-EX-A', $timeSegment/TQ1.9/TQ1.9.2, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('TQ1-9.3', 'Name of Coding System', 'S-RC', $timeSegment/TQ1.9/TQ1.9.3, '20px', 'normal')"/>
						<xsl:copy-of select="util:ID-text-format('TQ1-9.9', 'Original Text', 'S-EX', $timeSegment/TQ1.9/TQ1.9.9, '20px', 'normal')"/>

					</tbody>
				</table>
			</fieldset>
		</xsl:if>
	</xsl:template>
	<xsl:template name="instructions">
		<fieldset>
			<h3 align="center">Instructions to Testers for Verification of Store Requirements</h3>
			<p>
				<i>Note: The HIT Module being tested is always allowed to incorporate/store the
                    exact data received in the LRI message even if a given Store Requirement does
                    not explicitly state that the HIT Module is permitted to do so. </i>
			</p>
			<table>
				<thead>
					<tr>
						<td style="text-align:center">
							<b>Store Requirement</b>
						</td>
						<td style="text-align:center">
							<b>Definition</b>
						</td>
						<td style="text-align:center">
							<b> Instructions for Verification of Requirement During Conformance
                                Testing</b>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>S-EX</td>
						<td>Store Exact</td>
						<td>
							<p>The HIT Module being tested must be designed to incorporate/store
                                only the exact data received in the LRI message.</p>
							<ul>
								<li> Tester must verify that the HIT Module being tested
                                    incorporates/stores <b>in the patient&apos;s laboratory result
                                        record only the exact data received</b> in the LRI message,
                                    and that the HIT Module does not just store an equivalent of
                                    that exact data or just a pointer to the exact data. </li>
							</ul>
						</td>
					</tr>
					<!--  <tr>
                        <td>S-EX-TR</td>
                        <td>Store exact; translation allowed, and if translated store
                            translation</td>
                        <td>
                            <p>The HIT Module being tested must be designed to incorporate/store the
                                exact data received in the LRI message AND may also be designed to
                                transform the exact data received in the LRI message to an
                                equivalent value and then incorporate/store the equivalent value in
                                addition to the exact value.</p>
                            <ul>
                                <li>Tester must verify that the HIT Module being tested
                                    incorporates/stores <b>in the patient&apos;s laboratory result
                                        record the exact data received</b> in the LRI message; </li>
                                <li>Tester also must verify that the HIT Module incorporates/stores
                                        <b>the equivalent value in the patient&apos;s laboratory
                                        result record</b> if the system being tested is designed to
                                    transform the exact data received in the LRI message to an
                                    equivalent value and then incorporate/store the equivalent value
                                    in addition to the exact value. </li>
                            </ul>
                        </td>

                    </tr>-->
					<tr>
						<td>S-EX-A</td>
						<td>Store exact by association</td>
						<td>
							<p>The HIT Module being tested must be designed (1) to incorporate/store the
                                exact data received in the LRI message OR (2) to use a pointer to a
                                location (e.g., file/table in or accessible to the HIT Module) where
                                the exact data can be obtained. </p>
							<ul>
								<li>Tester must verify that the HIT Module being tested
                                    incorporates/stores <b>in the patient&apos;s laboratory result
                                        record the exact data received</b> in the LRI message OR
                                    that the HIT Module incorporates/stores <b>in the patient&apos;s
                                        laboratory result record a pointer to the exact data
                                        received</b> in the LRI message. </li>
							</ul>
							<p>Example: Placer Number; the HIT-originated Placer Number received in
                                the LRI message may be incorporated/stored using a pointer rather
                                than being stored redundantly in the patient&apos;s lab result
                                record.</p>
						</td>
					</tr>
					<tr>
						<td> S-EQ </td>
						<td>Store equivalent</td>
						<td>
							<p>The HIT Module being tested must be designed to transform the exact
                                data received in the LRI message to an equivalent format and then
                                incorporate/store the equivalent format.</p>
							<ul>
								<li>Tester must verify that the HIT Module being tested transforms
                                    the exact data received in the LRI message to an equivalent
                                    format and incorporates/stores <b>the equivalent format in the
                                        patient&apos;s laboratory result record.</b>
								</li>
							</ul>
						</td>
					</tr>
					<tr>
						<td>S-TR-R</td>
						<td> Translate and store translation (exact value can be re-created from
                            translation any time) </td>
						<td>
							<p>The HIT Module being tested must be designed to transform the exact
                                data received in the LRI message to an equivalent value and then
                                incorporate/store the equivalent value. </p>
							<ul>
								<li>Tester must verify that the HIT Module being tested
                                    incorporates/stores <b>in the patient&apos;s laboratory result
                                        record the equivalent value.</b>
								</li>
								<li>Tester must also verify that the HIT Module is able to re-create
                                    from this equivalent value the exact data received in the LRI
                                    message.</li>
							</ul>
						</td>
					</tr>
					<tr>
						<td>S-RC</td>
						<td>Process and re-create</td>
						<td>
							<p>The HIT Module being tested must be designed to process and
                                incorporate/store in an &quot;abstract-able manner&quot; (e.g.,
                                using the HIT Module&apos;s data model) the exact data received in
                                the LRI message and to re-create the exact data (e.g., from the HIT
                                Module&apos;s data model). </p>
							<ul>
								<li>Tester must verify that the HIT Module being tested processes
                                    and abstractly incorporates/stores<b> in the patient&apos;s
                                        laboratory result record the exact data received</b> in the
                                    LRI message. </li>
								<li> Tester also must verify that the HIT Module is able to
                                    re-create the exact data received in the LRI message by
                                    abstracting the data (e.g., from the HIT Module&apos;s data
                                    model). </li>
							</ul>
							<p>Example: Identifier Type Code; the HIT Module uses a separate
                                file/table to store Social Security Numbers versus internal Medical
                                Record Numbers, and does not need to retain the Identifier Type Code
                            </p>
						</td>
					</tr>
					<!--tr>
                        <td>S-MA</td>
                        <td>Made available for specific processing</td>
                        <td>
                            <p>The HIT Module being tested must be designed to use the exact data
                                received in the LRI message to accomplish certain tasks defined by
                                the Incorporate Lab Results Use Case (e.g., performing a patient
                                match), but need not be designed to incorporate/store the data once
                                it has been used for the specified purpose. </p>
                            <ul>
                                <li>Tester must verify that the HIT Module being tested uses the
                                    exact data received in the LRI message to accomplish the
                                    incorporation/storing of the lab result information in the
                                    patient&apos;s laboratory result record.</li>
                                <li>The HIT Module may persist the data used for this purpose, but
                                    Tester is not required to verify that the HIT Module is able to
                                    incorporate/store the exact data that are used for this
                                    purpose</li>
                            </ul>
                        </td>
                    </tr-->
				</tbody>
			</table>
		</fieldset>
	</xsl:template>
	<xsl:template name="printNode">
		<xsl:param name="node"/>
		<xsl:message select="name(.)"/>
		<xsl:for-each select="child::*">
			<xsl:call-template name="printNode">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
