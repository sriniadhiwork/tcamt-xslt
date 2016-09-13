<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	

	<!-- css template to be output in the head for html outputs -->
	<!-- contains style for graying out and separator -->
	<xsl:template name="css">
		<style type="text/css">
			@media screen {
			.test-story-main legend {text-align:center;font-size:110%; font-weight:bold;}					
			.test-story-main .nav-tabs {font-weight:bold;}					
			.test-story-main .tds_obxGrpSpl {background:#B8B8B8;}
			.test-story-main maskByMediaType {display:table;}
			.test-story-main table tbody tr th {font-size:95%}
			.test-story-main table tbody tr td {font-size:100%;}
			.test-story-main table tbody tr th {text-align:center;background:#C6DEFF}
			.test-story-main fieldset {text-align:center;}
			.test-story-main table { width:98%;border: 1px groove;table-layout: fixed; margin:0 auto;border-collapse: collapse;}
			.test-story-main table  tr { border: 3px groove; }
			.test-story-main table  th { border: 2px groove;}
			.test-story-main table  td { border: 2px groove; }
			.test-story-main table thead {border: 1px groove;background:#446BEC;text-align:center;}
			.test-story-main .separator {background:rgb(240, 240, 255); text-align:left;}
			.test-story-main table tbody tr td {text-align:left}
			.test-story-main .noData {background:#B8B8B8;}
			.test-story-main .childField {background:#B8B8B8;}
			.test-story-main .title {text-align:left;}
			.test-story-main h3 {text-align:center;page-break-inside: avoid;}
			.test-story-main h2 {text-align:center;}
			.test-story-main h1 {text-align:center;}
			.test-story-main .pgBrk {padding-top:15px;}
			.test-story-main .er7Msg {width:100%;}
			.test-story-main .embSpace {padding-left:15px;}			
			.test-story-main .accordion-heading { font-weight:bold; font-size:90%;}										
			.test-story-main .accordion-heading i.fa:after { content: "\00a0 "; }									
			.test-story-main  panel { margin: 10px 5px 5px 5px; }
			}
			
			@media print {
			.test-story-main legend {text-align:center;font-size:110%; font-weight:bold;}					
			.test-story-main .nav-tabs {font-weight:bold;}					
			.test-story-main .obxGrpSpl {background:#B8B8B8;}
			.test-story-main maskByMediaType {display:table;}
			.test-story-main table tbody tr th {font-size:90%}
			.test-story-main table tbody tr td {font-size:90%;}
			.test-story-main table tbody tr th {text-align:left;background:#C6DEFF}
			.test-story-main table thead tr th {text-align:center;background:#4682B4}
			.test-story-main fieldset {text-align:center;page-break-inside: avoid;}
			.test-story-main table { width:98%;border: 1px groove;table-layout: fixed; margin:0 auto;page-break-inside: avoid;border-collapse: collapse;}
			.test-story-main table  tr { border: 3px groove; }
			.test-story-main table  th { border: 2px groove;}
			.test-story-main table  td { border: 2px groove; }
			.test-story-main table thead {border: 1px groove;background:#446BEC;text-align:left;}
			.test-story-main .separator {background:rgb(240, 240, 255); text-align:left;}
			.test-story-main table tbody tr td {text-align:left;}
			.test-story-main .noData {background:#B8B8B8;}
			.test-story-main .childField {background:#B8B8B8;}
			.test-story-main .tds_title {text-align:left;margin-bottom:1%}
			.test-story-main h3 {text-align:center;}
			.test-story-main h2 {text-align:center;}
			.test-story-main h1 {text-align:center;}
			.test-story-main .tds_pgBrk {page-break-after:always;}
			.test-story-main #er7Message table {border:0px;width:80%}
			.test-story-main #er7Message td {background:#B8B8B8;font-size:65%;margin-top:6.0pt;border:0px;text-wrap:preserve-breaks;white-space:pre;}
			.test-story-main .er7Msg {width:100%;font-size:80%;}
			.test-story-main .er7MsgNote{width:100%;font-style:italic;font-size:80%;}
			.test-story-main .embSpace {padding-left:15px;}
			.test-story-main .embSubSpace {padding-left:25px;}
			.test-story-main .accordion-heading { font-weight:bold; font-size:90%; }										
			.test-story-main .accordion-heading i.fa:after { content: "\00a0 "; }									
			.test-story-main  panel { margin: 10px 5px 5px 5px; }
			}
		</style>
	</xsl:template>
	
</xsl:stylesheet>
