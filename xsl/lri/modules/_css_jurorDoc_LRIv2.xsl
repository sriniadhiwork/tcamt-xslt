<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	
	
    <xsl:template name="jurorAppearance">
        <style type="text/css">
            @media screen{
                .jurorContainer fieldset{
                    font-size:100%;
                }
                .jurorContainer fieldset table tbody tr th{
                    font-size:90%
                }
                .jurorContainer fieldset table tbody tr td{
                    font-size:90%;
                }
            }
            @media print{
                .jurorContainer fieldset{
                    font-size:small;
                }
                .jurorContainer fieldset table th{
                    font-size:x-small;
                }
                .jurorContainer fieldset table td{
                    font-size:xx-small
                }
                * [type = text]{
                    width:98%;
                    height:15px;
                    margin:2px;
                    padding:0px;
                    background:1px #ccc;
                }
            
                .jurorContainer * [type = checkbox]{
                    width:10px;
                    height:10px;
                    margin:2px;
                    padding:0px;
                    background:1px #ccc;
                }
                
                
                .jurorContainer fieldset table tr {
                           page-break-inside: avoid;
            }
 
            }
            
            
            .jurorContainer * [type = text]{
                width:95%;
            }
            
            .jurorContainer fieldset{
                page-break-inside:avoid;
            }
            .jurorContainer fieldset table{
                width:98%;
                border:1px black groove;
                margin:0 auto;
                page-break-inside:avoid;
            }
            .jurorContainer fieldset table tr{
                border:1px black groove;
            }
            .jurorContainer fieldset table th{
                border:1px black groove;
            }
            .jurorContainer fieldset table td{
                border:1px black groove;
                empty-cells:show;
            }
            .jurorContainer fieldset table[id = inspectionStatus] thead tr th:last-child{
                width:2%;
                color:black;
            }
            .jurorContainer fieldset table[id = inspectionStatus] thead tr th:nth-last-child(2){
                width:2%;
                color:black;
            }
            .jurorContainer fieldset table[id = inspectionStatus] thead tr th:nth-last-child(3){
                width:45%;
            }
            .jurorContainer fieldset table thead{
                border:1px groove;
                background:#446BEC;
                text-align:center;
                color:white;
            }
            .jurorContainer fieldset table thead tr td{
                text-align:left;
                color:black;
                background:white;
            }
            .jurorContainer fieldset table tbody tr th{
                text-align:left;
                background:#C6DEFF;
            }
            .jurorContainer fieldset table tbody tr td{
                text-align:left
            }
            .jurorContainer fieldset table tbody tr td [type = text]{
                text-align:left;
                margin-left:1%
            }
            .jurorContainer fieldset table caption{
                font-weight:bold;
                color:#0840F8;
            }
            .jurorContainer fieldset legend{
                font-weight:bold;
            }
            .jurorContainer fieldset pre{
                font-family:Times New Roman;
            }
            .jurorContainer fieldset p{
                text-align:left;
            }
            .jurorContainer fieldset{
                width:98%;
                border:1px solid #446BEC;
            }
            .jurorContainer .embSpace{
                padding-left:25px;
            }
            .jurorContainer .noData{
                background:#B8B8B8;
            }
            .jurorContainer .boldItalic{
                font-style:italic;
                font-weight:bold;
                color:black;
            }
            .jurorContainer .bold{
                font-weight:bold;
                color:red;
            }
            .jurorContainer .normal{
                font-weight:normal;
            }
            .addSpace{
                height:20px;
            }
            }</style>
        <script type="text/javascript">
            
            
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
            
            
            });
            
            }
        </script>
    </xsl:template>


</xsl:stylesheet>
