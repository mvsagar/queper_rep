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
 --- Function:		Displays table list for source (conn1) or destination database (conn2). 
 -->

<HTML>
<HEAD>
<TITLE>Table List</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	<link rel="stylesheet" type="text/css" media="all" href="../wji_css/style.css" />
	
    <!--  Third party software used to display nice html tables and sorting data.  -->	
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
<%@include file="../wji_common/imports.jsp" %>
<%@include file="../wji_common/connvars.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>
<%
   java.sql.PreparedStatement pStmt1;
   java.sql.ResultSet rs, rs1;
   java.sql.DatabaseMetaData md; 
   int nRows1 = 0;
   int nRows2 = 0;
   int nRowsTbl = 0;
   String tableName = null;
   String tblSchema = null;
   String tblCatalog = null;
   String tblType = null;
   String schemaName1 = "";
   String schemaName2 = "";
%>

<FORM METHOD="POST" NAME="tbllist_form">
<TABLE BORDER=2 WIDTH="100%">
<% if (connNo == 1) { %>
<TR><TD ALIGN=CENTER>
<B>Source Database System<BR>(From)</B>
</TD></TR>
<TR><TD ALIGN=CENTER>
<%@include file="../wji_transfer/tr_tbllist_conn1_buttons.jsp" %>
</TD></TR>
<% } else {%>
<TR><TD ALIGN=CENTER>
<B>Destination Database System<BR>(To)</B>
</TD></TR>
<TR><TD ALIGN=CENTER>
<%@include file="../wji_transfer/tr_tbllist_conn2_buttons.jsp" %>
<% } %>
</TD></TR>

