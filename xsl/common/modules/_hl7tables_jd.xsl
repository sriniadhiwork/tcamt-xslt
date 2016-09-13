<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

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
		</Tables>
	</xsl:variable>



</xsl:stylesheet>
