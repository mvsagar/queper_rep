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
 --- Function: Displays properties of a database procedure/function. 
 -->
<HTML>
<HEAD>
<TITLE>Procedure Properties</TITLE>
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
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>
<%@include file="../wji_common/imports.jsp"%>
<%@include file="../wji_common/connvars.jsp" %>

<FORM METHOD="POST">
<% 
	java.sql.ResultSet rs; 
	java.sql.DatabaseMetaData md; 
 	java.sql.ResultSetMetaData rsmd; 
 
	int nRows = 0;
	
 	Connection connX = null;
 	String dbmsName = "";

 	String procCatalog = null;
	String procSchema = null;
 	String procRemarks = null;
 	int procType = -99;
 	String procTypeInfo = null;
 	String schemaName = null;
 
   String procName = request.getParameter("procname"); 
   String objType = request.getParameter("obj_type"); 

   if (procName == null) { 
%>
	<BR>
	<BR>
	<P>Select a <B>procedure</B> from the list of procedures, if exist, in the left pane.</P>
<% } else {


   if (connNo == 0 && conn == null || connNo == 1 && conn1 == null || connNo == 2 && conn2 == null) {
       out.print("<BR><BR><BR>");
       out.print("<P ALIGN=CENTER>No active database connection exists.</P>");
       out.print("<P ALIGN=CENTER>Connect to a database first and try again.</P>");
       return;
   }

    connX = connNo == 0 ? conn : (connNo == 1 ? conn1 : conn2);
%>

<%
    String schemaNameStrs[] = request.getParameterValues("schema_name");
    if (schemaNameStrs != null) {
        schemaName = schemaNameStrs[0];
    } else {
        schemaName = (String) theSession.getAttribute("schema_name"); 
    }
    if (schemaName == null) {
        try {
            if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_POSTGRESQL)) {
	        schemaName = "public";
            } else if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_SQLITE)) {
	        schemaName = null;
            } else if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_ORACLE)) {
                schemaName = conn.getMetaData().getUserName().toUpperCase();
            } else if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_MSSQLSERVER)) {
                schemaName = "dbo";
            }
        } catch (java.sql.SQLException se) { 
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
        </SCRIPT> 
<%
            return;
        }	      
    } 
   dbmsName = conn.getMetaData().getDatabaseProductName();

   if (dbmsName.equals(DBMS_ORACLE)) {
      schemaName = schemaName.toUpperCase();
   }
   theSession.setAttribute("schema_name", schemaName); 
