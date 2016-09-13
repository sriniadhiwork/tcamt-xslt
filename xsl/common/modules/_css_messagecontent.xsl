<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	

	<!-- css template to be output in the head for html outputs -->
	<!-- contains style for graying out and separator -->
	<xsl:template name="css">
		<style type="text/css">
                     @media screen {
					.message-content legend {text-align:center;font-size:110%; font-weight:bold;}					
					.message-content .nav-tabs {font-weight:bold;}					
					.message-content fieldset {text-align:center;}
                    .message-content maskByMediaType {display:table;}
					.message-content table tbody tr th {font-size:95%}
					.message-content table tbody tr td {font-size:100%;}
					.message-content table tbody tr th {text-align:left;background:#436BEC}
					.message-content table thead tr th {text-align:center;}
					.message-content table thead tr th:first-child {width:15%;}
					.message-content table thead tr th:nth-child(2) {width:30%;}
					.message-content table thead tr th:nth-child(3) {width:30%;}
					.message-content table thead tr th:last-child {width:20%;}
					.message-content table { width:98%;border: 1px groove;table-layout: fixed; margin:0 auto;border-collapse: collapse;}
					.message-content table  tr { border: 3px groove; }
					.message-content table  th { border: 2px groove;}
					.message-content table  td { border: 2px groove; }
					.message-content table thead {border: 1px groove;background:#436BEC;text-align:left;}
					.message-content table tbody tr td {text-align:left}
					.message-content  .Field  { font: bold; background-color: rgb(198, 222, 255); }
					.message-content  td.Component {padding-left:15px;}
					.message-content  td.SubComponent {padding-left:25px;}
					.message-content  td.Field + td.noData {background:rgb(198, 222, 255);}
					.message-content  td.noData {background:#B8B8B8;}
					.message-content .accordion-heading { font-weight:bold; font-size:90%; }	
					.message-content .accordion-heading i.fa:after { content: "\00a0 "; }									
					.message-content  panel { margin: 10px 5px 5px 5px; }
                    }
                    @media print {
					.message-content legend {text-align:center;font-size:110%; font-weight:bold;}					
					.message-content .nav-tabs {font-weight:bold;}					
					.message-content  {text-align:center;page-break-inside: avoid;}
                    .message-content maskByMediaType {display:table;}
                    .message-content  table tbody tr th {font-size:80%}
                    .message-content  table tbody tr td {font-size:70%;}
                    .message-content  table tbody tr th {text-align:left;background:#436BEC}
                    .message-content  table thead tr th {text-align:center;font-size:80%;}
                    .message-content  legend {text-align:center;font-size:70%;}
                    .message-content  table thead tr th:first-child {width:15%;}
                    .message-content  table thead tr th:nth-child(2) {width:30%;}
                    .message-content  table thead tr th:nth-child(3) {width:30%;}
                    .message-content  table thead tr th:last-child {width:20%;}
					.message-content  table { width:98%;border: 1px groove;table-layout: fixed; margin:0 auto;border-collapse: collapse;page-break-inside: avoid;}
                    .message-content  table  tr { border: 3px groove; }
                    .message-content  table  th { border: 2px groove;}
                    .message-content  table  td { border: 2px groove; }
                    .message-content  table thead {border: 1px groove;background:#436BEC;text-align:left;}
                    .message-content  table tbody tr td {text-align:left}
					.message-content  .Field  { font: bold; background-color: rgb(198, 222, 255); }
                    .message-content  .Component {padding-left:10px;}
                    .message-content  .SubComponent {padding-left:20px;}
                    .message-content td.noData {background:#B8B8B8;}
					.message-content  td.noData {background:rgb(198, 222, 255);;}
					.message-content .accordion-heading { font-weight:bold;  font-size:90%; }										
					.message-content .accordion-heading i.fa:after { content: "\00a0 "; }									
					.message-content  panel { margin: 10px 5px 5px 5px; }
                    }
                    @page {
                    counter-increment: page;
					@bottom-center {
                    content: "Page " counter(page);
                    }
                    }
                    @page :left {
                    margin-left: 5%;
                    margin-right: 5%;
                    }
                    @page :right {
                    margin-left: 5%;
                    margin-right: 5%;
                    }
		</style>
	</xsl:template>
	
</xsl:stylesheet>
