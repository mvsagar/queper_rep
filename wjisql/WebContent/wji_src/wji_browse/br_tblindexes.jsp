<HTML>
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
 --- Function: Display list of keys and indexes defined on given database table. 
 -->
<HEAD>
<TITLE>Keys and Indexes</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>	
<BODY>
<%-- Get database connection --%>
<%@include file="../wji_common/imports.jsp"%>
<%@include file="../wji_common/connvars.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>

<FORM METHOD="POST" NAME="br_tblindexes_form">


<%
    java.sql.ResultSet rs;
    java.sql.DatabaseMetaData md; 
    java.sql.ResultSetMetaData rsmd; 
    java.sql.Connection connX;
    int nRows = 0;
    String primaryKeyName = null;
    String indexName = ""; // Do not make it null.
    String prevIndexName = ""; // Do not make it null.
    boolean isIndexUnique = false;
    String indexQualifier = null;
    String indexOrganization = null;
    int ordinalPosition = 0;
    boolean isTableStatistics = false;
    int cardinality = 0;
    int nPages = 0;
    String filterCondition = "(No specific condition)";
    int nIndexes = 0;


    String tableName = request.getParameter("table_name"); 
    String schemaName = request.getParameter("schema_name"); 
    String objType = request.getParameter("obj_type");
    String sqlStmt = request.getParameter("sqlstmt");

   if (connNo == 0 && conn == null || connNo == 1 && conn1 == null || connNo == 2 && conn2 == null) {
       out.print("<BR><BR><BR>");
       out.print("<P ALIGN=CENTER>No active database connection exists.</P>");
       out.print("<P ALIGN=CENTER>Connect to a database first and try again.</P>");
       return;
   }

    connX = connNo == 0 ? conn : (connNo == 1 ? conn1 : conn2);

%>

<H3>Table Properties: Keys and Indexes</H3>

