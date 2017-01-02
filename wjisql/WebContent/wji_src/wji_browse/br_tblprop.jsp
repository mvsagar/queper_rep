<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
     Copyright 2006-2017 Vidyasagar Mundroy

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
 --- Function: Displays properties of given database table/view. 
 -->
 
<HTML>
<HEAD>
<TITLE>Table Properties</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	<link rel="stylesheet" type="text/css" media="all" href="../wji_css/style.css" />
	
    <!-- Third party code to allow nice formatting of html table columns and sorting of html table data. -->
	<script type="text/javascript" src="../wji_js/prototype.js"></script>
	<script type="text/javascript" src="../wji_js/fabtabulous.js"></script>
	<script type="text/javascript" src="../wji_js/tablekit.js"></script>    	
	<script type="text/javascript">
		TableKit.Sortable.addSortType(new TableKit.Sortable.Type('status', {
				pattern : /^[New|Assigned|In Progress|Closed]$/,
				normal : function(v) {
					var val = 4;
					switch(v) {
						case 'New':
							val = 0;
							break;
						case 'Assigned':
							val = 1;
							break;
						case 'In Progress':
							val = 2;
							break;
						case 'Closed':
							val = 3;
							break;
					}
					return val;
				}
			}
		));

		/*
		TableKit.options.editAjaxURI = '../wji_echo/';
					
		TableKit.Editable.multiLineInput('title');
		
		var _tabs = new Fabtabs('tabs');
		$$('a.next-tab').each(function(a) {
			Event.observe(a, 'click', function(e){
				Event.stop(e);
				var t = $(this.href.match(/#(\w.+)/)[1]+'-tab');
				_tabs.show(t);
				_tabs.menu.without(t).each(_tabs.hide.bind(_tabs));
			}.bindAsEventListener(a));
			
		});
		*/
	</script>
</HEAD>
<BODY>

<%@include file="../wji_common/imports.jsp"%>
<%@include file="../wji_common/connvars.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>

<% java.sql.ResultSet rs; 
	java.sql.DatabaseMetaData md; 
	java.sql.ResultSetMetaData rsmd;
	
	int nRows = 0;
	String tmpValue = null;
%>

<% 
   String tableName = request.getParameter("table_name"); 
   String objType = request.getParameter("obj_type"); 
   String schemaName = request.getParameter("schema_name"); 
   String sqlStmt = "";
%>     

<FORM METHOD="POST">
<% 
   if (connNo == 0 && conn == null || connNo == 1 && conn1 == null || connNo == 2 && conn2 == null) {
       out.print("<BR><BR><BR>");
       out.print("<P ALIGN=CENTER>No active database connection exists.</P>");
       out.print("<P ALIGN=CENTER>Connect to a database first and try again.</P>");
       return;
   }

   if (tableName == null) { 
       out.print("<BR><BR><BR>");
       out.print("<P>Select a <B>table</B> from the list of tables, if exist, in the left pane.</P>");
   } else {
	
   try {
     if (connNo == 1) {
         md = conn1.getMetaData(); 
     } else if (connNo == 2) {
         md = conn2.getMetaData(); 
     } else {
         md = conn.getMetaData(); 
     }
    if (md.supportsSchemasInDataManipulation() == true)
        sqlStmt = "SELECT * FROM " + schemaName + "." + tableName; 
    else
        sqlStmt = "SELECT * FROM " + tableName;

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

<H3>Table Properties: Columns</H3>

<%@include file="../wji_browse/br_tblprop_buttons.jsp" %> 

<% if (tableName == null) { %>
        <SPAN  STYLE="FONT-SIZE:10pt;FONT-WEIGHT:BOLD;">Columns of all tables:</SPAN>
<% } else { %>
        <SPAN STYLE="FONT-SIZE:10pt;FONT-WEIGHT:BOLD;">Columns:</SPAN>
<% } %>

<TABLE ALIGN="LEFT"  class="sortable resizable" >
<tr STYLE="BACKGROUND:SEAGREEN;">
<% try {
     rs = md.getColumns(null, schemaName, tableName, null);
     rsmd = rs.getMetaData(); 
     int nCols = rsmd.getColumnCount(); 
%>    
     <TH class="sortfirstasc" >
	    <!-- W_20160104_36 -->
	    <INPUT TYPE="TEXT" NAME= "vsnor0c0" VALUE="SNO" SIZE=4 READONLY
	    STYLE="BACKGROUND:SEAGREEN;COLOR:WHITE;BORDER-STYLE:NONE;FONT:BOLD;FONT-SIZE:12pt;"> 
 	</TH>
<% 
     // Print heading for table columns 
     for (int i = 4; i <= nCols; i++) { %>
        <TH>
            <%= rsmd.getColumnLabel(i) %>
		</TH>
     <% } %>
	</tr>
    <%-- Print Columns of the given table. --%>
    <% 
    	nRows = 0;
    	while (rs.next()) {
    		++nRows;
    %>
        <TR>
        <TD   STYLE="BACKGROUND:LIGHTGRAY;"><%=nRows%></TD>	   
	    <% for (int i = 4; i <= nCols; i++) {
  			tmpValue = rs.getString(i); 
  			if (rs.wasNull()) {
  				tmpValue = "(NULL)";
  			}
	    	
	    %>
            <TD   STYLE="BACKGROUND:IVORY;">
            	<%=tmpValue %>
	        </TD>
        <% } %>
	</TR>
     <% } 
    rs.close(); 

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
</TABLE>

<BR CLEAR=LEFT>
   <%@include file="../wji_browse/br_tblprop_buttons.jsp" %> 
<% } // else of if tableName == null 
%>

<SCRIPT LANGUAGE="JavaScript">

function select_rows(form)
{
   form.action = "../wji_sqlstmts/ss_results.jsp?conn_no=<%=connNo%>"
	   + "&schema_name=<%=schemaName%>"
	   + "&table_name=<%=tableName%>"
	   + "&obj_type=<%=objType%>"
	   + "&sqlstmt=<%=sqlStmt%>"
	   ;
   form.target = "_self";
   // alert(form.action);
   form.submit();   
}

function list_keys(form)
{
   form.action = "../wji_browse/br_tblindexes.jsp?conn_no=<%=connNo%>"
	   + "&schema_name=<%=schemaName%>"
	   + "&table_name=<%=tableName%>"
	   + "&obj_type=<%=objType%>"
	   + "&sqlstmt=<%=sqlStmt%>"
	   ;
   form.target = "_self";
   form.submit();   
}

function drop_table(form)
{
    if (confirm("Do you really want drop the <%=objType%> <%="'"+tableName+"'"%>?")) {
	    form.action = "br_execdrop.jsp"
		    + "?conn_no=<%=connNo%>"
		    + "&schema_name=<%=schemaName%>"
		    + "&obj_type=<%=objType.toLowerCase()%>"
		    + "&obj_name=<%=tableName%>"
		    + "&sqlstmt=<%=sqlStmt%>";
        form.target = "_self";
        form.submit();   
    }
}


function display_help(form)
{
   form.action = "../wji_help/he_tblprop.jsp";
   form.target = "_blank";
   form.submit();   
}
</SCRIPT>
</FORM>
</BODY>
</HTML>

