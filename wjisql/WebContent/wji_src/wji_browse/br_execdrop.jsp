<!-- 
     Copyright 2006-17, QuePer 

     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
-->

<!--
---- Function: Executes an SQL DROP statement to drop a database object such as a table, a view 
----           or a procedure.
-->

<HTML>
<HEAD>
<TITLE>Drop Object</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY>

<FORM METHOD="POST" NAME="execdropform">

<%-- Connect to the database --%>
<%@include file="../wji_common/imports.jsp"%>
<%@include file="../wji_common/connvars.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>
<% 
   String objName = request.getParameter("obj_name"); 
   String objType = request.getParameter("obj_type"); 
   String schemaName = request.getParameter("schema_name"); 

   java.sql.Statement stmt;
   java.sql.Connection connX;

   if (connNo == 0 && conn == null || connNo == 1 && conn1 == null || connNo == 2 && conn2 == null) {
       out.print("<BR><BR><BR>");
       out.print("<P ALIGN=CENTER>No active database connection exists.</P>");
       out.print("<P ALIGN=CENTER>Connect to a database first and try again.</P>");
       return;
    }
    connX = connNo == 0 ? conn : (connNo == 1 ? conn1 : conn2);
   try {
      stmt = connX.createStatement(); 
      if (connX.getMetaData().supportsSchemasInDataManipulation() == true)      
         stmt.executeUpdate("DROP " + objType + " " +  schemaName + "." + objName);
      else
         stmt.executeUpdate("DROP " + objType + "  " + objName);
      stmt.close();
  } catch (java.sql.SQLException se) { 
%>

        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
        </SCRIPT>
<%
     return;
   }	   
%>

<SCRIPT LANGUAGE="JavaScript">
/* Refresh required data frame to reflect effect of dropping database object. */
if (<%=connNo%> == 1) {
    execdropform.action = "../wji_transfer/tr_tbllist.jsp?conn_no=<%=connNo%>";
    execdropform.target = "leftdatafr1";
} else if (<%=connNo%> == 2) {
    execdropform.action = "../wji_transfer/tr_tbllist.jsp?conn_no=<%=connNo%>";
   execdropform.target = "leftdatafr2";
} else {
    if ("<%=objType.toLowerCase()%>" == "procedure" || "<%=objType.toLowerCase()%>" == "function") {
        execdropform.action = "../wji_browse/br_proclist.jsp?conn_no=<%=connNo%>&schema_name=<%=schemaName%>";
    } else {
        execdropform.action = "../wji_browse/br_tbllist.jsp?conn_no=<%=connNo%>&schema_name=<%=schemaName%>";
    }
   execdropform.target = "leftdatafr";
}
execdropform.submit();
</SCRIPT>

</FORM>
</BODY>
</HTML>

