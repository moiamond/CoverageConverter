<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="html" indent="yes"/>
   <xsl:template match="/" >
      <html>
         <head>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">/* */</script>
            <style type="text/css">
               th {
               background-color:#dcdcdc;
               border:solid 1px #a9a9a9;
               text-indent:2pt;
               font-weight:bolder;
               }
               #data {
               text-align: center;
               }
            </style>
 
            <script language="JavaScript" type="text/javascript"  >
 
          function CreateJavescript(){
 
          var fileref=document.createElement('script');
                  fileref.setAttribute("type","text/javascript");
                  //fileref.setAttribute("src", "script1.js");
          document.getElementsByTagName("head")[0].appendChild(fileref);
          }
 
        function toggleDetail(control)
        {
        var ctrlId = $(control).attr('Id');
        $("tr[id='"+ctrlId +"']").toggle();
        }
            </script>
         
            <title>Code Coverage Report</title>
         </head>
         <body onload='CreateJavescript()' >
            <h1>Code Coverage Report</h1>
            <table border="1">
               <tr>
                  <th colspan="3"></th>
                  <th>Name</th>
                  <th>Blocks Covered</th>
                  <th>Blocks Not Covered</th>
                  <th>Coverage</th>
               </tr>
               <xsl:apply-templates select="//CoverageDSPriv/Module" />
            </table>
         </body>
      </html>
   </xsl:template>
  
   <xsl:template match="Module">
      <xsl:variable name="parentId" select="generate-id(./..)" />
      <xsl:variable name="currentId" select="generate-id(.)" />
      <tr id="{$parentId}">
         <td id="{$currentId}"      colspan="3"               onClick="toggleDetail(this)"        onMouseOver="this.style.cursor= 'pointer' ">[+]</td>
         <td><xsl:value-of select="ModuleName" /></td>
         <td id="data"><xsl:value-of select="BlocksCovered" /></td>
         <td id="data"><xsl:value-of select="BlocksNotCovered" /></td>
         <xsl:call-template name="CoverageColumn">
            <xsl:with-param name="covered" select="BlocksCovered" />
            <xsl:with-param name="uncovered" select="BlocksNotCovered" />
         </xsl:call-template>
      </tr>
      <xsl:apply-templates select="NamespaceTable" />
      <tr id="{$currentId}-end" style="display: none;">
         <td colspan="5"></td>
      </tr>
   </xsl:template>
  
   <xsl:template match="NamespaceTable">
      <xsl:variable name="parentId" select="generate-id(./..)" />
      <xsl:variable name="currentId" select="generate-id(.)" />
      <tr id="{$parentId}" style="display: none;">
         <td> - </td>
         <td id="{$currentId}"
               colspan="2"
               onClick="toggleDetail(this)"
               onMouseOver="this.style.cursor= 'pointer' ">[+]</td>
         <td><xsl:value-of select="NamespaceName" /></td>
         <td id="data"><xsl:value-of select="BlocksCovered" /></td>
         <td id="data"><xsl:value-of select="BlocksNotCovered" /></td>
         <xsl:call-template name="CoverageColumn">
            <xsl:with-param name="covered" select="BlocksCovered" />
            <xsl:with-param name="uncovered" select="BlocksNotCovered" />
         </xsl:call-template>
      </tr>
      <xsl:apply-templates select="Class" />
      <tr id="{$currentId}-end" style="display: none;">
         <td colspan="5"></td>
      </tr>
   </xsl:template>
  
   <xsl:template match="Class">
      <xsl:variable name="parentId" select="generate-id(./..)" />
      <xsl:variable name="currentId" select="generate-id(.)" />
      <tr id="{$parentId}" style="display: none;">
         <td> - </td>
         <td> - </td>
         <td id="{$currentId}"
               onClick="toggleDetail(this)"
               onMouseOver="this.style.cursor='pointer' ">[+]</td>
         <td><xsl:value-of select="ClassName" /></td>
         <td id="data"><xsl:value-of select="BlocksCovered" /></td>
         <td id="data"><xsl:value-of select="BlocksNotCovered" /></td>
         <xsl:call-template name="CoverageColumn">
            <xsl:with-param name="covered" select="BlocksCovered" />
            <xsl:with-param name="uncovered" select="BlocksNotCovered" />
         </xsl:call-template>
      </tr>
      <xsl:apply-templates select="Method" />
      <tr id="{$currentId}-end" style="display: none;">
         <td colspan="5"></td>
      </tr>
   </xsl:template>
  
   <xsl:template match="Method">
      <xsl:variable name="parentId" select="generate-id(./..)" />
      <tr id="{$parentId}" style="display: none;">
         <td> -</td>
         <td> - </td>
         <td> - </td>
         <td><xsl:value-of select="MethodName" /></td>
         <td id="data"><xsl:value-of select="BlocksCovered" /></td>
         <td id="data"><xsl:value-of select="BlocksNotCovered" /></td>
         <xsl:call-template name="CoverageColumn">
            <xsl:with-param name="covered" select="BlocksCovered" />
            <xsl:with-param name="uncovered" select="BlocksNotCovered" />
         </xsl:call-template>
      </tr>
   </xsl:template>
  
   <xsl:template name="CoverageColumn">
      <xsl:param name="covered" select="0" />
      <xsl:param name="uncovered" select="0" />
      <td id="data">
         <xsl:variable name="percent"
                              select="($covered div ($covered + $uncovered)) * 100" />
         <xsl:attribute name="style">
            background-color:
            <xsl:choose>
               <xsl:when test="number($percent >= 90)">#86ed60;</xsl:when>
               <xsl:when test="number($percent >= 70)">#ffff99;</xsl:when>
               <xsl:otherwise>#FF7979;</xsl:otherwise>
            </xsl:choose>
         </xsl:attribute>
         <xsl:if test="$percent > 0">
            <xsl:value-of select="format-number($percent, '###.##' )" />%
         </xsl:if>
         <xsl:if test="$percent = 0">
            <xsl:text>0.00%</xsl:text>
         </xsl:if>
      </td>
   </xsl:template>
</xsl:stylesheet>