%>
<H2>Procedure/Function Properties</H2>
<%@include file="br_procprop_buttons.jsp"%>
<%


   try  {
   md = connX.getMetaData(); 
   rs = md.getProcedures(null, schemaName, procName); 
   if (rs != null && rs.next()) {
       procCatalog = rs.getString(1);
       procSchema = rs.getString(2);
       procRemarks = rs.getString(7);
       
       // W_B_20180911_87:BEGIN:2018-09-11
       // As the getShort() for column 8 throws error
       // for MariaDB jdbc driver, embedded the call in try/catch block
       // to ignore the error.
       try {
           procType = rs.getShort(8);
       } catch (SQLException e) {
           procType = DatabaseMetaData.procedureResultUnknown;
       } 
       // W_B_20180911_87:END:2018-09-11
       
       if (procType == DatabaseMetaData.procedureResultUnknown)
	   		procTypeInfo = new String("The procedure/function result is unknown.");
       else if (procType == DatabaseMetaData.procedureNoResult)
	   		procTypeInfo = new String("The procedure/function does not return result.");
       else if (procType == DatabaseMetaData.procedureReturnsResult)
	   		procTypeInfo = new String("The procedure/function returns result.");
   }
   %>

<TABLE BORDER=1 STYLE="FONT-SIZE:10pt;">
<TR>
<TD>Procedure/Function name: <SPAN STYLE="FONT-WEIGHT:BOLD;"><%=procName%></SPAN></TD>
<TD>Catalog: <SPAN STYLE="FONT-WEIGHT:BOLD;"><%=(procCatalog == null ? "(Not applicable)" : procCatalog)%></SPAN></TD>
<TD>Schema/Owner: <SPAN STYLE="FONT-WEIGHT:BOLD;"><%=(procSchema == null ? "(Not applicable)" : procSchema)%></SPAN></TD>
</TR>
<TR>
<TD COLSPAN=3><%=procTypeInfo%>
<%=(procRemarks == null ? "(No remarks exist for the procedure)" : procRemarks)%>
</TD>
</TR>
</TABLE>

<H3>Parameters and/or Resultset Colums</H3>
</TABLE>

<TABLE ALIGN="LEFT" class="sortable resizable">
<tr STYLE="BACKGROUND:SEAGREEN;">
<%
    rs = md.getProcedureColumns(null, schemaName, procName, "%"); 
    if (rs == null ) return;
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
    for (int i = 4; i <= nCols; i++) { 
%>
        <TH>
            <%= rsmd.getColumnLabel(i) %>
		</TH>
<%  
    } 
%>
	</tr>
<%
	nRows = 0;
    // Print Columns of the given procedure. 
    while (rs.next() ) { 
    	++nRows;
%>
        <TR>	   
        <TD  STYLE="BACKGROUND:LIGHTGRAY;"><%=nRows%></TD>	   
	    <% for (int i = 4; i <= nCols; i++) { %>
                <TD  STYLE="BACKGROUND:IVORY;">
		   <% String tmpValue = null;
		      if (i == 5) {
				switch (rs.getInt(5)) {
				case java.sql.DatabaseMetaData.procedureColumnIn:
				    tmpValue = "IN parameter"; 
	                            break;
				case java.sql.DatabaseMetaData.procedureColumnOut:
				    tmpValue = "OUT parameter"; 
	                            break;
				case java.sql.DatabaseMetaData.procedureColumnInOut:
	                            if (dbmsName.equals(DbNames.DBMS_MSSQLSERVER)) {
	                                /* MS SQL Server returns INOUT for OUT param.
	                                 * Hence, changing back. See MetaData.java also.
	                                 */
				        tmpValue = "OUT parameter"; 
	                            } else {
				        tmpValue = "IN and OUT parameter"; 
	                            }
	                            break;
				case java.sql.DatabaseMetaData.procedureColumnReturn:
				    tmpValue = "RETURN column"; 
	                            break;
				case java.sql.DatabaseMetaData.procedureColumnResult:
				    tmpValue = "RESULT SET column"; 
	                            break;
	            default:
				    tmpValue = "(Unknown)";
				    break;
				} // switch.
		      } else {
      			tmpValue = rs.getString(i); 
      			if (rs.wasNull()) {
      				tmpValue = "(NULL)";
      			}
		      }
		   %>
		   <%=(tmpValue == null ? " " : tmpValue)%>
	        </TD>
             <% } %>
	</TR>
     <% } %>
</TABLE>

<BR CLEAR=LEFT>
<% 
		rs.close();
		// out.print("nParams = " + nRows);
	} catch (java.sql.SQLException se) { 
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
        </SCRIPT>
<%
     return;
  }	      
  } // else of if procName == null 
%>

<SCRIPT LANGUAGE="JavaScript">

function drop_proc(form)
{
    if (confirm("Do you really want drop the <%=objType%> <%="'"+procName+"'"%>?")) {
        form.action = "br_execdrop.jsp?conn_no=<%=connNo%>&schema_name=<%=schemaName%>&obj_type=<%=objType%>&obj_name=<%=procName%>";
        form.target = "_self";
        form.submit();   
    }
}


function display_help(form)
{
   form.action = "../wji_help/he_procprop.jsp";
   form.target = "_blank";
   form.submit();   
}
</SCRIPT>
</FORM>
</BODY>
</HTML>

