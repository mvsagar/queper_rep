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
 --- Function: Displays list of database procedures and functions.
 -->
<HTML>
<HEAD>
	<TITLE>Procedure List</TITLE>
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
<%@include file="../wji_login/dbconnect.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>

<%
  java.sql.ResultSet rs;
  java.sql.DatabaseMetaData md; 
  int nRows = 0;
  String dbmsName = "";
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
  
<%@include file="br_proclist_buttons.jsp" %>

<% // Display schema name if supported.
   md = conn.getMetaData();
   if (md.supportsSchemasInProcedureCalls() == true) { 
%>
   <TABLE>
   <TR>
   <TD>Owner/<BR>Schema:</TD>
   <TD><INPUT TYPE=TEXT NAME="schema_name" SIZE=8 VALUE="<%=schemaName%>"></TD>
   <TD><INPUT TYPE=BUTTON VALUE="Go"  
	ONCLICK="react_procs(this.form)"></TD>
   </TR>
   </TABLE>
   <% } 
   
    //Bug fix : W_20140810_00022
    if (md.supportsStoredProcedures()) {
   
   %>

<B>List of Procedures/Functions:</B>
<TABLE class="sortable resizable">
<TR STYLE="BACKGROUND:SEAGREEN;">
<TH VALIGN=TOP STYLE="font-size:10pt">SNO</TH>
<TH VALIGN=TOP  STYLE="font-size:10pt" class="sortfirstasc">Procedure/<BR>Function Name</TH>
<TH VALIGN=TOP STYLE="font-size:10pt">Type</TH>
<TH VALIGN=TOP STYLE="font-size:10pt">Schema</TH>
<TH VALIGN=TOP STYLE="font-size:10pt">Catalog</TH>
</TR>
<% try {
      String catalog = "";
      String schema = "";
      short typeNum = -1;
      String type = "";
      String name = "";
      int index = -1;

      	rs = md.getProcedures(null, schemaName, "%"); 
      
      	while (rs.next()) { 
        catalog = rs.getString(1); 
	  if (rs.wasNull()) {
	      catalog = "";
	  }
          schema = rs.getString(2); 
	  if (rs.wasNull()) {
	      schema = "";
	  }
          name = rs.getString(3); 
          typeNum = rs.getShort(8); 
	  if (typeNum == md.procedureNoResult) {
              type = "PROCEDURE";
	   } else  if (typeNum == md.procedureReturnsResult) {
	       if (dbmsName.equalsIgnoreCase(DBMS_MYSQL)) {
                   /*
                    * Ignore displaying functions becauses
                    * getFunctions() will retrieve them.
                    */
                   continue;
	       } else {
	            type = "FUNCTION";
	       }
           } else {
	       if (dbmsName.equalsIgnoreCase(DBMS_MYSQL)) {
	           type = "PROCEDURE";
	       } else {
                   type = "UNKNOWN";
	       }
           }

          /*
           * MS JDBC Driver returns names with a grouping number starting with 
           * semicolon. Strip that out.
           */
          index = name.indexOf(';');
          if (index != -1) {
              name = name.substring(0, index);
          }
          ++nRows;
%>
        <TR STYLE="BACKGROUND:IVORY;">	
          <TD STYLE="BACKGROUND:LIGHTGRAY;font-size:10pt"><%=nRows%></TD>
          <TD STYLE="font-size:10pt">
	       <A HREF="br_procprop.jsp?procname=<%=name%>&obj_type=<%=type%>" TARGET="rightdatafr"> 
	       <%=name%></A>
	  		</TD>
          <TD STYLE="font-size:10pt"><%=type%></TD>
          <TD STYLE="font-size:10pt"><%=schema%></TD>
          <TD STYLE="font-size:10pt"><%=catalog%></TD>
	</TR>

<%  } 
%>
</TABLE>
<%
    if (nRows == 0) {
        out.print("<P STYLE=\"COLOR:RED;\">No procedures &amp; functions exist.</P>");
	if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase("Microsoft SQL Server")) {
	    out.print("<P><I>(Try  admin owner name 'dbo' " +
	        	"or some other schema name in the Owner/Schema field above and click 'Go'. </I></P>");
	} else if (conn.getMetaData().supportsSchemasInDataManipulation() == true){
	    out.print("<P><I>(Try some other schema name in Owner/Schema field above and click 'Go'. </I></P>");
        }
    } 
     
    /*
     * Display stored functions for those DBMS which do not
     * include them as part of procedures.
     */
    if (!dbmsName.equalsIgnoreCase(DBMS_MSSQLSERVER) &&
            !dbmsName.equalsIgnoreCase(DBMS_ORACLE) &&
            !dbmsName.equalsIgnoreCase(DBMS_POSTGRESQL) // Does not support getFunctions.
    ) {
%>
<BR>
<B>List of Functions:</B>
<TABLE class="sortable resizable">
	<TR STYLE="BACKGROUND:SEAGREEN;">
	<TH VALIGN=TOP>SNO</TH>
	<TH VALIGN=TOP>Function Name</TH>
	<TH VALIGN=TOP>Type</TH>
	<TH VALIGN=TOP>Schema</TH>
	<TH VALIGN=TOP>Catalog</TH>
	</TR>
<%
        rs.close();

      nRows = 0;
      // Get functions
      rs = md.getFunctions(null, schemaName, "%"); 
      
      while (rs.next()) { 
      	catalog = rs.getString(1); 
	  	if (rs.wasNull()) {
	     	catalog = "";
	  	}
        schema = rs.getString(2); 
	  	if (rs.wasNull()) {
	      	schema = "";
	  	}
          name = rs.getString(3); 
          type = "FUNCTION";

          /*
           * MS JDBC Driver returns names with a grouping number starting with 
           * semicolon. Strip that out.
           */
          index = name.indexOf(';');
          if (index != -1) {
              name = name.substring(0, index);
          }
          ++nRows;
%>

        <TR STYLE="BACKGROUND:IVORY;">	
          <TD STYLE="BACKGROUND:LIGHTGRAY;"><%=nRows%></TD>
          <TD>
	       <A HREF="br_procprop.jsp?procname=<%=name%>&obj_type=<%=type%>" TARGET="rightdatafr"> 
	       <%=name%></A>
	  	  </TD>
          <TD><%=type%></TD>
          <TD><%=schema%></TD>
          <TD><%=catalog%></TD>
		</TR>
<% 
	} 
%>
    </TABLE>
<%
        rs.close();

        if (nRows == 0) {
            out.print("<P STYLE=\"COLOR:RED;\">No functions exist.</P>");
	    if (conn.getMetaData().getDatabaseProductName().equalsIgnoreCase("Microsoft SQL Server")) {
	        out.print("<P><I>(Try  admin owner name 'dbo' " +
	        	    "or some other schema name in the Owner/Schema field above and click 'Go'. </I></P>");
	    } else if (conn.getMetaData().supportsSchemasInDataManipulation() == true){
	        out.print("<P><I>(Try some other schema name in Owner/Schema field above and click 'Go'. </I></P>");
            }
        } 

     } // if dbmsName...

  } catch (java.sql.SQLException se) { 
%>

        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
        </SCRIPT> 
<%
        return;
        }
    } else {   
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Info:", "", 
	         "Stored Procedures are not supported by the RDBMS."); 
        </SCRIPT> 
<%
    }
      //bug fix

%>
<SCRIPT LANGUAGE="JavaScript">

function react_procs(form)
{
   form.action = "br_proclist.jsp";
   form.submit();   
}

function list_tables(form)
{
   form.action = "br_tbllist.jsp?schema_name=<%=schemaName%>";
   form.target = "_self";
   form.submit();   
}


function display_help(form)
{
   form.action = "../wji_help/he_proclist.jsp";
   form.target = "_blank";
   form.submit();   
}
</SCRIPT>

</FORM>
</BODY>
</HTML>


