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
 --- Function: Displays list of database tables and views of current schema/owner. 
 -->
 
<HTML>
<HEAD>
<TITLE>Table List</TITLE>
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
<%-- Get database connection --%>
<%@include file="../wji_common/imports.jsp"%>
<%@include file="../wji_common/connvars.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>

<%
   // out.print("<BR>conn_no="+connNo);
   // out.print("<BR>conn_obj="+CONN_OBJ_NAME);
   // out.print("<BR>conn="+conn);
   if (conn == null) return;
   java.sql.PreparedStatement pStmt1;
   java.sql.ResultSet rs, rs1;
   java.sql.DatabaseMetaData md; 
   String dbmsName = "";

   int nRows = 0, nRowsTbl = 0;
   String tableName = null;
   String tblSchema = null;
   String tblCatalog = null;
   String tblType = null;

   String stmtStr = "";
%>
<%
    String schemaNameStrs[] = request.getParameterValues("schema_name");
    String schemaName = null;
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

<FORM METHOD="POST">

<%@include file="br_tbllist_buttons.jsp" %>
<% // Display schema name if supported.
   if (conn.getMetaData().supportsSchemasInDataManipulation() == true) { 
%>
<TABLE >
   <TR>
   <TD>Owner/<BR>Schema:</TD>
   <TD><INPUT TYPE=TEXT NAME="schema_name" SIZE=8 VALUE="<%=schemaName%>"></TD>
   <TD><INPUT TYPE=BUTTON VALUE="Go"  
	ONCLICK="react_tables(this.form)"></TD>
   </TR>
</TABLE>
<% } %>

<BR>
<B>List of Tables:</B>
<TABLE  class="sortable resizable">
	<thead>
	<TR STYLE="BACKGROUND:SEAGREEN;">
		<TH VALIGN=TOP class="sortfirstasc" >SNO</TH>
		<TH VALIGN=TOP>Table Name</TH>
		<TH VALIGN=TOP>Rows</TH>
		<TH VALIGN=TOP>Type</TH>
		<TH VALIGN=TOP>Schema</TH>
		<TH VALIGN=TOP>Catalog</TH>
	</TR>
	</thead>
	<tbody>
<% try {
    conn.setAutoCommit(true); 
    md = conn.getMetaData(); 
    rs = md.getTables(null, schemaName, "%", null); 
    while (rs.next()) { 
             tblCatalog = rs.getString(1); 
	     if (rs.wasNull()) {
	         tblCatalog = "";
	     }
             tblSchema = rs.getString(2); 
	     if (rs.wasNull()) {
	         tblSchema = "";
	     }
             tableName = rs.getString(3); 
             tblType = rs.getString(4); 
             // out.print(tblType);
	     if (rs.wasNull()) {
	         tblType = "";
	     }
             if (md.getDatabaseProductName().equalsIgnoreCase(DBMS_SQLITE) == true) {
                 /* 2013-04-07: Fix to ignore all indexes coming as tables in SQLite */
		 if (tableName.startsWith("sqlite_autoindex") || tableName.startsWith("ix_")  || 
		         tableName.contains("_idx_")) continue;
	     } else if (md.getDatabaseProductName().equalsIgnoreCase(DBMS_POSTGRESQL) == true) {
		 if (tblType.equalsIgnoreCase("INDEX") || tblType.equalsIgnoreCase("SEQUENCE")) 
		         continue;
             }
	     stmtStr = "SELECT COUNT(*) FROM " + (tblSchema.equals("")  ? "" : tblSchema + ".") +
	     tableName;
             // out.print(stmtStr);
             /*
              * Added the following try/catch block to prevent stopping listing of tables 
              * if there is any error in getting row data. 
              * For example, if a table is created with quoted name in PostgreSQL, 
              * execution of the above stmt fails because table name in the stmt is not quoted.
              */
 	     try {
	         pStmt1 = conn.prepareStatement(stmtStr);
	         rs1 = pStmt1.executeQuery();
	         nRowsTbl = 0;
	         if (rs1 != null && rs1.next()) {
	             nRowsTbl = rs1.getInt(1);
	         }
	         pStmt1.close();
             } catch (java.sql.SQLException se) { 
%>
                  <SCRIPT Language="JavaScript">
	              displayMessage("Error", "<%=se.getSQLState()%>", 
	                   "<%=StringOps.xForm4JS(se.toString())%>"); 
                  </SCRIPT>
<%
             }	 
%>
         <TR STYLE="BACKGROUND:IVORY;">	
	     <TD STYLE="BACKGROUND:LIGHTGRAY;font-size:10pt"><%=(nRows+1)%></TD>
             <TD STYLE="font-size:10pt">
		     <A HREF="br_tblprop.jsp?table_name=<%=tableName%>&schema_name=<%=rs.getString(2)%>&obj_type=<%=tblType%>" 
	             TARGET="rightdatafr"><%=tableName%></A>
	     </TD>
	     <TD STYLE="font-size:10pt;BACKGROUND:<%=(nRowsTbl > 0 ? "LIMEGREEN" : "WHITE")%>"><%=nRowsTbl%></TD>
	     <TD STYLE="font-size:10pt"><%=tblType%></TD>
	     <TD STYLE="font-size:10pt"><%=tblSchema%></TD>
	     <TD STYLE="font-size:10pt"><%=tblCatalog%></TD>
	     </TR>
<% 
	     ++nRows;
	} 
        rs.close();
   } catch (java.sql.SQLException se) { 
        // out.print(se.toString());
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
        </SCRIPT><%
        return;
   }	 
%>
</tbody>
</TABLE>
<p>#Tables: <%=nRows%></p>
<BR><BR><BR><BR>
<% 
    if (nRows == 0) {
        out.print("<P STYLE=\"COLOR:RED;\">No tables exist.</P>");
	if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_MSSQLSERVER)) {
	    out.print("<P><I>(Try  admin owner name 'dbo' " +
	        	"or some other schema name in the Owner/Schema field above and click 'Go'. </I></P>");
	} else if (conn.getMetaData().supportsSchemasInDataManipulation() == true){
	    out.print("<P><I>(Try some other schema name in Owner/Schema field above and click 'Go'. </I></P>");
        }
    } 
%>

<SCRIPT LANGUAGE="JavaScript">

function react_tables(form)
{
   form.action = "br_tbllist.jsp";
   form.target = "_self";
   form.submit();   
}

function list_procedures(form)
{
   form.action = "br_proclist.jsp?schema_name=<%=schemaName%>";
   form.target = "_self";
   form.submit();   
}


function display_help(form)
{
   form.action = "../wji_help/he_tbllist.jsp";
   form.target = "_blank";
   form.submit();   
}

</SCRIPT>

</FORM>
</BODY>
</HTML>