<%@include file="br_tblindexes_buttons.jsp" %>
<%
    try {
        // Get primary key info. 
        md = connX.getMetaData(); 
        rs = md.getPrimaryKeys(null, schemaName, tableName); 
        nRows = 0; 
        while (rs.next()) { 
            // Note the name of the primery key name from the first row.
            // Also print titles of the result columns.
            if (nRows == 0) {
                out.print("<TABLE>");
                out.print("<TR><TD>");
                out.print("<P STYLE=\"FONT-SIZE:12pt;FONT-WEIGHT:BOLD;\"><U>Primary Key</U></P>");
                out.print("</TD></TR>");
                primaryKeyName = rs.getString(6); 
                out.print("<TR><TD><P STYLE=\"FONT-SIZE:10pt;FONT-WEIGHT:BOLD;\">Primary key name: " + (primaryKeyName == null ? 
		      "(no specific name for the primay key)" : 
		       primaryKeyName + "</P>") + "</TD></TR>");
                rsmd = rs.getMetaData();

                // Print heading for columns of primary key info: 
                // column name and key sequence.
                out.print("<TR><TD><B>Primary key columns:</B></TD></TR>");
                out.print("<TR><TD>"); // outer most table row
                out.print("<TABLE BORDER=1 ALIGN=LEFT>");
                out.print("<TR>");
                for (int i = 4; i <= 5; i++) { 
                    out.print("<TH>" + rsmd.getColumnLabel(i) + "</TH>");
                } // for 
                out.print("</TR>");
            } // if 

            // Print key column info.
            out.print("<TR>"); 
            for (int i = 4; i <= 5; i++) { 
                out.print("<TD>" + rs.getString(i) + "</TD>");
            } // for 
            out.print("</TR>");
            ++nRows; 
        } // while primary keys
        rs.close(); 
        if (nRows == 0) { 
            out.print("<TR><TD><P>There is no primary key on the table.</P></TD></TR>");
        } else {
        out.print("</TABLE>");
        out.print("</TD></TR>"); // outer most table row
        }
        // End of primary keys
        

        // Get other key and index info.
        nIndexes = 0; 
        md = connX.getMetaData(); 
        rs = md.getIndexInfo(null, schemaName, tableName, false, false); 
        nRows = 0; 
        while (rs.next()) { 
            /*
	    * Note the name of the primery key name from the first row.
            * Also print titles of the result columns.
            */	
            isIndexUnique = rs.getBoolean(4); 
            indexQualifier = rs.getString(5) == null ? 
    		         "(No specific index qualifier)" : rs.getString(5);
            indexName = rs.getString(6) == null ? 
		     "(No specific index name; could be index statistics)" : 
		     rs.getString(6); 
            if (indexName.equals(primaryKeyName))
	        continue;
            switch(rs.getInt(7)) {
               case java.sql.DatabaseMetaData.tableIndexStatistic: 
	          isTableStatistics = true; break;
	       case java.sql.DatabaseMetaData.tableIndexClustered:
	          indexOrganization = "Clustered"; break;
	       case java.sql.DatabaseMetaData.tableIndexHashed:
	          indexOrganization = "Hashed"; break;
	       case java.sql.DatabaseMetaData.tableIndexOther:
	          indexOrganization = "(Other than Clustered or Hashed)"; break;
	       default:
	          indexOrganization = "(Unknown)"; 
            } // switch.
            ordinalPosition = rs.getInt(8);
            cardinality = rs.getInt(11);
            nPages = rs.getInt(12);
            filterCondition = rs.getString(13); 

            if (isTableStatistics == true && ordinalPosition == 0) { 
	        out.print("<TR><TD><BR><H3>Table Statistics</H3></TD></TR>");
                out.print("<TR><TD>"); // outer most table row. 
                out.print("<TABLE BORDER=1>");
	        out.print("<TR><TH>Statistic Name</TH><TH>Value</TH></TR>");
                out.print("<TR><TD>Cardinality:</TD><TD>" + cardinality + "</TD></TR>");
                out.print("<TR><TD>Number of pages:</TD><TD>" + nPages + "</TD></TR>");
                out.print("<TR><TD>Filter Condition:</TD><TD>" + filterCondition + "</TD></TR>");
                out.print("</TABLE>");
                out.print("</TR></TD>"); // outer most table row. 
                continue;
            }        

	    if (indexName.equals(prevIndexName) == false) {
                ++nIndexes;

	        // Heading for all indexes
                if (nIndexes == 1) out.print("<TR><TD><BR><P STYLE=\"FONT-SIZE:12pt;FONT-WEIGHT:BOLD;\"><U>Indexes</U></P></TD></TR>");

	        // Terminate previous table.
                if (nIndexes > 1) out.print("</TABLE>");

                out.print("<TR><TD><BR><BR><B>" + nIndexes + ". Index Name: " + indexName + "</B><BR></TD></TR>");
                out.print("<TR><TD><BR><B>Index Properties:</B></TD></TR>");
                out.print("<TR><TD>"); // outer most table row.
                out.print("<TABLE BORDER=1>");
                out.print("<TR><TH>Name</TH><TH>Value</TH></TR>");
                out.print("<TR><TD>Qualifier:</TD><TD>" + indexQualifier + "</TD></TR>");
                out.print("<TR><TD>Is unique?:</TD><TD>" + isIndexUnique + "</TD></TR>");       
                out.print("<TR><TD>Organization?:</TD><TD>" + indexOrganization + "</TD></TR>");       
                out.print("<TR><TD>Unique values:</TD><TD>" + cardinality + "</TD></TR>");
                out.print("<TR><TD>Number of pages:</TD><TD>" + nPages + "</TD></TR>");
                out.print("<TR><TD>Filter Condition:</TD><TD>" + filterCondition + "</TD></TR>");
                out.print("</TABLE>");    
                out.print("</TR></TD>"); // outer most table row.


                // Print heading for columns of index info: 
                // column name and sequence.
                out.print("<TR><TD>"); // outer most table row.
                out.print("<BR><B>Index Columns:</B>");
                out.print("</TR></TD>"); // outer most table row.

                out.print("<TR><TD>"); // outer most table row.
                out.print("<TABLE BORDER=1 ALIGN=LEFT>");
                rsmd = rs.getMetaData();
                out.print("<TR>");
                for (int i = 8; i <= 10; i++) { 
                    out.print("<TH>" + rsmd.getColumnLabel(i) + "</TH>");
                } 
                out.print("</TR>");
            } // if 
            prevIndexName = new String(indexName);
            out.print("<TR>"); 
	    for (int i = 8; i <= 10; i++) { 
                out.print("<TD>" + rs.getString(i) + "</TD>");
            }
            out.print("</TR>");
            ++nRows; 
        } // while 
        rs.close(); 
        if (nRows == 0) { 
             out.print("<TR><TD><BR><P>There are no indexes on the table.</P></TD></TR>");
        } else {
            out.print("</TABLE>");
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
%>


<SCRIPT LANGUAGE="JavaScript">

function go_back(form) {
    form.action = "../wji_browse/br_tblprop.jsp"        
        + "?conn_no=<%=connNo%>"
    	+ "&table_name=<%=tableName%>"
    	+ "&schema_name=<%=schemaName%>"
    	+ "&obj_type=<%=objType%>";
    form.target = "_self";
    // alert(form.action);
    form.submit();
}


function display_help(form) {
    form.action = "../wji_help/he_tblindexes.jsp";
    form.target = "_blank";
    form.submit();
}
</SCRIPT>

</BODY>
</HTML>


