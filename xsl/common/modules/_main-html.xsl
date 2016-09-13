<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<!-- main-html:  create a html with head, css and javascript to navigate through the json created by 'main' template  -->
	<!-- the jquery-tab-html depends on jquery -->
	<!-- the code to include message-content and test-story are commented out -->
	<!-- apart from creating the json using "main" template, it calls "test-data-specs" template to generate javascript code -->
	
	<xsl:template name="main-html">
		<html>
			<head>
			<xsl:if test="$output = 'jquery-tab-html'">
				<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
				<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
				<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
			</xsl:if>

			<xsl:call-template name="css"></xsl:call-template>
				
			<script>
				var data = 
				<xsl:call-template name="main"></xsl:call-template>;
				
				var full = '', html = '';
				
				<xsl:if test="$output = 'jquery-tab-html'">
					$(function() { $( "#test-data-tabs" ).tabs();	});
				</xsl:if>
				
				document.write('<div class="test-data-specs-main">');
					
				/* if we wanted to generate the root tab structure include this code
				$(function() { $( "#test-tabs" ).tabs();	});
					
				document.write('<div id="test-tabs">');
				document.write('<ul>');
				document.write('<li><a href="#test-tabs-0">Test Story</a></li>');
				document.write('<li><a href="#test-tabs-1">Test Data Specification</a></li>');
				document.write('<li><a href="#test-tabs-2">Message Content</a></li>');
				document.write('</ul>'); 
				*/
				
				<!-- xsl:call-template name="test-story"></xsl:call-template -->
				<xsl:call-template name="test-data-specs"></xsl:call-template>
				<!-- xsl:call-template name="message-content"></xsl:call-template -->
					
				document.write('</div>');	
				document.write('</div>');	
			</script>
			</head>
			<body>
			</body>
		</html>								
	</xsl:template>

	<!-- test-story tab: not used -->
	<xsl:template name="test-story">
		document.write('<div id="test-tabs-0">');
		document.write(' ............. Test .......... Story................... ');
		document.write('</div>');
	</xsl:template>

	<!-- message-content tab: not used -->
	<xsl:template name="message-content">
		document.write('<div id="test-tabs-2">');
		document.write(' ............. Message .......... Content................... ');
		document.write('</div>');
	</xsl:template>
	
	<!-- test-data-specs:  Called from main-html, this contains all the javascript navigation and creating html -->
	<xsl:template name="test-data-specs">
		
		<!-- if jquery-tab-html create full div and a div for each tab; otherwise generate only the FULL div containing all the tables -->
		document.write('<div id="test-tabs-1">');
		document.write('<div id="test-data-tabs">');
			<xsl:if test="$output = 'jquery-tab-html'">
				document.write('<ul>');
				document.write('<li><a href="#test-data-tabs-0">FULL</a></li>');
				for(var key in data.tables) {
					document.write('<li><a href="#test-data-tabs-' + (key+1) + '">' + data.tables[key].title + '</a></li>');
				}	
				document.write('</ul>');
			</xsl:if>
		
			<!-- each table is under a div test-data-tabs-nn -->
			for(var key in data.tables) {
			    var tab = '';
			    tab += '<div id="test-data-tabs-' + (key+1) + '">';
				var table = data.tables[key];
				tab += ('<fieldset><legend>' + table.title + 
					'</legend> <table> <tr> <th> Element </th> <th> Data </th> </tr>'); 

				for (var elkey in table.elements) {
					element = table.elements[elkey];
					// display obxs as separate table
					if (element.element == 'obx') {
							var obx = element.data;
							tab += '</table></fieldset>'; // end the bigger table
							tab += ('<fieldset><table> <tr> <th colspan="2"> ' + obx.title + '</th> </tr>'); 
							for (var obxkey in obx.elements) {
								if (obx.elements[obxkey].element == "") { // gray line
									tab += '<tr class="obxGrpSpl"><td colspan="2"></td></tr>';
								} 						
								else {
									tab += ('<tr><td>' + obx.elements[obxkey].element + '</td><td>' + obx.elements[obxkey].data + '</td></tr>');
								}
							}
					}
					else {
						var tdclass = element.data == '' ? "noData" : "data"; 
						tab += ('<tr><td>' + element.element + '</td><td class="' + tdclass + '">' + element.data + '</td></tr>');
					}
				}
				
				tab += '</table></fieldset>';
				tab += '</div>';

				<!-- output individual tabs only if the output is jquery-tab-html; otherwise collect all of them and output only once -->
				<xsl:if test="$output = 'jquery-tab-html'">
					document.write(tab);
				</xsl:if>
				
				<!-- full tab is nothing but sum of all other tabs -->
				full += tab; 
			} 					
			
			<!-- full tab: test-data-tabs-0 div -->
			document.write('<div id="test-data-tabs-0"> ' + full + '</div>');
			document.write('</div>');
			document.write('</div>'); 
	</xsl:template>

</xsl:stylesheet>
