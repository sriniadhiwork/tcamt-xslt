<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:util="http://hl7.nist.gov/juror-doc/util" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xs util">
	<xsl:output method="html" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="RXCHG" select="'RXCHG'"/>
	<xsl:variable name="CHGRX" select="'CHGRX'"/>
	<xsl:variable name="REFREQ" select="'REFREQ'"/>
	<xsl:variable name="RXFILL" select="'RXFILL'"/>
	<xsl:variable name="RXHRES" select="'RXHRES'"/>
	<xsl:variable name="STATUS" select="'STATUS'"/>
	<xsl:variable name="CANRES" select="'CANRES'"/>
	<xsl:variable name="version" >
	<xsl:text>
	 Version 1.3
	 Release notes:
	 1.0 Days qualifier and Days supply format qualifier show only if their fields are non-emptyp; parseddate for med history shows in correct format.
	 1.1 PVD.2.1.1/2.2.1 accept PVD.2.1/2.2 variants; same with DRU.4.1.2/DRU.4.2; also LD conditionally outputting qualifier
	 1.2 Textual changes on the notes below the first table and including a * based on a condition
	 1.3 Show full zipcode.
	 1.4: Using DRU.1.2 to specify alternate codes for  DRU.7.2 using a icd-10 table
     </xsl:text>
    </xsl:variable>
	
	<xsl:function name="util:formatData">
		<xsl:param name="content"/>
		<xsl:param name="colspan"/>
		<xsl:message><xsl:value-of select="$content"/> </xsl:message>
		<xsl:variable name="formattedData">
			<xsl:choose>
				<xsl:when test="string-length(normalize-space($content)) = 0">
					<td colspan="{$colspan}" class="noData"/>
				</xsl:when>
				<xsl:otherwise>
					<td colspan="{$colspan}">
						<xsl:value-of select="$content"/>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:copy-of select="$formattedData"/>
	</xsl:function>
	
	
	<xsl:function name="util:parseDate-mmddccyy">
         <xsl:param name="elementDataIn"/>
      <xsl:variable name="elementData" select="concat($elementDataIn, '                ')"/>
      <xsl:if test="string-length(normalize-space($elementData)) > 0">
          <xsl:variable name="year" select="substring($elementData, 1, 4)"/>
          <xsl:variable name="month" select="concat(substring($elementData, 5, 2), '/')"/>
          <xsl:variable name="day" select="concat(substring($elementData, 7, 2), '/')"/>
          <xsl:value-of select="concat($month, $day, $year)"/>

      </xsl:if>
  </xsl:function>
	
	
	<xsl:function name="util:parseDate-ccyymmdd">
		<xsl:param name="elementDataIn"/>
		<xsl:variable name="elementData" select="concat($elementDataIn, '                ')"/>
		<xsl:if test="string-length(normalize-space($elementData)) > 0">
			<xsl:variable name="year" select="concat(substring($elementData, 1, 4), '/')"/>
			<xsl:variable name="month" select="concat(substring($elementData, 5, 2), '/')"/>
			<xsl:variable name="day" select="substring($elementData, 7, 2)"/>
			<xsl:value-of select="concat($year, $month, $day)"/>
		</xsl:if>
	</xsl:function>
	
	
	<xsl:function name="util:dateFormat">
		<xsl:param name="data"/>
		<xsl:variable name="Date" select="concat($data, ' ')"/>
		<xsl:if test="string-length(normalize-space($Date)) > 0">
			<xsl:variable name="year" select="concat(substring($Date, 1, 4), '/')"/>
			<xsl:variable name="month" select="concat(substring($Date, 5, 2), '/')"/>
			<xsl:variable name="day" select="substring($Date, 7, 2)"/>
			<xsl:value-of select="concat($year, $month, $day)"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:fillStatus">
		<xsl:param name="fill"/>
		<xsl:choose>
			<xsl:when test="$fill = 'AJ'">
				<xsl:value-of select="'AJ-Patient has picked up partial fill of prescription'"/>
			</xsl:when>
			<xsl:when test="$fill = 'AK'">
				<xsl:value-of select="'AK-Patient has not picked up prescription'"/>
			</xsl:when>
			<xsl:when test="$fill = 'AH'">
				<xsl:value-of select="'AH-Patient has picked up prescription'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$fill"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:chngRequestType">
		<xsl:param name="requestType"/>
		<xsl:choose>
			<xsl:when test="$requestType = 'G'">
				<xsl:value-of select="'G - Generic Substitution'"/>
			</xsl:when>
			<xsl:when test="$requestType = 'T'">
				<xsl:value-of select="'T - Therapeutic Interchange/Substitution'"/>
			</xsl:when>
			<xsl:when test="$requestType = 'P'">
				<xsl:value-of select="'P - Prior Authorization Required'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$requestType"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:response">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$code = 'A'">
				<xsl:value-of select="'A - Approved'"/>
			</xsl:when>
			<xsl:when test="$code = 'D'">
				<xsl:value-of select="'D - Denied'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:gender">
		<xsl:param name="code"/>
		<xsl:choose>
			<xsl:when test="$code = 'F'">
				<xsl:value-of select="'Female'"/>
			</xsl:when>
			<xsl:when test="$code = 'M'">
				<xsl:value-of select="'Male'"/>
			</xsl:when>
			<xsl:when test="$code = 'U'">
				<xsl:value-of select="'Unknown/undifferentiated'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	<xsl:function name="util:format-tel">
		<xsl:param name="phonenumberin"/>
		<!-- pad it so that length problems don't happen -->
		<xsl:variable name="phonenumber" select="concat($phonenumberin, '                ')"/>
		<xsl:if test="$phonenumber != ''">
			<xsl:variable name="areaCode" select="concat('(', substring($phonenumber, 1, 3), ')')"/>
			<xsl:variable name="localCode" select="concat(substring($phonenumber, 4, 3), '-')"/>
			<xsl:variable name="idCode" select="substring($phonenumber, 7)"/>
			<xsl:value-of select="concat($areaCode, $localCode, $idCode)"/>
		</xsl:if>
	</xsl:function>
	<xsl:function name="util:codeDescription">
		<xsl:param name="value"/>
		<xsl:param name="tableName"/>
		<xsl:choose>
			<xsl:when test="$CodeTables/Tables/TableDefinition[@Id = $tableName]/t[@c = $value]">
				<xsl:value-of select="concat($value, ' ', '-', ' ', '(', $CodeTables/Tables/TableDefinition[@Id = $tableName]/t[@c = $value]/@d, ')')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>

	<xsl:function name="util:codeValues">
		<xsl:param name="value"/>
		<xsl:param name="tableName"/>
		<xsl:choose>
			<xsl:when test="$CodeTables/Tables/TableDefinition[@Id = $tableName]/t[@c = $value]">
				<xsl:value-of select="$CodeTables/Tables/TableDefinition[@Id = $tableName]/t[@c = $value]/@d"/>
			</xsl:when>
		</xsl:choose>
	</xsl:function>
	
	 
	<xsl:function name="util:ICD-10-codes">
		<xsl:param name="value"/>
		<xsl:param name="drugname"/>
 		<xsl:variable name="codes" select="util:codeValues(normalize-space($drugname), 'icd-10-drugs')" />

		<xsl:variable name="output">
		<xsl:choose>
			<xsl:when test="normalize-space($codes) = ''">
			   <xsl:value-of select="util:codeDescription($value, 'ICD')" /> 
            </xsl:when>
            <xsl:otherwise>
			  <xsl:for-each select="tokenize($codes,' ')">
			   <xsl:value-of select="util:codeDescription(., 'ICD')" />   <xsl:if test="not(position() eq last())"><xsl:text>, </xsl:text></xsl:if>
			  </xsl:for-each>
	        </xsl:otherwise>
		</xsl:choose>
		</xsl:variable>
		
		<xsl:value-of select="$output" />
	</xsl:function>
	
	
	<xsl:variable name="CodeTables">
		<Tables xmlns="">
			<TableDefinition Name="ICD-10" Id="ICD" Segment="DRU">
				<t c="I10" d="Essential (primary) hypertension"/>
				<t c="I509" d="Heart failure, unspecified"/>
				<t c="I501" d="Left ventricular failure"/>
				<t c="I5022" d="Chronic systolic (congestive) heart failure"/>
				<t c="I5032" d="Chronic diastolic (congestive) heart failure"/>
				<t c="I5042" d="Chronic combined systolic (congestive) and diastolic (congestive) heart failure"/>
				<t c="N401" d="Enlarged prostate with lower urinary tract symptoms"/>
				<t c="N403" d="Nodular prostate with lower urinary tract symptoms"/>
				<t c="I481" d="Persistent atrial fibrillation"/>
				<t c="I4891" d="Unspecified atrial fibrillation"/>
				<t c="J449" d="Chronic obstructive pulmonary disease, unspecified"/>
				<t c="E1169" d="Type 2 diabetes mellitus with other specified complication"/>
				<t c="E785" d="Hyperlipidemia, unspecified"/>
				<t c="I201" d="Angina pectoris with documented spasm"/>
				<t c="E8881" d="Metabolic syndrome"/>
				<t c="J020" d="Streptococcal pharyngitis"/>
				<t c="J0300" d="Acute streptococcal tonsillitis, unspecified"/>
				<t c="J069" d="Acute upper respiratory infection, unspecified"/>
				<t c="N3001" d="Acute cystitis with hematuria"/>
				<t c="M545" d="Low back pain"/>
			</TableDefinition>


			<TableDefinition Name="DrugFormCode" Id="DrugFormCode" Segment="DRU">
				<t c="C42998" d="Tablet"/>
				<t c="C42927" d="Extended Release Tablet"/>
				<t c="C42960" d="Metered Aerosol"/>
				<t c="C25158" d="Capsule"/>
				<t c="C42975" d="Powder for Suspension"/>
				<t c="C42931" d="Film Coated Tablet"/>
				<t c="C42930" d="Film Coated Extended Release Tablet"/>
				<t c="C91180" d="Prefilled Syringe"/>
				<t c="C91163" d="Ophthalmic Solution"/>
				<t c="C42910" d="Effervescent Tablet"/>
				<t c="C91187" d="Topical Cream"/>
			</TableDefinition>
			<TableDefinition Name="DrugStrengthCode" Id="DrugStrengthCode" Segment="DRU">
				<t c="C28253" d="Milligram"/>
				<t c="C48512" d="Milliequivalent"/>
				<t c="C48152" d="Microgram"/>
				<t c="C91131" d="Milligram per Five Milliliters"/>
				<t c="C25613" d="Percentage"/>
				<t c="C64572" d="Microgram per Milliliter"/>
			</TableDefinition>
			<TableDefinition Name="QuantityUOM" Id="QuantityUOM" Segment="DRU">
				<t c="C48542" d="Tablet"/>
				<t c="C62413" d="Canister"/>
				<t c="C48480" d="Capsule"/>
				<t c="C28254" d="Milliliter"/>
				<t c="C48155" d="Gram"/>
			</TableDefinition>
			<TableDefinition Name="ItemDescription" Id="ItemDescription" Segment="DRU">
				<t c="P" d="Prescribed medication"/>
				<t c="D" d="Dispensed medication"/>
				<t c="R" d="Requested medication"/>
			</TableDefinition>
			<TableDefinition Name="RxNormCode" Id="RxNormCode" Segment="DRU">
				<t c="SBD" d="RxNorm Semantic Branded Drug"/>
				<t c="SCD" d="RxNorm Semantic Clinical Drug"/>
			</TableDefinition>
			<TableDefinition Name="CodeQuantityQualifier" Id="CodeQuantityQualifier" Segment="DRU">
				<t c="38" d="Original Quantity"/>
				<t c="40" d="Remaining Quantity"/>
				<t c="87" d="Quantity Received"/>
				<t c="QS" d="Quantity sufficient as determined by the dispensing pharmacy"/>
			</TableDefinition>
			<TableDefinition Name="Refills" Id="Refills" Segment="DRU">
				<t c="R" d="Number of refills authorized in a new prescription"/>
				<t c="PRN" d="Authorization to dispense refills as needed"/>
				<t c="A" d="Additional refills authorized in a refill response message"/>
				<t c="P" d="Number of refills requested by a pharmacy in a refill request message"/>
			</TableDefinition>
			<TableDefinition Name="Substitution" Id="Substitution" Segment="DRU">
				<t c="0" d="Substitution allowed by the prescriber"/>
				<t c="1" d="Substitution not allowed by the prescriber"/>
				<t c="2" d="Substitution Allowed-Patient Requested Product Dispensed"/>
				<t c="3" d="Substitution Allowed-Pharmacist Selected Product Dispensed"/>
				<t c="4" d="Substitution Allowed-Generic Drug Not in Stock"/>
				<t c="5" d="Substitution Allowed-Brand Drug Dispensed as a Generic"/>
				<t c="7" d="Substitution Not Allowed-Brand Drug Mandated by Law"/>
				<t c="8" d="Substitution Allowed-Generic Drug Not Available in Marketplace"/>
			</TableDefinition>
			<TableDefinition Name="PatientConsentIndicator" Id="PatientConsentIndicator" Segment="COO">
				<t c="Y" d="Patient gave consent for the information to be disclosed."/>
				<t c="N" d="Patient consent not given."/>
				<t c="P" d="Patient gave consent for prescriber to only receive the medication history this prescriber prescribed."/>
				<t c="X" d="Parental/Guardian gave consent for the information to be disclosed."/>
				<t c="Z" d="Parental/Guardian consent on behalf of a minor for prescriber to only receive the medication history this prescriber prescribed."/>
			</TableDefinition>
			<TableDefinition Name="DateQualifier" Id="DateQualifier" Segment="COO">
				<t c="07" d="Effective Date"/>
				<t c="36" d="Expiration Date"/>
			</TableDefinition>
			<TableDefinition Name="DateFormatQualifier" Id="DateFormatQualifier">
				<t c="102" d="CCYYMMDD"/>
			</TableDefinition>
			<TableDefinition Name="PayerIdNumber" Id="PayerIdNumber" Segment="COO">
				<t c="2U" d="Payer Identification Number"/>
			</TableDefinition>
			<TableDefinition Name="RepeatingSigs" Id="RepeatingSigs" Segment="SIG">
				<t c="AND" d="All must apply/must be used"/>
				<t c="THEN" d="See Siq Sequence Position for order of sequence of sigs"/>
				<t c="OR" d="Any can apply/can be used"/>
			</TableDefinition>
			<TableDefinition Name="SigFreeTextIndicator" Id="SigFreeTextIndicator" Segment="SIG">
				<t c="1" d="Capture what the doctor ordered"/>
				<t c="2" d="Reconstructed from structured Sig"/>
				<t c="3" d="Pure free text"/>
			</TableDefinition>
			<TableDefinition Name="DoseCompositeIndicator" Id="DoseCompositeIndicator" Segment="SIG">
				<t c="1" d="Specified - remaining fields populated"/>
				<t c="2" d="As needed - skip rest of Dose Segment"/>
				<t c="3" d="As directed - skip rest of Dose Segment"/>
				<t c="4" d="Unspecified - see free text"/>
			</TableDefinition>
			<TableDefinition Name="Version" Id="Version" Segment="SIG">
				<t c="1" d="SNOMED CT"/>
				<t c="2" d="FMT"/>
			</TableDefinition>
			<TableDefinition Name="MultiAdminTimingModifer" Id="MultiAdminTimingModifier" Segment="SIG">
				<t c="AND" d="All must apply/must be used"/>
				<t c="OR" d="Any can apply/can be used"/>
			</TableDefinition>

			<TableDefinition Name="icd-10-drugs" Id="icd-10-drugs" Segment="DRU">
				<t c="Cerdura 2 MG Oral Tablet" d="N401 N403"/>
				<t c="Amoxicillin 400 MG/5 ML Suspension" d="J020 J0300 J069" />
				<t c="Azithromycin 200 MG/5 ML Suspension" d="J020 J0300 J069" />
				<t c="Klor-Con 10 MEQ XL Oral Tablet" d="I509 I501 I5022 I5032 I5042" />
				<t c="Lanoxin 125 MCG Oral Tablet" d="I481 I4891 I501 I5022 I5032 I5042 I509" />
				<t c="Crestor 10 MG Oral Tablet" d="E785 E8881" />
				<t c="Simvastatin 10 MG Oral Tablet" d="E785 E8881" />
				<t c="Simvastatin 20 MG Oral Tablet" d="E785 E8881" />
				<t c="Lipitor 10 MG Oral Tablet" d="E785 E1169" />
			</TableDefinition>

		</Tables>
	</xsl:variable>
	<xsl:template name="commentTemplate">
		<td bgcolor="#F2F2F2">
			<!--    <div contentEditable="true"
                style="width: 100%; height: 100%; border: none; resize: none; max-width: 300px">
                <xsl:text disable-output-escaping="yes">&amp;</xsl:text>nbsp;</div> -->
			<textarea maxLength="100" rows="1" style="width: 100%; height: 100%; border: 1px; background: 1px  #F2F2F2; resize:vertical; overflow-y:hidden "> </textarea>
		</td>
	</xsl:template>
	<xsl:template name="jurorAppearance">
		<style type="text/css">
            @media screen{
            
                .jurordocument table thead tr th{
                    font-size:110%;
                    text-align:center;
                }
                .jurordocument table tbody tr th{
                    font-size:100%;
                }
                .jurordocument table tbody tr td{
                    font-size:110%;
                }
                .jurordocument .note{
                    font-size:100%;
                }
            }
            @media print{
                .jurordocument fieldset{
            
                    page-break-inside:avoid;
                }
                .jurordocument table{
                    float:none !important;
                    page-break-before:avoid;
                    overflow:visible !important;
                    position:relative;
            
                }
                .jurordocument table tr{
                    page-break-inside:avoid;
                }
                .jurordocument table thead tr th{
                    font-size:100%;
                    text-align:center;
                }
                .jurordocument table tbody tr th{
                    font-size:100%;
                }
                .jurordocument table tbody tr td{
                    font-size:100%;
                }
            
                .jurordocument h3{
                    font-size:medium;
                }
                .jurordocument .note{
                    font-size:100%;
                }
            
            
                .jurordocument * [type = checkbox]{
                    width:10px;
                    height:10px;
                    margin:2px;
                    padding:0px;
                    background:1px #ccc;
                }
            }
            
            .jurordocument * [type = text]{
                width:95%;
            
            }
            
            .jurordocument fieldset{
                width:95%;
                border:1px solid #446BEC;
            }
            
            .jurordocument .noData{
                background:#D2D2D2;
            }
            .jurordocument table{
                width:98%;
                border:1px groove;
                margin:0 auto;
                page-break-inside:avoid;
            }
            .jurordocument table tr{
                border:1px groove;
            }
            .jurordocument table th{
                border:1px groove black;
            }
            .jurordocument table td{
                border:1px groove black;
                empty-cells:show;
            }
            .jurordocument table thead{
                border:1px groove;
                background:#446BEC;
                text-align:center;
                color:white;
            }
            .jurordocument table[id = inspectionStatus] thead tr th:last-child{
                width:2%;
                color:black;
            }
            .jurordocument table[id = inspectionStatus] thead tr th:nth-last-child(2){
                width:2%;
                color:black;
            }
            .jurordocument table[id = inspectionStatus] thead tr th:nth-last-child(3){
                width:45%;
            }
            .jurordocument table tbody tr th{
                text-align:center;
                background:#C6DEFF;
            }
            .jurordocument table tbody tr td{
                text-align:left;
            }
            .jurordocument table tbody tr td [type = text]{
                text-align:left;
                margin-left:1%;
            }
            .jurordocument table caption{
                font-weight:bold;
                color:#0840F8;
            }</style>
		<script>
            function comment(){
            
            $("textarea").on("keyup",function (){
            var h=$(this);
            h.height(20).height(h[0].scrollHeight);
            });
            
            }
            if(typeof jQuery =='undefined') {
            var headTag = document.getElementsByTagName("head")[0];
            var jqTag = document.createElement('script');
            jqTag.type = 'text/javascript';
            jqTag.src = 'http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js';
            jqTag.onload = comment;
            headTag.appendChild(jqTag);
            }
            else {  
            $(document).ready(function (){
            
            comment();
            
            })
            
            }
        </script>
	</xsl:template>
	<xsl:template name="messageHeader">
		<xsl:param name="title"/>
		<xsl:param name="note"/>
		<div style="display:none">
		<xsl:value-of select="$version"/>
        </div>
		<table id="headerTable">
			<thead>
				<tr>
					<th colspan="2">
						<xsl:value-of select="$title"/>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>Test Case ID</th>
					<td> </td>
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
		<h3>DISPLAY VERIFICATION</h3>
		<fieldset>
			<xsl:copy-of select="$note"/>
		</fieldset>
		<br/>
	</xsl:template>
	<xsl:template name="patientInfo">
		<xsl:param name="pttSegment"/>
		<xsl:param name="pPhone"/>
		<xsl:param name="fName"/>
		<xsl:param name="mName"/>
		<xsl:param name="lName"/>
		<xsl:param name="dob"/>
		<xsl:param name="gender"/>
		<xsl:for-each select="$pttSegment">
			<table id="patientInformationDisplay">
				<thead>
					<tr>
						<th colspan="7">Patient Information</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="{$lName}">Last Name</th>
						<th style="{$mName}">Middle Name</th>
						<th style="{$fName}">First Name</th>
						<th style="{$dob}">DOB</th>
						<th style="{$gender}">Gender</th>
						<th style="{$pPhone}">Patient Phone</th>
						<th width="15%">Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(PTT.3/PTT.3.1, 0)"/>
						<xsl:copy-of select="util:formatData(PTT.3/PTT.3.3, 0)"/>
						<xsl:copy-of select="util:formatData(PTT.3/PTT.3.2, 0)"/>
						<xsl:copy-of select="util:formatData(util:parseDate-mmddccyy(PTT.2/PTT.2.1), 0)"/>
						<xsl:copy-of select="util:formatData(util:gender(PTT.4/PTT.4.1), 0)"/>
						<xsl:copy-of select="util:formatData(util:format-tel(PTT.7/PTT.7.1), 0)"/>
						<xsl:message>debugging</xsl:message>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<td colspan="7">When displayed in the EHR, these patient demographics data
                            may be derived from either the received eRx message or the EHR patient
                            record. When displaying demographics from the patient record, the EHR
                            must be able to demonstrate a linkage between the demographics in the
                            message and the patient record used for display to ensure that the
                            message was associated with the appropriate patient.</td>
					</tr>
				</tbody>
			</table>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="pharmacyInfo">
		<xsl:param name="pharmacy"/>
		<xsl:param name="pName"/>
		<xsl:param name="ncpdp"/>
		<xsl:param name="npi"/>
		<xsl:param name="address"/>
		<xsl:param name="phone"/>
		<xsl:if test="exists($pharmacy)">
			<table>
				<thead>
					<tr>
						<th colspan="6">Pharmacy Information</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="{$ncpdp}">NCPDP Number</th>
						<th style="{$npi}">NPI Number</th>
						<th style="{$pName}">Pharmacy Name</th>
						<th style="{$address}">Address</th>
						<th style="{$phone}">Phone</th>
						<th width="15%">Tester Comment</th>
					</tr>
					<tr>
						<!--- concat because only one of those will be there; when there is only one instance the 2.1 will be present; on multiple intances it will be 2.1.1 - this is a workaround -->
						<xsl:copy-of select="util:formatData(concat($pharmacy/PVD.2/PVD.2.1.1, $pharmacy/PVD.2/PVD.2.1), 0)"/>
						<xsl:copy-of select="util:formatData(concat($pharmacy/PVD.2/PVD.2.2.1, $pharmacy/PVD.2/PVD.2.2), 0)"/>
						<xsl:copy-of select="util:formatData($pharmacy/PVD.7/PVD.7.1, 0)"/>
						<xsl:copy-of select="util:formatData($pharmacy/concat(PVD.8/PVD.8.1, ' ', PVD.8/PVD.8.2, ' ', PVD.8/PVD.8.3, ' ', PVD.8/PVD.8.4), 0)"/>
						<xsl:copy-of select="util:formatData($pharmacy/util:format-tel(PVD.9/PVD.9.1), 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="providerInfo">
		<xsl:param name="provider"/>
		<xsl:param name="pNumber"/>
		<xsl:param name="deaNumber"/>
		<xsl:param name="cName"/>
		<xsl:param name="fName"/>
		<xsl:param name="mName"/>
		<xsl:param name="lName"/>
		<xsl:param name="address"/>
		<xsl:param name="phone"/>
		<xsl:if test="exists($provider)">
			<table>
				<thead>
					<tr>
						<th colspan="9">Provider Information</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="{$pNumber}">NPI Number</th>
						<th style="{$deaNumber}">DEA Number</th>
						<th style="{$lName}">Last Name</th>
						<th style="{$mName}">Middle Name</th>
						<th style="{$fName}">First Name</th>
						<th style="{$cName}">Clinic Name</th>
						<th style="{$address}">Address</th>
						<th style="{$phone}">Phone</th>
						<th width="15%">Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(concat($provider/PVD.2/PVD.2.1.1, $provider/PVD.2/PVD.2.1), 0)"/>
						<xsl:copy-of select="util:formatData(concat($provider/PVD.2/PVD.2.2.1, $provider/PVD.2/PVD.2.2), 0)"/>
						<xsl:copy-of select="util:formatData($provider/PVD.5/PVD.5.1, 0)"/>
						<xsl:copy-of select="util:formatData($provider/PVD.5/PVD.5.3, 0)"/>
						<xsl:copy-of select="util:formatData($provider/PVD.5/PVD.5.2, 0)"/>
						<xsl:copy-of select="util:formatData($provider/PVD.7/PVD.7.1, 0)"/>
						<xsl:copy-of select="util:formatData($provider/concat(PVD.8/PVD.8.1, ' ', PVD.8/PVD.8.2, ' ', PVD.8/PVD.8.3, ' ', PVD.8/PVD.8.4), 0)"/>
						<xsl:copy-of select="util:formatData($provider/util:format-tel(PVD.9/PVD.9.1), 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="medicationInfo_P">
		<xsl:param name="drug"/>
		<xsl:param name="desc"/>
		<xsl:param name="itemDesc"/>
		<xsl:param name="drugDesc"/>
		<xsl:param name="NDC"/>
		<xsl:param name="codeList"/>
		<xsl:param name="drugStrength"/>
		<xsl:param name="rxNorm"/>
		<xsl:param name="drugDB"/>
		<!--  <xsl:param name="NCI"/> -->
		<xsl:param name="itemStrength"/>
		<xsl:param name="deaSchedule"/>
		<xsl:param name="drugStrengthCode"/>
		<xsl:param name="quantity"/>
		<xsl:param name="codeListQualifier"/>
		<xsl:param name="sourceCodeList"/>
		<xsl:param name="potencyUnitCode"/>
		<xsl:param name="directions"/>
		<xsl:param name="writtenDate"/>
		<xsl:param name="date"/>
		<xsl:param name="formatQualifier"/>
		<xsl:param name="substitution"/>
		<xsl:param name="refills"/>
		<xsl:param name="refillQuantity"/>
		<xsl:param name="clinicalInformation"/>
		<xsl:param name="ICD"/>
		<xsl:param name="codeListIdentifier"/>
		<xsl:param name="ZDS"/>
		<xsl:param name="days"/>
		<xsl:if test="exists($drug)">
			<table>
				<thead>
					<tr>
						<th colspan="8">
							<xsl:value-of select="$desc"/> - Medication Information</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="{$itemDesc}">Item Description <span style="color:black">*</span>
						</th>
						<th colspan="3" style="{$drugDesc}">Drug Name</th>
						<th>Drug Description <span style="color:black">*</span>
						</th>
						<th>Drug Description(cont) <span style="color:black">*</span>
						</th>
						<th>Drug Description(cont) <span style="color:black">*</span>
						</th>
						<th width="15%">Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.1/DRU.1.1), 'ItemDescription'), 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.2, 3)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.10, 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.11, 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.12, 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$NDC}">NDC Code</th>
						<th style="{$codeList}">Code List</th>
						<th style="{$rxNorm}">RxNorm Code</th>
						<th style="{$drugDB}">RxNorm Semantic Drug Code</th>
						<th style="{$drugStrength}">Drug Strength</th>
						<th>NCI Code</th>
						<th style="{$drugStrengthCode}">Drug Strength Unit of Measure Code</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.3, 0)"/>
						<td>
							<xsl:value-of select="'ND - (National Drug Code)'"/>
						</td>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.8, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.1/DRU.1.9), 'RxNormCode'), 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.6, 0)"/>
						<td>
							<xsl:value-of select="'AB - (NCPDP StrengthUnitOfMeasure (NCIt subset))'"/>
						</td>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.1/DRU.1.16), 'DrugStrengthCode'), 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th>NCI Code</th>
						<th colspan="2" style="{$itemStrength}">Drug Form Code</th>
						<th style="{$quantity}">Quantity</th>
						<th style="{$codeListQualifier}">Code Quantity Qualifier</th>
						<th style="{$sourceCodeList}">Source Code List</th>
						<th style="{$potencyUnitCode}">Quantity Unit of Measure Code</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<td>
							<xsl:value-of select="'AA - (NCPDP Drug StrengthForm Terminology (NCIt subset))'"/>
						</td>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.1/DRU.1.14), 'DrugFormCode'), 2)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.2/DRU.2.2, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.2/DRU.2.3), 'CodeQuantityQualifier'), 0)"/>
						<td>
							<xsl:value-of select="'AC - (NCPDP Drug QuantityUnitOfMeasure Terminology (NCIt subset))'"/>
						</td>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.2/DRU.2.5), 'QuantityUOM'), 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th colspan="5" style="{$directions}">Directions/Dosage</th>
						<th colspan="2">Directions/Dosage(cont)</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($drug/DRU.3/DRU.3.2, 5)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.3/DRU.3.3, 2)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$writtenDate}">Written Date Qualifier <span style="color:black">*</span>
						</th>
						<th style="{$date}">Written Date</th>
						<th colspan="2" style="{$formatQualifier}">Written Date Format Qualifier
                                <span style="color:black">*</span>
						</th>
						<th style="{$ZDS}">Days Supply Qualifier<span style="color:black">*</span>
						</th>
						<th style="{$days}">Days Supply Period</th>
						<th style="{$formatQualifier}">Days Supply Format Qualifier <span style="color:black">*</span>
						</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<td>
							<xsl:value-of select="'85 - (Written Date)'"/>
						</td>
						<!-- only one of them - DRU.4.1.2 or DRU.4.2 will be present! -->
						<xsl:copy-of select="util:formatData(util:dateFormat(concat($drug/DRU.4/DRU.4.1.2, $drug/DRU.4/DRU.4.2)), 0)"/>
						<td colspan="2">
							<xsl:value-of select="'102 - (CCYYMMDD)'"/>
						</td>
						<xsl:variable name="dayssupplyqualifier">
							<xsl:if test="normalize-space($drug/DRU.4/DRU.4.2.1) != ''">
								<xsl:value-of select="'ZDS - (Days Supply)'"/>
							</xsl:if>
						</xsl:variable>
						<xsl:copy-of select="util:formatData($dayssupplyqualifier, 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.4/DRU.4.2.2, 0)"/>
						
						<xsl:variable name="daysupplyformatqualifier">
							<xsl:if test="normalize-space($drug/DRU.4/DRU.4.2.3) != ''">
								<xsl:value-of select="'804 - (Quantity of Days)'"/>
							</xsl:if>
						</xsl:variable>
						<xsl:copy-of select="util:formatData($daysupplyformatqualifier, 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$substitution}">Substitution</th>
						<th style="{$refills}">Refills</th>
						<th style="{$refillQuantity}">Refills Quantity</th>
						<th style="{$clinicalInformation}">Clinical Information</th>
						<th colspan="2" style="{$ICD}">ICD 10 Code</th>
						<th style="{$codeListIdentifier}">Code List Qualifier</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.5/DRU.5.1), 'Substitution'), 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.6/DRU.6.1), 'Refills'), 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.6/DRU.6.2, 0)"/>
						<xsl:copy-of select="util:formatData(concat($drug/DRU.7/DRU.7.1, ' ', '(1 - Prescriber Supplied, 2 - Pharmacy Inferred)'), 0)"/>
						<xsl:copy-of select="util:formatData(util:ICD-10-codes(normalize-space($drug/DRU.7/DRU.7.2), normalize-space($drug/DRU.1/DRU.1.2)), 2)"/>
						<!--xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.7/DRU.7.2), 'ICD'), 2)"/-->
						<td>
							<xsl:value-of select="'ABF - (ICD 10)'"/>
						</td>
						<xsl:call-template name="commentTemplate"/>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="medicationInfo_D">
		<xsl:param name="drug"/>
		<xsl:param name="desc"/>
		<xsl:param name="itemDesc"/>
		<xsl:param name="drugDesc"/>
		<xsl:param name="NDC"/>
		<xsl:param name="codeList"/>
		<xsl:param name="drugStrength"/>
		<xsl:param name="rxNorm"/>
		<xsl:param name="drugDB"/>
		<!--  <xsl:param name="NCI"/> -->
		<xsl:param name="itemStrength"/>
		<xsl:param name="deaSchedule"/>
		<xsl:param name="drugStrengthCode"/>
		<xsl:param name="quantity"/>
		<xsl:param name="codeListQualifier"/>
		<xsl:param name="sourceCodeList"/>
		<xsl:param name="potencyUnitCode"/>
		<xsl:param name="directions"/>
		<xsl:param name="writtenDate"/>
		<xsl:param name="date"/>
		<xsl:param name="formatQualifier"/>
		<xsl:param name="substitution"/>
		<xsl:param name="refills"/>
		<xsl:param name="refillQuantity"/>
		<xsl:param name="clinicalInformation"/>
		<xsl:param name="ICD"/>
		<xsl:param name="codeListIdentifier"/>
		<xsl:param name="ZDS"/>
		<xsl:param name="days"/>
		<xsl:if test="exists($drug)">
			<table>
				<thead>
					<tr>
						<th colspan="8">
							<xsl:value-of select="$desc"/> - Medication Information</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="{$itemDesc}">Item Description <span style="color:black">*</span>
						</th>
						<th colspan="3" style="{$drugDesc}">Drug Name</th>
						<th>Drug Description <span style="color:black">*</span>
						</th>
						<th>Drug Description(cont) <span style="color:black">*</span>
						</th>
						<th>Drug Description(cont) <span style="color:black">*</span>
						</th>
						<th width="15%">Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.1/DRU.1.1), 'ItemDescription'), 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.2, 3)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.10, 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.11, 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.12, 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$NDC}">NDC Code</th>
						<th style="{$codeList}">Code List</th>
						<th style="{$rxNorm}">RxNorm Code</th>
						<th style="{$drugDB}">RxNorm Semantic Drug Code</th>
						<th style="{$drugStrength}">Drug Strength</th>
						<th>NCI Code</th>
						<th style="{$drugStrengthCode}">Drug Strength Unit of Measure Code</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.3, 0)"/>
						<td>
							<xsl:value-of select="'ND - (National Drug Code)'"/>
						</td>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.8, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.1/DRU.1.9), 'RxNormCode'), 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.1/DRU.1.6, 0)"/>
						<td>
							<xsl:value-of select="'AB - (NCPDP StrengthUnitOfMeasure (NCIt subset))'"/>
						</td>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.1/DRU.1.16), 'DrugStrengthCode'), 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th>NCI Code</th>
						<th colspan="2" style="{$itemStrength}">Drug Form Code</th>
						<th style="{$quantity}">Quantity</th>
						<th style="{$codeListQualifier}">Code Quantity Qualifier</th>
						<th style="{$sourceCodeList}">Source Code List</th>
						<th style="{$potencyUnitCode}">Quantity Unit of Measure Code</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<td>
							<xsl:value-of select="'AA - (NCPDP Drug StrengthForm Terminology (NCIt subset))'"/>
						</td>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.1/DRU.1.14), 'DrugFormCode'), 2)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.2/DRU.2.2, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.2/DRU.2.3), 'CodeQuantityQualifier'), 0)"/>
						<td>
							<xsl:value-of select="'AC - (NCPDP Drug QuantityUnitOfMeasure Terminology (NCIt subset))'"/>
						</td>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.2/DRU.2.5), 'QuantityUOM'), 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th colspan="3" style="{$directions}">Directions/Dosage</th>
						<th>Directions/Dosage(cont)</th>
						<th style="{$writtenDate}">Written Date Qualifier <span style="color:black">*</span>
						</th>
						<th style="{$date}">Written Date</th>
						<th style="{$formatQualifier}">Written Date Format Qualifier <span style="color:black">*</span>
						</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($drug/DRU.3/DRU.3.2, 3)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.3/DRU.3.3, 0)"/>
						<td>
							<xsl:value-of select="'85 - (Written Date)'"/>
						</td>
						<xsl:copy-of select="util:formatData(util:dateFormat($drug/DRU.4/DRU.4.1.2), 0)"/>
						<td>
							<xsl:value-of select="'102 - (CCYYMMDD)'"/>
						</td>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$writtenDate}">Last Fill Date Qualifier <span style="color:black">*</span>
						</th>
						<th style="{$date}">Last Fill Date</th>
						<th colspan="2" style="{$formatQualifier}">Last Fill Date Format Qualifier
                                <span style="color:black">*</span>
						</th>
						<th style="{$ZDS}">Days Supply Qualifier <span style="color:black">*</span>
						</th>
						<th style="{$days}">Days Supply Period</th>
						<th style="{$formatQualifier}">Days Supply Format Qualifier <span style="color:black">*</span>
						</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<td>
							<xsl:value-of select="'LD - (Last Fill)'"/>
						</td>
						<xsl:copy-of select="util:formatData(util:dateFormat($drug/DRU.4/DRU.4.2.2), 0)"/>
						<td colspan="2">
							<xsl:value-of select="'102 - (CCYYMMDD)'"/>
						</td>
						<xsl:variable name="dayssupplyqualifier2">
							<xsl:if test="normalize-space($drug/DRU.4/DRU.4.3.1) != ''">
								<xsl:value-of select="'ZDS - (Days Supply)'"/>
							</xsl:if>
						</xsl:variable>
							<xsl:copy-of select="util:formatData($dayssupplyqualifier2, 0)"/>
						
						<xsl:copy-of select="util:formatData($drug/DRU.4/DRU.4.3.2, 0)"/>
						
						<xsl:variable name="daysformatqualifier2">
							<xsl:if test="normalize-space($drug/DRU.4/DRU.4.3.1) != ''">
								<xsl:value-of select="'804 - (Quantity of Days)'"/>
							</xsl:if>
						</xsl:variable>
							<xsl:copy-of select="util:formatData($daysformatqualifier2, 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$substitution}">Substitution</th>
						<th style="{$refills}">Refills</th>
						<th style="{$refillQuantity}">Refills Quantity</th>
						<th style="{$clinicalInformation}">Clinical Information</th>
						<th colspan="2" style="{$ICD}">ICD 10 Code</th>
						<th style="{$codeListIdentifier}">Code List Qualifier</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.5/DRU.5.1), 'Substitution'), 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.6/DRU.6.1), 'Refills'), 0)"/>
						<xsl:copy-of select="util:formatData($drug/DRU.6/DRU.6.2, 0)"/>
						<xsl:copy-of select="util:formatData(concat($drug/DRU.7/DRU.7.1, ' ', '(1 - Prescriber Supplied, 2 - Pharmacy Inferred)'), 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($drug/DRU.7/DRU.7.2), 'ICD'), 2)"/>
						<td>
							<xsl:value-of select="'ABF - (ICD 10)'"/>
						</td>
						<xsl:call-template name="commentTemplate"/>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coo">
		<xsl:param name="coo"/>
		<xsl:param name="pIDInfo"/>
		<xsl:param name="pIdQualifier"/>
		<xsl:param name="pName"/>
		<xsl:param name="cardID"/>
		<xsl:param name="fName"/>
		<xsl:param name="mName"/>
		<xsl:param name="lName"/>
		<xsl:param name="groupID"/>
		<xsl:param name="effectiveDate"/>
		<xsl:param name="date"/>
		<xsl:param name="formatQualifer"/>
		<xsl:param name="expirationDate"/>
		<xsl:param name="patientConsent"/>
		<xsl:param name="patientIdentifier"/>
		<xsl:if test="exists($coo)">
			<table>
				<thead>
					<tr>
						<th colspan="8">Coordination of Benefits Information</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="{$pIDInfo}">Payer ID Information</th>
						<th style="{$pIdQualifier}">Payer ID Qualifier <span style="color:black">*</span>
						</th>
						<th style="{$pName}">Payer Name</th>
						<th style="{$cardID}">Cardholder ID</th>
						<th style="{$lName}">Cardholder Last Name</th>
						<th style="{$mName}">Cardholder Middle Name</th>
						<th style="{$fName}">Cardholder First Name</th>
						<th width="15%">Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($coo/COO.1/COO.1.1, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($coo/COO.1/COO.1.2), 'PayerIdNumber'), 0)"/>
						<xsl:copy-of select="util:formatData($coo/COO.2/COO.2.1, 0)"/>
						<xsl:copy-of select="util:formatData($coo/COO.4/COO.4.1, 0)"/>
						<xsl:copy-of select="util:formatData($coo/COO.5/COO.5.1, 0)"/>
						<xsl:copy-of select="util:formatData($coo/COO.5/COO.5.3, 0)"/>
						<xsl:copy-of select="util:formatData($coo/COO.5/COO.5.2, 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$groupID}">Group ID</th>
						<th style="{$effectiveDate}">Effective Date(Begin) Qualifier <span style="color:black">*</span>
						</th>
						<th style="{$date}">Effective Date(Begin)</th>
						<th style="{$formatQualifer}">Effective Date(Begin) Format Qualifer <span style="color:black">*</span>
						</th>
						<th style="{$expirationDate}">Expiration Date Qualifier <span style="color:black">*</span>
						</th>
						<th style="{$date}">Expiration Date</th>
						<th style="{$formatQualifer}">Expiration Date Format Qualifer <span style="color:black">*</span>
						</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($coo/COO.6/COO.6.1, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($coo/COO.9/COO.9.1.1), 'DateQualifier'), 0)"/>
						<xsl:copy-of select="util:formatData(util:dateFormat($coo/COO.9/COO.9.1.2), 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($coo/COO.9/COO.9.1.3), 'DateFormatQualifier'), 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($coo/COO.9/COO.9.2.1), 'DateQualifier'), 0)"/>
						<xsl:copy-of select="util:formatData(util:parseDate-ccyymmdd($coo/COO.9/COO.9.2.2), 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($coo/COO.9/COO.9.2.3), 'DateFormatQualifier'), 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$patientConsent}">Patient Consent Indicator</th>
						<th colspan="6" style="{$patientIdentifier}">Patient Qualifer</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($coo/COO.13/COO.13.1), 'PatientConsentIndicator'), 0)"/>
						<xsl:copy-of select="util:formatData($coo/COO.14/COO.14.1, 6)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="structuredSIG">
		<xsl:param name="sig"/>
		<xsl:param name="drugName"/>
		<xsl:param name="sigSequence"/>
		<xsl:param name="snomedVersion"/>
		<xsl:param name="FMT"/>
		<xsl:param name="sigFreeText"/>
		<xsl:param name="sigIndicator"/>
		<xsl:param name="doseCompositeIndicator"/>
		<xsl:param name="doseDeliveryText"/>
		<xsl:param name="doseDeliveryCodeQualifier"/>
		<xsl:param name="doseDeliveryCode"/>
		<xsl:param name="doseQuantity"/>
		<xsl:param name="doseFormText"/>
		<xsl:param name="doseFormCodeQualifier"/>
		<xsl:param name="doseFormCode"/>
		<xsl:param name="durationNumericValue"/>
		<xsl:param name="durationText"/>
		<xsl:param name="durationCodeQualifier"/>
		<xsl:param name="durationCode"/>
		<xsl:param name="maxRestrictionNumericValue"/>
		<xsl:param name="maxRestrictionUnitsText"/>
		<xsl:param name="maxRestrictionCodeQualifier"/>
		<xsl:param name="maxRestrictionUnitsCode"/>
		<xsl:param name="indPrecursorText"/>
		<xsl:param name="indPrecursorCodeQualifier"/>
		<xsl:param name="indPrecursorCode"/>
		<xsl:param name="indText"/>
		<xsl:param name="indTextCodeQualifier"/>
		<xsl:param name="indTextCode"/>
		<xsl:param name="indUMText"/>
		<xsl:param name="indUMCodeQualifier"/>
		<xsl:param name="indUMCode"/>
		<xsl:if test="exists($sig)">
			<table>
				<thead>
					<tr>
						<th colspan="8">Structured SIG <xsl:value-of select="$drugName"/>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th style="{$sigSequence}">Sig Sequence Position Number</th>
						<th>Usage of Repeating Sigs</th>
						<th style="{$snomedVersion}">SNOMED Version</th>
						<th style="{$FMT}">FMT Version</th>
						<th style="{$sigIndicator}">Sig Free Text String Indicator</th>
						<th style="{$sigFreeText}" colspan="2">Sig Free Text</th>
						<th width="15%">Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($sig/SIG.1/SIG.1.1, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.1/SIG.1.2), 'RepeatingSigs'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.2/SIG.2.1, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.2/SIG.2.2, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.3/SIG.3.1), 'SigFreeTextIndicator'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.3/SIG.3.2, 2)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$doseCompositeIndicator}">Dose Composite Indicator</th>
						<th style="{$doseDeliveryText}">Dose Delivery Method Text</th>
						<th style="{$doseDeliveryCodeQualifier}">Dose Delivery Method Code
                            Qualifier</th>
						<th style="{$doseDeliveryCode}">Dose Delivery Method Code</th>
						<th style="{$doseQuantity}">Dose Quantity</th>
						<th style="{$doseFormText}" colspan="2">Dose Form Text</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.4/SIG.4.1), 'DoseCompositeIndicator'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.4/SIG.4.2, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.4/SIG.4.3), 'Version'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.4/SIG.4.4, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.4/SIG.4.8, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.4/SIG.4.9, 2)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$doseFormCodeQualifier}">Dose Form Code Qualifier</th>
						<th style="{$doseFormCode}">Dose Form Code</th>
						<th>Route of Administration Text</th>
						<th>Route of Administration Code Qualifier</th>
						<th>Route of Administration Code</th>
						<th colspan="2">Administration Timing Text</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.4/SIG.4.10), 'Version'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.4/SIG.4.11, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.7/SIG.7.1, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.7/SIG.7.2), 'Version'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.7/SIG.7.3, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.9/SIG.9.1, 2)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th>Administration Timing Code Qualifier</th>
						<th>Administration Timing Code</th>
						<th>Multiple Administration Timing Modifier</th>
						<th>Frequency Numeric Value</th>
						<th colspan="2">Frequency Units Text</th>
						<th>Frequency Units Code Qualifier</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.9/SIG.9.2), 'Version'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.9/SIG.9.3, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.9/SIG.9.4), 'MultiAdminTimingModifier'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.9/SIG.9.12, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.9/SIG.9.13, 2)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.9/SIG.9.14), 'Version'), 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th>Frequency Units Code</th>
						<th>Interval Numeric Value</th>
						<th colspan="2">Interval Units Text</th>
						<th>Interval Units Code Qualifier</th>
						<th>Interval Units Code</th>
						<th style="{$durationNumericValue}">Duration Numeric Value</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($sig/SIG.9/SIG.9.15, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.9/SIG.9.17, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.9/SIG.9.18, 2)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.9/SIG.9.19), 'Version'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.9/SIG.9.20, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.10/SIG.10.1, 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<tr>
						<th style="{$durationText}">Duration Text</th>
						<th style="{$durationCodeQualifier}">Duration Text Code Qualifier</th>
						<th style="{$durationCode}">Duration Text Code</th>
						<th style="{$maxRestrictionNumericValue}">Maximum Dose Restriction Numeric
                            Value</th>
						<th style="{$maxRestrictionUnitsText}">Maximum Dose Restriction Units
                            Text</th>
						<th style="{$maxRestrictionCodeQualifier}">Maximum Dose Restriction Code
                            Qualifier</th>
						<th style="{$maxRestrictionUnitsCode}">Maximum Dose Restriction Units
                            Code</th>
						<th>Tester Comment</th>
					</tr>
					<tr>
						<xsl:copy-of select="util:formatData($sig/SIG.10/SIG.10.2, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.10/SIG.10.3), 'Version'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.10/SIG.10.4, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.11/SIG.11.1, 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.11/SIG.11.2, 0)"/>
						<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.11/SIG.11.3), 'Version'), 0)"/>
						<xsl:copy-of select="util:formatData($sig/SIG.11/SIG.11.4, 0)"/>
						<xsl:call-template name="commentTemplate"/>
					</tr>
					<xsl:if test="string-length(normalize-space($sig/SIG.12)) != 0">
						<tr>
							<th style="{$indPrecursorText}" colspan="2">Indication Precursor
                                Text</th>
							<th style="{$indPrecursorCodeQualifier}">Indication Precursor Code
                                Qualifier</th>
							<th style="{$indPrecursorCode}">Indication Precursor Code </th>
							<th style="{$indText}">Indication Text</th>
							<th style="{$indTextCodeQualifier}">Indication Text Code Qualifier</th>
							<th style="{$indTextCode}">Indication Text Code</th>
							<th>Tester Comment</th>
						</tr>
						<tr>
							<xsl:copy-of select="util:formatData($sig/SIG.12/SIG.12.1, 2)"/>
							<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.12/SIG.12.2), 'Version'), 0)"/>
							<xsl:copy-of select="util:formatData($sig/SIG.12/SIG.12.3, 0)"/>
							<xsl:copy-of select="util:formatData($sig/SIG.12/SIG.12.4, 0)"/>
							<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.12/SIG.12.5), 'Version'), 0)"/>
							<xsl:copy-of select="util:formatData($sig/SIG.12/SIG.12.6, 0)"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<th style="{$indUMText}" colspan="5">Indication Value Unit of Measure
                                Text</th>
							<th style="{$indUMCodeQualifier}">Indication Value Unit of Measure Code
                                Qualifier</th>
							<th style="{$indUMCode}">Indication Value Unit of Measure Code</th>
							<th>Tester Comment</th>
						</tr>
						<tr>
							<xsl:copy-of select="util:formatData($sig/SIG.12/SIG.12.9, 5)"/>
							<xsl:copy-of select="util:formatData(util:codeDescription(normalize-space($sig/SIG.12/SIG.12.10), 'Version'), 0)"/>
							<xsl:copy-of select="util:formatData($sig/SIG.12/SIG.12.11, 0)"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
					</xsl:if>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	<xsl:template name="instructions">
		<fieldset>
			<h3 align="center">Testing of ePrescribing message content </h3>
			<p>When using the NIST tool for conformance testing for ONC Certification, the following
                are in effect: </p>
			<p style="color:red; font-style:italic; font-weight:bold">Testing of message content
                other than Structured Sig: </p>
			<ul>
				<li>Mandatory in the standard with an explicit test case value that is either: <ol>
						<li>entered or selected directly by a user (e.g., a quantity of
                            &apos;30&apos;)</li>
						<li>a set qualifier or other structural value in the standard (e.g.,
                            quantity qualifier of &apos;38&apos; meaning original prescribed
                            quantity) </li>
					</ol>
					<p style="font-style:italic; font-weight:bold">Results in Error if not
                        populated per the test case</p>
				</li>
			</ul>
			<ul>
				<li> Conditional in the standard with an explicit test case value that is either: <ol>
						<li>entered or selected directly by a user (e.g., a quantity of
                            &apos;30&apos;)</li>
						<li> a set qualifier or other structural value in the standard (e.g.,
                            quantity qualifier of &apos;38&apos; meaning original prescribed
                            quantity) </li>
					</ol>
				</li>
				<li>Has Explicit Implementation Recommendations Document guidance that it is to be
                    populated: <p style="font-style:italic; font-weight:bold">Results in Error if
                        not populated per the test case</p>
				</li>
			</ul>
			<ul>
				<li>Conditional in the standard with an explicit test case value that is either: <ol>
						<li> entered or selected directly by a user (e.g., a quantity of
                            &apos;30&apos;)</li>
						<li> a set qualifier or other structural value in the standard (e.g.,
                            quantity qualifier of &apos;38&apos; meaning original prescribed
                            quantity)</li>
					</ol>
				</li>
				<li>Without explicit Implementation Recommendations Document guidance: <p style="font-style:italic; font-weight:bold">Results in Warning if not
                        populated or Error if populated with a value that differs from the test case
                    </p>
				</li>
			</ul>
			<ul>
				<li> Mandatory in the standard but with a value that varies systematically (e.g.,
                    sent time, message ID): <p style="font-style:italic; font-weight:bold">Results
                        in Error if not present or not syntactically correct</p>
					<p>Examples:Sent time, Message ID / relates to ID, Order number, To ID,From ID,
                        SNOMED version, FMT version </p>
				</li>
			</ul>
			<ul>
				<li>Mandatory in the standard but with a value for which the meaning must be
                    confirmed by a human, because it can reasonably vary (e.g., medication name): <p style="font-style:italic; font-weight:bold">Results in Error if not present
                        and having the correct meaning</p>
				</li>
			</ul>
			<ul>
				<li> Conditional in the standard, with no test case value given: <p style="font-style:italic; font-weight:bold">Results in Error if not
                        syntactically correct</p>
				</li>
			</ul>
			<p style="color:red; font-style:italic; font-weight:bold">Testing of Structured Sig:</p>
			<ul>
				<li>For all vendors: <b>Must be syntactically correct</b>
				</li>
				<li>For vendors wishing to obtain additional, optional certification for
                    communicating the reason for prescription in Structured Sig:<b> Population of
                        individual fields must match the coded test case values, and non-coded
                        values (e.g., indication text) is confirmed by the juror to have the correct
                        meaning (e.g., &quot;oral route&quot; would be an allowed variation if the
                        test case value is &quot;by mouth&quot;).</b>
				</li>
			</ul>
		</fieldset>
	</xsl:template>
	<xsl:template name="_main">
		<xsl:variable name="message-type">
			<xsl:choose>
				<xsl:when test="starts-with(name(.), 'CHGRX') or starts-with(name(.), 'RXCHG')">
					<xsl:value-of select="$RXCHG"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'REFREQ')">
					<xsl:value-of select="$REFREQ"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'RXHRES')">
					<xsl:value-of select="$RXHRES"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'RXFILL')">
					<xsl:value-of select="$RXFILL"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'CANRES')">
					<xsl:value-of select="$CANRES"/>
				</xsl:when>
				<xsl:when test="starts-with(name(.), 'STATUS')">
					<xsl:value-of select="$STATUS"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<!-- - - - - - - - - - - - - - - - - - -   - - - - - -  - - -  - - -  - - - - - - - - - - - - For Change Request - - - - - - - - - - - - - -   - -  - - - - - - - - - - - - - - - - - - - -->
			<xsl:when test="$message-type = $RXCHG">
				<xsl:call-template name="messageHeader">
					<xsl:with-param name="title" select="'Change Request'"/>
					<xsl:with-param name="note">
						<p>This Test Case-specific Juror Document provides a checklist for the
                            Tester to use during certification testing for assessing the EHR
                            technology&apos;s ability to display required core data elements from
                            the information received in the eRx message. Additional data from the
                            message or from the EHR are permitted to be displayed by the EHR.
                            Grayed-out fields in the Juror Document indicate where no data for that
                            data element were included in the message for the given Test Case.</p>
						<p>The format of this Juror Document is for ease-of-use by the Tester and
                            does not indicate how the EHR display must be designed.The column
                            headings are meant to convey the kind of data to be displayed;
                            equivalent labels/column headings are permitted to be displayed by the
                            EHR. The column headings marked in <b>
								<i>
									<font color="red">bold red
                                        italics</font>
								</i>
							</b> indicate the required fields,
                                        <b>
								<u>
									<font color="green">bold green
                                underlined</font>
								</u>
							</b> column headings indicate required fields
                            when composite is used, column headings with <b>*(asterisk)</b> indicate
                            fields present in EDI but not in XML and column headings in <b>bold
                                black</b> indicate the conditional fields.</p>
						<p>The EHR is permitted to display data that are equivalent to the data
                            shown in the Juror Document for both the required fields and conditional
                            fields. Each code that appears in the message is displayed with its
                            associated description in the Juror Document. The code&apos;s
                            descriptions are not part of the message. The column headings that are
                            labeled with &quot;(cont)&quot; in the Juror Document represent field(s)
                            from the message where it could be expected continuation of Test Case
                            data, when full verbiage of Test Case data cannot fit specific field(s)
                            in the message due to its character limitation. </p>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="exists(//REQ/REQ.1/REQ.1.1)">
					<table>
						<thead>
							<tr>
								<th colspan="2">Change Request Type</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>Message Function</th>
								<th>Tester Comment</th>
							</tr>
							<tr>
								<td>
									<xsl:value-of select="util:chngRequestType(normalize-space(//REQ/REQ.1/REQ.1.1))"/>
								</td>
								<xsl:call-template name="commentTemplate"/>
							</tr>
						</tbody>
					</table>
				</xsl:if>
				<br/>
				<xsl:call-template name="patientInfo">
					<xsl:with-param name="pttSegment" select="//PTT"/>
					<xsl:with-param name="fName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="lName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="gender" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="pPhone" select="'color:green; text-decoration:underline'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="pharmacyInfo">
					<xsl:with-param name="pharmacy" select="//PVD/PVD.1/PVD.1.1[. = 'P2']/../.."/>
					<xsl:with-param name="pName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="ncpdp" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="npi" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="phone" select="'color:red; font-style:italic'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="providerInfo">
					<xsl:with-param name="provider" select="//PVD/PVD.1/PVD.1.1[. = 'PC']/../.."/>
					<xsl:with-param name="pNumber" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="deaNumber" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="lName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="phone" select="'color:red; font-style:italic'"/>
				</xsl:call-template>
				<br/>
				<xsl:for-each select="//DRU/DRU.1/DRU.1.1[. = 'P']/../..">
					<xsl:variable name="pos" select="position()"/>
					<xsl:call-template name="medicationInfo_P">
						<xsl:with-param name="desc" select="'Prescribed Drug'"/>
						<xsl:with-param name="drug" select="."/>
						<xsl:with-param name="itemDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="drugDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="quantity" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="codeListQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="sourceCodeList" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="potencyUnitCode" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="directions" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="writtenDate" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="date" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="formatQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="refills" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="clinicalInformation" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ICD" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ZDS" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="days" select="'color:red; font-style:italic'"/>
					</xsl:call-template>
					<br/>
					<xsl:for-each select="./following-sibling::SIG[count(preceding-sibling::DRU) = $pos]">
						<xsl:call-template name="structuredSIG">
							<xsl:with-param name="sig" select="."/>
							<xsl:with-param name="drugName" select="'for Prescribed Drug'"/>
							<xsl:with-param name="sigSequence" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="snomedVersion" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="FMT" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigFreeText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="maxRestrictionUnitsCode" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionUnitsText" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationText" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationCode" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="doseCompositeIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseQuantity" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMText" select="'color:red; font-style:italic'"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
				<br/>
				<xsl:for-each select="//DRU/DRU.1/DRU.1.1[. = 'R']/../..">
					<xsl:variable name="pos" select="position()"/>
					<xsl:call-template name="medicationInfo_P">
						<xsl:with-param name="desc" select="'Requested Drug'"/>
						<xsl:with-param name="drug" select="."/>
						<xsl:with-param name="itemDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="drugDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="quantity" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="codeListQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="sourceCodeList" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="potencyUnitCode" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="directions" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="writtenDate" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="date" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="formatQualifier" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="refills" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="clinicalInformation" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ICD" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ZDS" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="days" select="'color:green; text-decoration:underline'"/>
					</xsl:call-template>
					<br/>
					<xsl:for-each select="./following-sibling::SIG[count(preceding-sibling::DRU/DRU.1/DRU.1.1[. = 'R']) = $pos]">
						<xsl:call-template name="structuredSIG">
							<xsl:with-param name="sig" select="."/>
							<xsl:with-param name="drugName" select="'for Requested Drug'"/>
							<xsl:with-param name="sigSequence" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="snomedVersion" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="FMT" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigFreeText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="maxRestrictionUnitsCode" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionUnitsText" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationText" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationCode" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="doseCompositeIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseQuantity" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMText" select="'color:red; font-style:italic'"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
				<br/>
				<xsl:call-template name="instructions"/>
			</xsl:when>
			<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - For Refill request - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - -->
			<xsl:when test="$message-type = $REFREQ">
				<xsl:call-template name="messageHeader">
					<xsl:with-param name="title" select="'Refill Request'"/>
					<xsl:with-param name="note">
						<p>This Test Case-specific Juror Document provides a checklist for the
                            Tester to use during certification testing for assessing the EHR
                            technology&apos;s ability to display required core data elements from
                            the information received in the eRx message. Additional data from the
                            message or from the EHR are permitted to be displayed by the EHR.
                            Grayed-out fields in the Juror Document indicate where no data for that
                            data element were included in the message for the given Test Case.</p>
						<p>The format of this Juror Document is for ease-of-use by the Tester and
                            does not indicate how the EHR display must be designed.The column
                            headings are meant to convey the kind of data to be displayed;
                            equivalent labels/column headings are permitted to be displayed by the
                            EHR. The column headings marked in <b>
								<i>
									<font color="red">bold red
                                        italics</font>
								</i>
							</b> indicate the required fields,
                                        <b>
								<u>
									<font color="green">bold green
                                underlined</font>
								</u>
							</b> column headings indicate required fields
                            when composite is used, column headings with <b>*(asterisk)</b> indicate
                            fields present in EDI but not in XML and column headings in <b>bold
                                black</b> indicate the conditional fields.</p>
						<p>The EHR is permitted to display data that are equivalent to the data
                            shown in the Juror Document for both the required fields and conditional
                            fields. Each code that appears in the message is displayed with its
                            associated description in the Juror Document. The code&apos;s
                            descriptions are not part of the message. The column headings that are
                            labeled with &quot;(cont)&quot; in the Juror Document represent field(s)
                            from the message where it could be expected continuation of Test Case
                            data, when full verbiage of Test Case data cannot fit specific field(s)
                            in the message due to its character limitation. </p>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="patientInfo">
					<xsl:with-param name="pttSegment" select="//PTT"/>
					<xsl:with-param name="fName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="lName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="pPhone" select="'color:green; text-decoration:underline'"/>
					<xsl:with-param name="gender" select="'color:red; font-style:italic'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="pharmacyInfo">
					<xsl:with-param name="pharmacy" select="//PVD/PVD.1/PVD.1.1[. = 'P2']/../.."/>
					<xsl:with-param name="ncpdp" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="npi" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="pName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="address" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="phone" select="'color:red; font-style:italic'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="providerInfo">
					<xsl:with-param name="provider" select="//PVD/PVD.1/PVD.1.1[. = 'PC']/../.."/>
					<xsl:with-param name="pNumber" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="phone" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="deaNumber" select="'color:red; font-style:italic'"/>
				</xsl:call-template>
				<br/>
				<xsl:for-each select="//DRU/DRU.1/DRU.1.1[. = 'P']/../..">
					<xsl:variable name="pos" select="position()"/>
					<xsl:call-template name="medicationInfo_P">
						<xsl:with-param name="desc" select="'Prescribed Drug'"/>
						<xsl:with-param name="drug" select="."/>
						<xsl:with-param name="itemDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="drugDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="quantity" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="codeListQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="sourceCodeList" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="potencyUnitCode" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="directions" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="writtenDate" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="date" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="formatQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="refills" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="clinicalInformation" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ICD" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="days" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="ZDS" select="'color:red; font-style:italic'"/>
					</xsl:call-template>
					<br/>
					<xsl:for-each select="./following-sibling::SIG[count(preceding-sibling::DRU) = $pos]">
						<xsl:call-template name="structuredSIG">
							<xsl:with-param name="sig" select="."/>
							<xsl:with-param name="drugName" select="'for Prescribed Drug'"/>
							<xsl:with-param name="sigSequence" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="snomedVersion" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="FMT" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigFreeText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="maxRestrictionUnitsCode" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionUnitsText" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationText" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationCode" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="doseCompositeIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseQuantity" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMText" select="'color:red; font-style:italic'"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
				<br/>
				<xsl:for-each select="//DRU/DRU.1/DRU.1.1[. = 'D']/../..">
					<xsl:variable name="pos" select="position()"/>
					<xsl:call-template name="medicationInfo_D">
						<xsl:with-param name="desc" select="'Dispensed Drug'"/>
						<xsl:with-param name="drug" select="."/>
						<xsl:with-param name="itemDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="drugDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="quantity" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="codeListQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="sourceCodeList" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="potencyUnitCode" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="directions" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="writtenDate" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="date" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="formatQualifier" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="refills" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="clinicalInformation" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ICD" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ZDS" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="days" select="'color:green; text-decoration:underline'"/>
					</xsl:call-template>
					<br/>
					<xsl:for-each select="./following-sibling::SIG[count(preceding-sibling::DRU/DRU.1/DRU.1.1[. = 'D']) = $pos]">
						<xsl:call-template name="structuredSIG">
							<xsl:with-param name="sig" select="."/>
							<xsl:with-param name="drugName" select="'for Dispensed Drug'"/>
							<xsl:with-param name="sigSequence" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="snomedVersion" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="FMT" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigFreeText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="maxRestrictionUnitsCode" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionUnitsText" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationText" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationCode" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="doseCompositeIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseQuantity" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMText" select="'color:red; font-style:italic'"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
				<br/>
				<xsl:call-template name="instructions"/>
			</xsl:when>
			<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -For Fill Status - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
			<xsl:when test="$message-type = $RXFILL">
				<xsl:call-template name="messageHeader">
					<xsl:with-param name="title" select="'Fill Status'"/>
					<xsl:with-param name="note">
						<p>This Test Case-specific Juror Document provides a checklist for the
                            Tester to use during certification testing for assessing the EHR
                            technology&apos;s ability to display required core data elements from
                            the information received in the eRx message. Additional data from the
                            message or from the EHR are permitted to be displayed by the EHR.
                            Grayed-out fields in the Juror Document indicate where no data for that
                            data element were included in the message for the given Test Case.</p>
						<p>The format of this Juror Document is for ease-of-use by the Tester and
                            does not indicate how the EHR display must be designed.The column
                            headings are meant to convey the kind of data to be displayed;
                            equivalent labels/column headings are permitted to be displayed by the
                            EHR. The column headings marked in <b>
								<i>
									<font color="red">bold red
                                        italics</font>
								</i>
							</b> indicate the required fields,
                                        <b>
								<u>
									<font color="green">bold green
                                underlined</font>
								</u>
							</b> column headings indicate required fields
                            when composite is used, column headings with <b>*(asterisk)</b> indicate
                            fields present in EDI but not in XML and column headings in <b>bold
                                black</b> indicate the conditional fields.</p>
						<p>The EHR is permitted to display data that are equivalent to the data
                            shown in the Juror Document for both the required fields and conditional
                            fields. Each code that appears in the message is displayed with its
                            associated description in the Juror Document. The code&apos;s
                            descriptions are not part of the message. The column headings that are
                            labeled with &quot;(cont)&quot; in the Juror Document represent field(s)
                            from the message where it could be expected continuation of Test Case
                            data, when full verbiage of Test Case data cannot fit specific field(s)
                            in the message due to its character limitation. </p>
					</xsl:with-param>
				</xsl:call-template>
				<table>
					<thead>
						<tr>
							<th colspan="4">Fill Status Response</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th style="color:red; font-style:italic">Response Type<span style="color:black">*</span>
							</th>
							<th>Code List Qualifier <xsl:if test="not(normalize-space(//RES/RES.1/RES.1.1) = 'D')">*</xsl:if></th>
							<th>Pickup Explanation</th>
							<th>Tester Comment</th>
						</tr>
						<tr>
							<xsl:copy-of select="util:formatData(util:response(normalize-space(//RES/RES.1/RES.1.1)), 0)"/>
							<xsl:copy-of select="util:formatData(util:fillStatus(normalize-space(//RES/RES.2/RES.2.1)), 0)"/>
							<xsl:copy-of select="util:formatData(//RES/RES.4/RES.4.1, 0)"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<td colspan="4">When Denied is used, FillReasonCode (XML)/Code List Qualifier(EDI), Note (XML)/Free text (EDI) or both must be populated.</td>
						</tr>
					</tbody>
				</table>
				<br/>
				<xsl:call-template name="patientInfo">
					<xsl:with-param name="pttSegment" select="//PTT"/>
					<xsl:with-param name="fName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="lName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="pPhone" select="'color:green; text-decoration:underline'"/>
					<xsl:with-param name="gender" select="'color:red; font-style:italic'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="pharmacyInfo">
					<xsl:with-param name="pharmacy" select="//PVD/PVD.1/PVD.1.1[. = 'P2']/../.."/>
					<xsl:with-param name="pName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="ncpdp" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="npi" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="address" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="phone" select="'color:red; font-style:italic'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="providerInfo">
					<xsl:with-param name="provider" select="//PVD/PVD.1/PVD.1.1[. = 'PC']/../.."/>
					<xsl:with-param name="lName" select="'color:red; font-style:italic'"/>
					<xsl:with-param name="phone" select="'color:red; font-style:italic'"/>
				</xsl:call-template>
				<br/>
				<xsl:for-each select="//DRU/DRU.1/DRU.1.1[. = 'P']/../..">
					<xsl:variable name="pos" select="position()"/>
					<xsl:call-template name="medicationInfo_P">
						<xsl:with-param name="desc" select="'Prescribed Drug'"/>
						<xsl:with-param name="drug" select="."/>
						<xsl:with-param name="itemDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="drugDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="quantity" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="codeListQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="sourceCodeList" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="potencyUnitCode" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="directions" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="writtenDate" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="date" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="formatQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="refills" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="clinicalInformation" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ICD" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="days" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="ZDS" select="'color:red; font-style:italic'"/>
					</xsl:call-template>
					<br/>
					<xsl:for-each select="./following-sibling::SIG[count(preceding-sibling::DRU) = $pos]">
						<xsl:call-template name="structuredSIG">
							<xsl:with-param name="sig" select="."/>
							<xsl:with-param name="drugName" select="'for Prescribed Drug'"/>
							<xsl:with-param name="sigSequence" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="snomedVersion" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="FMT" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigFreeText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="maxRestrictionUnitsCode" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionUnitsText" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationText" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationCode" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="doseCompositeIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseQuantity" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMText" select="'color:red; font-style:italic'"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
				<br/>
				<xsl:for-each select="//DRU/DRU.1/DRU.1.1[. = 'D']/../..">
					<xsl:variable name="pos" select="position()"/>
					<xsl:call-template name="medicationInfo_D">
						<xsl:with-param name="desc" select="'Dispensed Drug'"/>
						<xsl:with-param name="drug" select="."/>
						<xsl:with-param name="itemDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="drugDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="quantity" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="codeListQualifier" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="sourceCodeList" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="potencyUnitCode" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="directions" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="writtenDate" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="date" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="formatQualifier" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="refills" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="clinicalInformation" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ICD" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="days" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ZDS" select="'color:green; text-decoration:underline'"/>
					</xsl:call-template>
					<br/>
					<xsl:for-each select="./following-sibling::SIG[count(preceding-sibling::DRU/DRU.1/DRU.1.1[. = 'D']) = $pos]">
						<xsl:call-template name="structuredSIG">
							<xsl:with-param name="sig" select="."/>
							<xsl:with-param name="drugName" select="'for Dispensed Drug'"/>
							<xsl:with-param name="sigSequence" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="snomedVersion" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="FMT" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigFreeText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="sigIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="maxRestrictionUnitsCode" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionUnitsText" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="maxRestrictionNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationText" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationCodeQualifier" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="durationCode" select="'color:green; text-decoration: underline;'"/>
							<xsl:with-param name="durationNumericValue" select="'color:green;  text-decoration: underline;'"/>
							<xsl:with-param name="doseCompositeIndicator" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseDeliveryCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseFormCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="doseQuantity" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indPrecursorText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indText" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indTextCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCode" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMCodeQualifier" select="'color:red; font-style:italic'"/>
							<xsl:with-param name="indUMText" select="'color:red; font-style:italic'"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
				<br/>
				<xsl:call-template name="instructions"/>
			</xsl:when>
			<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -For Medication  History - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - -   - -->
			<xsl:when test="$message-type = $RXHRES">
				<xsl:call-template name="messageHeader">
					<xsl:with-param name="title" select="'Medication History Response'"/>
					<xsl:with-param name="note">
						<p>This Test Case-specific Juror Document provides a checklist for the
                            Tester to use during certification testing for assessing the EHR
                            technology&apos;s ability to display required core data elements from
                            the information received in the eRx message. Additional data from the
                            message or from the EHR are permitted to be displayed by the EHR.
                            Grayed-out fields in the Juror Document indicate where no data for that
                            data element were included in the message for the given Test Case.</p>
						<p>The format of this Juror Document is for ease-of-use by the Tester and
                            does not indicate how the EHR display must be designed.The column
                            headings are meant to convey the kind of data to be displayed;
                            equivalent labels/column headings are permitted to be displayed by the
                            EHR. The column headings marked in <b>
								<i>
									<font color="red">bold red
                                        italics</font>
								</i>
							</b> indicate the required fields,
                                        <b>
								<u>
									<font color="green">bold green
                                underlined</font>
								</u>
							</b> column headings indicate required fields
                            when composite is used, column headings with <b>*(asterisk)</b> indicate
                            fields present in EDI but not in XML and column headings in <b>bold
                                black</b> indicate the conditional fields.</p>
						<p>The EHR is permitted to display data that are equivalent to the data
                            shown in the Juror Document for both the required fields and conditional
                            fields. Each code that appears in the message is displayed with its
                            associated description in the Juror Document. The code&apos;s
                            descriptions are not part of the message. The column headings that are
                            labeled with &quot;(cont)&quot; in the Juror Document represent field(s)
                            from the message where it could be expected continuation of Test Case
                            data, when full verbiage of Test Case data cannot fit specific field(s)
                            in the message due to its character limitation. </p>
					</xsl:with-param>
				</xsl:call-template>
				<table>
					<thead>
						<tr>
							<th colspan="3">Medication History Response Type</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th style="color:red; font-style:italic">Response Type<span style="color:black">*</span>
							</th>
							<th>Denial Reason</th>
							<th>Tester Comment</th>
						</tr>
						<tr>
							<xsl:copy-of select="util:formatData(util:response(normalize-space(//RES/RES.1/RES.1.1)), 0)"/>
							<xsl:copy-of select="util:formatData(//RES/RES.4/RES.4.1, 0)"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<td colspan="3">When Denied is used, DenialReasonCode (XML)/Code List Qualifier(EDI), DenialReason (XML)/Free text (EDI) or both must be populated. </td>
						</tr>
					</tbody>
				</table>
				<br/>
				<xsl:call-template name="patientInfo">
					<xsl:with-param name="pttSegment" select="//PTT"/>
					<xsl:with-param name="pPhone" select="'color:green; text-decoration:underline'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="providerInfo">
					<xsl:with-param name="provider" select="//RES/following-sibling::PVD[PVD.1/PVD.1.1[. = 'PC']][1]"/>
					<xsl:with-param name="phone" select="'color:green; text-decoration:underline'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="pharmacyInfo">
					<xsl:with-param name="pharmacy" select="//RES/following-sibling::PVD[PVD.1/PVD.1.1[. = 'P2']][1]"/>
					<xsl:with-param name="phone" select="'color:green; text-decoration:underline'"/>
				</xsl:call-template>
				<br/>
				<xsl:for-each select="//DRU">
					<xsl:variable name="pos" select="position()"/>
					<xsl:call-template name="medicationInfo_D">
						<xsl:with-param name="desc" select="concat('Dispensed Drug', '[', $pos, ']')"/>
						<xsl:with-param name="drug" select="."/>
						<xsl:with-param name="itemDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="drugDesc" select="'color:red; font-style:italic'"/>
						<xsl:with-param name="quantity" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="codeListQualifier" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="sourceCodeList" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="potencyUnitCode" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="writtenDate" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="date" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="formatQualifier" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="refills" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="clinicalInformation" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ICD" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="ZDS" select="'color:green; text-decoration:underline'"/>
						<xsl:with-param name="days" select="'color:green; text-decoration:underline'"/>
					</xsl:call-template>
					<xsl:call-template name="providerInfo">
						<xsl:with-param name="provider" select="./following-sibling::PVD[PVD.1/PVD.1.1[. = 'PC']][count(preceding-sibling::DRU) = $pos]"/>
						<xsl:with-param name="phone" select="'color:green; text-decoration:underline'"/>
					</xsl:call-template>
					<xsl:call-template name="pharmacyInfo">
						<xsl:with-param name="pharmacy" select="./following-sibling::PVD[PVD.1/PVD.1.1[. = 'P2']][count(preceding-sibling::DRU) = $pos]"/>
						<xsl:with-param name="phone" select="'color:green; text-decoration:underline'"/>
					</xsl:call-template>
					<br/>
				</xsl:for-each>
				<xsl:call-template name="coo">
					<xsl:with-param name="coo" select="//COO"/>
					<xsl:with-param name="cardID" select="'color:green; text-decoration:underline'"/>
					<xsl:with-param name="effectiveDate" select="'color:green; text-decoration:underline'"/>
					<xsl:with-param name="date" select="'color:green; text-decoration:underline'"/>
					<xsl:with-param name="formatQualifer" select="'color:green; text-decoration:underline'"/>
					<xsl:with-param name="expirationDate" select="'color:green; text-decoration:underline'"/>
				</xsl:call-template>
				<br/>
				<xsl:call-template name="instructions"/>
			</xsl:when>
			<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -Status Message - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  - - - - - - -  -->
			<xsl:when test="$message-type = $STATUS">
				<xsl:call-template name="messageHeader">
					<xsl:with-param name="title" select="'Return an Acknowledgement'"/>
					<xsl:with-param name="note">This Test Case-specific Juror Document provides a
                        checklist for the Tester to use during certification testing for assessing
                        the health information technology&apos;s ability to receive and process a
                        STATUS message. A STATUS message is used to relay acceptance of a
                        transaction back to the sender. A STATUS in response to REFREQ, REFRES,
                        NEWRX, RXCHG, CHGRES, CANRX, CANRES, or RXFILL indicates acceptance and
                        responsibility for a request. The exact wording and format of the display in
                        the health information technology (HIT) is not in-scope for this
                        test.</xsl:with-param>
				</xsl:call-template>
				<table>
					<thead>
						<tr>
							<th>Return an Acknowledgement</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<p>The receiving HIT system being tested shall process the STATUS
                                    message correctly; a positive notification indicating that the
                                    STATUS message was processed correctly need not be made visible
                                    in the system.</p>
							</td>
						</tr>
						<tr>
							<th align="left">STATUS Message</th>
						</tr>
						<tr>
							<td>
								<p>
									<xsl:value-of select="//STS/STS.1/STS.1.1"/> - <xsl:value-of select="//STS/STS.3/STS.3.1"/>
								</p>
							</td>
						</tr>
					</tbody>
				</table>
			</xsl:when>
			<!--  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  Cancel Response- - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
			<xsl:when test="$message-type = $CANRES">
				<xsl:call-template name="messageHeader">
					<xsl:with-param name="title" select="'Cancel Response'"/>
					<xsl:with-param name="note">
						<p>This Test Case-specific Juror Document provides a checklist for the
                            Tester to use during certification testing for assessing the health
                            information technology&apos;s ability to receive and process a CANCEL
                            message. The column headings are meant to convey the kind of data to be
                            displayed; equivalent labels/column headings are permitted to be
                            displayed by the EHR.</p>
						<p>The column headings marked in <b>
								<i>
									<font color="red">bold red
                                        italics</font>
								</i>
							</b> indicate the required fields, column
                            headings with <b>*(asterisk)</b> indicate fields present in EDI but not
                            in XML and column headings in <b>bold black</b> indicate the conditional
                            fields. The EHR is permitted to display data that are equivalent to the
                            data shown in the Juror Document for both the required fields and
                            conditional fields. Each code that appears in the message is displayed
                            with its associated description in the Juror Document. The code&apos;s
                            descriptions are not part of the message.</p>
					</xsl:with-param>
				</xsl:call-template>
				<table>
					<thead>
						<tr>
							<th colspan="4">Cancel Response Type</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th style="color:red; font-style:italic">Response Type<span style="color:black">*</span>
							</th>
							<th>Code List Qualifier</th>
							<th>Approve/Denial Explanation</th>
							<th>Tester Comment</th>
						</tr>
						<tr>
							<xsl:copy-of select="util:formatData(util:response(normalize-space(//RES/RES.1/RES.1.1)), 0)"/>
							<xsl:choose>
								<xsl:when test="//RES/RES.2/RES.2.1 = 'AC'">
									<xsl:copy-of select="util:formatData('AC - Patient no longer under Provider care', 0)"/>
								</xsl:when>
								<xsl:when test="//RES/RES.2/RES.2.1 = 'AA'">
									<xsl:copy-of select="util:formatData('AA - Patient unknown to Provider', 0)"/>
								</xsl:when>
								<xsl:when test="//RES/RES.2/RES.2.1 = 'AB'">
									<xsl:copy-of select="util:formatData('AB - Patient never under Provider care', 0)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:copy-of select="util:formatData(//RES/RES.2/RES.2.1, 0)"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:copy-of select="util:formatData(//RES/RES.4/RES.4.1, 0)"/>
							<xsl:call-template name="commentTemplate"/>
						</tr>
						<tr>
							<td colspan="4">When Denied is used, DenialReasonCode (XML)/Code List Qualifier(EDI), DenialReason (XML)/Free text (EDI) or both must be populated.
                            </td>
						</tr>
					</tbody>
				</table>
				<br/>
				<xsl:call-template name="instructions"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="messageHeader">
					<xsl:with-param name="title" select="'Juror Document'"/>
					<xsl:with-param name="note">No Juror Document available to Display for the
                        specified test case.</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*">
		<html>
			<head>
				<xsl:call-template name="jurorAppearance"/>
			</head>
			<body>
				<div class="jurordocument">
					<xsl:call-template name="_main"/>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