<TR>	
<TD>
<% 
    if (conn1 == null) {
        /*
         out.print("userid1=" + userId1 + ", userId="+ userId);
         out.print("connobjname="+CONN_OBJ_NAME);
	 out.print("No source connection");
	 */
    } else {
        String schemaNameStr1 = request.getParameter("schema_name1");
        schemaName1 = null;
	if (schemaNameStr1 != null) { 
           schemaName1 = schemaNameStr1;
	} else {
           schemaName1 = (String) theSession.getAttribute("schema_name1"); 
        }
        if (schemaName1 == null) {
            try {
                if (conn1.getMetaData().getDatabaseProductName().equalsIgnoreCase("PostgreSQL")) {
	            schemaName1 = "public";
                } else if (conn1.getMetaData().getDatabaseProductName().equalsIgnoreCase("SQLite")) {
	            schemaName1 = null;
                } else if (conn1.getMetaData().getDatabaseProductName().equalsIgnoreCase("Oracle")) {
                    schemaName1 = conn1.getMetaData().getUserName().toUpperCase();
                } else if (conn1.getMetaData().getDatabaseProductName().equalsIgnoreCase("Microsoft SQL Server")) {
                    schemaName1 = "dbo";
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
        theSession.setAttribute("schema_name1", schemaName1); 
        String schemaNameStr2 = request.getParameter("schema_name2");
        schemaName2 = schemaNameStr2;
	//out.print("schema2=" + schemaName2);

%>

<TABLE BORDER=1>
<TR>
<TD>RDBMS:</TD><TD><%=conn1.getMetaData().getDatabaseProductName()%></TD>
</TR>
<TR>
<TD>Database:</TD><TD><%=DbNames.getDbName(conn1)%></TD>
</TR>
</TABLE>
<BR>

<% // Display schema name if supported.
   if (conn1.getMetaData().supportsSchemasInDataManipulation() == true) { 
%>
   <TABLE BORDER="1" >
   <TR>
   <TD COLSPAN=2>Owner/Schema:</TD>
   </TR>
   <TR>
   <TD><INPUT TYPE=TEXT NAME="schema_name1" VALUE="<%=schemaName1%>"></TD>
   <TD><INPUT TYPE=BUTTON VALUE="Go"  
	ONCLICK="react_tables(this.form)"></TD>
   </TR>
   </TABLE>
<% } %>
<BR>
<B>Source Table List</B>:
<BR>
<TABLE  ALIGN="LEFT" class="sortable resizable">
<TR STYLE="BACKGROUND:SEAGREEN;">
<TH>SNO</TH>
<TH>Table name</TH>
<TH>Rows</TH>
<TH>Transfer ?<BR>
<INPUT TYPE=CHECKBOX NAME="xfrall" 
ONCLICK="toggle_all_for_transfer(this.form, 1)">
</TH>
<TH>Delete ?<BR>
<INPUT TYPE=CHECKBOX NAME="delall" 
ONCLICK="toggle_all_for_delete(this.form, 1)">
</TH>
</TR>	
<% try {
    md = conn1.getMetaData(); 
    rs = md.getTables(null, schemaName1, "%", null); 
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
	     if (rs.wasNull()) {
	         tblType = "";
	     }
             if (md.getDatabaseProductName().equalsIgnoreCase(DBMS_SQLITE) == true) {
                 /* 2013-04-07: Fix to ignore all indexes coming as tables in SQLite */
                 if (tableName.startsWith("sqlite_autoindex") || tableName.startsWith("ix_") || 
                     tableName.contains("_idx_")) continue;
	     } else if (md.getDatabaseProductName().equalsIgnoreCase(DBMS_POSTGRESQL) == true) {
		 if (tblType.equalsIgnoreCase("INDEX") || tblType.equalsIgnoreCase("SEQUENCE")) 
		         continue;
             }	     
             /*
              * Added the following try/catch block to prevent stopping listing of tables 
              * if there is any error in getting row data. 
              * For example, if a table is created with quoted name in PostgreSQL, 
              * execution of the above stmt fails because table name in the stmt is not quoted.
              */
 	     try {	     
	         pStmt1 = conn1.prepareStatement("SELECT COUNT(*) FROM " + 
	             (tblSchema.equals("")  ? "" : tblSchema + ".") + tableName);
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
             <TR STYLE="BACKGROUND:LIGHTGRAY;">	
             <TD><%=(nRows1+1)%></TD>
	     <TD>
	          <A HREF="../wji_browse/br_tblprop.jsp?conn_no=1&table_name=<%=tableName%>&schema_name=<%=schemaName1%>&obj_type=TABLE" TARGET="rightdatafr1">
                     <INPUT TYPE=TEXT READONLY NAME="t<%=nRows1%>" VALUE="<%=tableName%>"></A>
             </TD>
             <TD STYLE="BACKGROUND:<%=(nRowsTbl > 0 ? "LIMEGREEN" : "WHITE")%>"><%=nRowsTbl%></TD>
             <TD> 
                 <INPUT TYPE=CHECKBOX NAME="c1<%=nRows1%>">
             </TD>
	     <TD> 
                 <INPUT TYPE=CHECKBOX NAME="c2<%=nRows1%>">
             </TD>


	     </TR>
<%     
             ++nRows1;
	} 
%>
       

<%	
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
<% } 
%>
</TD>
</TR>
<%
	if (conn1 != null) {
%>
		<!-- W_B_20161226_56: Number of tables in table list shows up on  right side instead of 
  		  -- below of source database table list in Transfer screen 
  		  -->

		<TR><TD>#Tables: <%=nRows1%></TD></TR>
<%
	}
%>

<TR>

<TD VALIGN=TOP>
<%
      //out.print("<BR>userid2=" + userId2 + ", userId="+ userId);
      //out.print("<BR>connobjname="+CONN_OBJ_NAME);

    if (conn2 == null) {
       // out.print("No dest connection");
    } else {
        String schemaNameStr2 = request.getParameter("schema_name2");
        schemaName2 = null;
	if (schemaNameStr2 != null) { 
           schemaName2 = schemaNameStr2;
	} else {
           schemaName2 = (String) theSession.getAttribute("schema_name2"); 
        }
        if (schemaName2 == null) {
            try {
                if (conn2.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_POSTGRESQL)) {
	            schemaName2 = "public";
                } else if (conn2.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_SQLITE)) {
	            schemaName2 = null;
                } else if (conn2.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_ORACLE)) {
                    schemaName2 = conn2.getMetaData().getUserName().toUpperCase();
                } else if (conn2.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_MSSQLSERVER)) {
                    schemaName2 = "dbo";
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
        theSession.setAttribute("schema_name2", schemaName2); 
%>
<TABLE BORDER=1>
<TR>
<TD>RDBMS:</TD><TD><%=conn2.getMetaData().getDatabaseProductName()%></TD>
</TR>
<TR>
<TD>Database:</TD><TD><%=DbNames.getDbName(conn2)%></TD>
</TR>
</TABLE>
<BR>
<%
       if (conn2.getMetaData().supportsSchemasInDataManipulation() == true) { 
%>
   <TABLE BORDER="1">
   <TR>
   <TD COLSPAN=2>Owner/Schema:</TD>
   </TR>
   <TR>
   <TD><INPUT TYPE=TEXT NAME="schema_name2" VALUE="<%=schemaName2%>"></TD>
   <TD><INPUT TYPE=BUTTON VALUE="Go"  ONCLICK="react_tables(this.form)"></TD>
   </TR>
   </TABLE>
<% } %>
<BR>
<B>Destination Table List</B>:
<BR>
<TABLE class="sortable resizable">
<TR STYLE="BACKGROUND:SEAGREEN;">
<TH>SNO</TH><TH>Table name</TH><TH>Rows</TH></TR>	
<% try {
    md = conn2.getMetaData(); 
    rs = md.getTables(null, schemaName2, "%", null); 
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
             /*
              * Added the following try/catch block to prevent stopping listing of tables 
              * if there is any error in getting row data. 
              * For example, if a table is created with quoted name in PostgreSQL, 
              * execution of the above stmt fails because table name in the stmt is not quoted.
              */
 	     try {	     
	         pStmt1 = conn2.prepareStatement("SELECT COUNT(*) FROM " + 
                      (tblSchema.equals("")  ? "" : tblSchema + ".") + tableName);

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
             <TR STYLE="BACKGROUND:LIGHTGRAY;">	
             <TD><%=(nRows2+1)%></TD>
	     <TD>
	          <A HREF="../wji_browse/br_tblprop.jsp?conn_no=2&table_name=<%=tableName%>&schema_name=<%=schemaName2%>&obj_type=TABLE" 
	           TARGET="rightdatafr2"><INPUT TYPE=TEXT READONLY NAME="t<%=nRows2%>" VALUE="<%=tableName%>"></A>
	     </TD>
             <TD STYLE="BACKGROUND:<%=(nRowsTbl > 0 ? "LIMEGREEN" : "WHITE")%>"><%=nRowsTbl%></TD>	  
	     </TR>
<%     
	     ++nRows2;
        } 
%>

<%	
    rs.close();
   } catch (java.sql.SQLException se) { 
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
        </SCRIPT><%
     return;
   }	 
%>
</TABLE>
<% 
    } 
%>
</TD>
</TR>

<%
	if (conn2 != null) {
%>
		<!-- W_B_20161226_56: Number of tables in table list shows up on  right side instead of 
		  -- below of source database table list in Transfer screen 
		  -->
		<TR><TD>#Tables: <%=nRows2%></TD></TR>
<%
	}
%>

</TABLE>

<SCRIPT LANGUAGE="JavaScript">

function toggle_all_for_transfer(form, conn_no) {
    var i = 0;
    var n_rows =  0;
    if (conn_no == 1) n_rows = <%=nRows1%>;
    else n_rows = <%=nRows2%>
    if (form.xfrall.checked == true) {
        for (i = 0; i < n_rows; ++i) {
            form.elements["c"+ conn_no+i].checked = true;
        }
    } else {
        for (i = 0; i < n_rows; ++i) {
            form.elements["c"+ conn_no+i].checked = false;
        }
    }
}


function toggle_all_for_delete(form, conn_no) {
    var i = 0;
    var n_rows =  0;
    if (conn_no == 1) n_rows = <%=nRows1%>;
    else n_rows = <%=nRows2%>
    if (form.delall.checked == true) {
        for (i = 0; i < n_rows; ++i) {
            form.elements["c2"+i].checked = true;
        }
    } else {
        for (i = 0; i < n_rows; ++i) {
            form.elements["c2"+i].checked = false;
        }
    }
}


function transfer_data(form)
{
    if (confirm("Please confirm for the data transfer.")) {
        form.action = "tr_data.jsp?nrows1=<%=nRows1%>&nrows2=<%=nRows2%>" +
	              "&schema_name1=<%=(schemaName1 == null ? "" : schemaName1)%>" +
	              "&schema_name2=<%=(schemaName2 == null ? "" : schemaName2)%>";
	form.target="_blank";
        form.submit();   
    }
}


function react_tables(form)
{
    form.action = "tr_tbllist.jsp?conn_no=<%=connNo%>";
    form.target = "leftdatafr<%=connNo%>";
    form.submit();   
}

function refresh_data(form, conn_no)
{
    form.action = "tr_tbllist.jsp?conn_no=" + conn_no;
    if (conn_no == 1) {
	form.target = "leftdatafr1";
    } else {
	form.target = "leftdatafr2";
    }
    form.submit();   
}    

function display_help_source(form)
{
    form.action = "../wji_help/he_transfer_source.jsp";
    form.target = "_blank";
    form.submit();   
}


function display_help_destination(form)
{
    form.action = "../wji_help/he_transfer_destination.jsp";
    form.target = "_blank";
    form.submit();   
}

/* 
* Invoke tbllist with conn 1 so that schema field
* set when invoked with conn  2 will be available in 
* conn 1!
*/
if (<%=connNo%> == 2) 
{
     tbllist_form.action = "tr_tbllist.jsp?conn_no=1";
     tbllist_form.target = "leftdatafr1";
     tbllist_form.submit();
}

</SCRIPT>

</FORM>
</BODY>
</HTML>
