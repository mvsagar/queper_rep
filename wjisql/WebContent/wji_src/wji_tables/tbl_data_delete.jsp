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
 --- Function:		Deletes selected rows from the given table.
 --- Description:	If primary key exists, deletes based on primary key column data.
 ---				Otherwise, deletes based on all columns except long data columns 
 ---				(may have to exclude some other columns as well: TBD) 
 -->
 
<HTML>
<HEAD>
<TITLE>Delete</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../wji_common/imports.jsp"%>

<%@include file="../wji_common/connvars.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>


<%-- Prepare a result set --%>
<%! java.sql.ResultSet rs; 
   java.sql.ResultSetMetaData rsmd; 
   java.sql.Statement stmt; 
   java.sql.DatabaseMetaData md;

    // Arrays to store column names. Assumes a maximum of 500 columns. 
    String[] columnNames = new String[500]; 
    String[] primaryKeyColumnNames = new String[500]; 
    String[] whereClauseColumnNames = new String[500]; 
    
    int i = 0; 
    int nColumns = 0;
    int nKeyColumns = 0;

    // Used to access request object from methods.
    HttpServletRequest cRequest = null; 

    String sqlStmt = "";
   %>

 <%
   //Make request object available through a class member for methods.
   cRequest = request;
   
   String schemaNameStrs[] = request.getParameterValues("schema_name"); 
   String schemaName = schemaNameStrs[0]; 
  

   String tableNamesStrs[] = request.getParameterValues("table_name");   
   String tableName = tableNamesStrs[0];   

   String nRowsStrs[] = request.getParameterValues("noofrows");   
   int nRows = Integer.parseInt(nRowsStrs[0]);   

   String nColsStrs[] = request.getParameterValues("noofcolumns");   
   int nCols = Integer.parseInt(nColsStrs[0]);   

   String colName = null;   

    String sqlStmtStr = request.getParameter("sqlstmt"); 
    if (sqlStmtStr == null) sqlStmt = "";
    else {
       sqlStmt = StringOps.convertUtf8ToUnicode(sqlStmtStr);
    }

    java.sql.Connection connX;

    if (connNo == 0 && conn == null || connNo == 1 && conn1 == null || connNo == 2 && conn2 == null) {
       out.print("<BR><BR><BR>");
       out.print("<P ALIGN=CENTER>No active database connection exists.</P>");
       out.print("<P ALIGN=CENTER>Connect to a database first and try again.</P>");
       return;
    }
    connX = connNo == 0 ? conn : (connNo == 1 ? conn1 : conn2);


   connX.setAutoCommit(true);

   StringBuffer stmtStr = null;
   if (connX.getMetaData().supportsSchemasInDataManipulation() == true)
      stmtStr = new StringBuffer("DELETE FROM " + 
		schemaName + "." + tableName + " WHERE "); 
   else
      stmtStr = new StringBuffer("DELETE FROM " + tableName + " WHERE "); 

%>
<%-- Method definitions begin --%>

<%-- Get primary key column name given form field number. 
     Gets column name corresponding to the passed field number
     from the header field "v0<fFieldNo>". Returns the column name if
     it is one of the primary key column names.
--%>
<%! boolean isPrimaryKeyColumn(String col) 
    {
       for (int i = 0; i < nKeyColumns; ++i) 
           if (col.equals(primaryKeyColumnNames[i])) 
	       return true;
       return false;
    }
%>

<%-- Method definitions end --%>
<%-- Get primary key columns of the given table from the database. --%>
<%
    md = connX.getMetaData(); 
    rs = md.getPrimaryKeys(null, null, tableName); 
    i = 0; 
    while (rs.next()) {
        primaryKeyColumnNames[i] = new String(rs.getString(4)); 
        ++i;
    }
    nKeyColumns = i;
    if (nKeyColumns == 0) { 
%>
       <SCRIPT LANGUAGE="JavaScript">
           alert("Error: You can not delete rows from table having no primary keys!\n" +
             "Use SQL statement facility of wjISQL for deleting rows from such tables.");
       </SCRIPT>
       <META http-equiv="refresh" content="0;url=../wji_sqlstmts/ss_results.jsp?conn_no=<%=connNo%>&schema_name=<%=schemaName%>&table_name=<%=tableName%>&sqlstmt=<%=sqlStmt%>" target="rightdatafr">
<% 
       return;
   }

   /*
    * If primary key exists, delete based on primary key columns.
    * Or, delete based on all columns except long data columns (may have to exclude some other columns
    * as well TBD)
    */
   stmt = connX.createStatement(); 
   String colValue, fValues[]; 
   int maxCols =  (nKeyColumns > 0 ? nKeyColumns : nCols);
   boolean firstCol = true;

    try {
        connX.setAutoCommit(false);

        for (int i = 1; i <= nRows; ++i) { 
            StringBuffer valuesStr = new StringBuffer(" "); 
     
            // If the row is not selected, ignore the rows. 
            fValues = request.getParameterValues("vr" + Integer.toString(i) + "c0");
            //out.print("<BR>row=" + i + "; check box=" + fValues); 
            	
            if (fValues == null) continue;

            // If the first column of a new row is null, ignore. 
            fValues = request.getParameterValues("vr" + Integer.toString(i) + "c1");
            if (fValues == null || fValues[0].length() == 0) {
                out.print("<BR>col1 value is empty/null");
            	continue;	
            }
            //out.print("<BR>col1 value=" + fValues[0]);
    
            firstCol = true;

            for (int j = 1; j <= nCols; ++j) { 
	        	fValues = request.getParameterValues("vr" + Integer.toString(i) 
	        					+ "c" + Integer.toString(j)); 
                colValue = fValues[0]; 
	        	colValue = StringOps.getSQLString(colValue);
	        	colName = request.getParameter("vr0c" + Integer.toString(j)); 
	        	if (nKeyColumns > 0 ) {
                   if (isPrimaryKeyColumn(colName)) {
	               if (firstCol == true) { 
	                  firstCol = false;
	                  valuesStr.append(" "); 
	               } else { 
	                  valuesStr.append(" AND "); 
	               } 
                       valuesStr.append(colName);
                   } else {
                       // skip non-primary columns.
                       continue;
                   }
                } else {
                     switch (MetaData.getColType(connX, schemaName, tableName, colName)) {
	             case Types.CHAR:
	             case Types.VARCHAR:
		     case Types.NVARCHAR:
		         colValue = StringOps.convertUtf8ToUnicode(colValue);
		         break;
		     
                     // skip long data columns in where clause.
                     case Types.LONGVARCHAR:
                     case Types.CLOB:
                     case Types.LONGNVARCHAR:
                     case Types.NCLOB:
                     case Types.LONGVARBINARY:
		     case Types.BLOB:
                         continue;
                     }
	             if (firstCol == true) { 
	                  firstCol = false;
	                  valuesStr.append(" "); 
	             } else { 
	                  valuesStr.append(" AND "); 
	             } 
                     valuesStr.append(colName);
                }
	        if (colValue.equalsIgnoreCase("NULL"))
	           valuesStr.append(" IS NULL ");
	        else 
	           valuesStr.append(" = '" + colValue + "'"); 
             } // for j 

             // out.print(stmtStr.toString() + valuesStr.toString()); 
             int n = stmt.executeUpdate(stmtStr.toString() + valuesStr.toString()); 
	        out.print("<BR>Rows deleted: " + n);
        } // for
        connX.commit();
    } catch (java.sql.SQLException se) { 
        connX.rollback();
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
	    
	 </SCRIPT>
<%
     }	   
%>
 
<META http-equiv="refresh" content="0;url=../wji_sqlstmts/ss_results.jsp?conn_no=<%=connNo%>&schema_name=<%=schemaName%>&table_name=<%=tableName%>&sqlstmt=<%=sqlStmt%>" target="rightdatafr">

</BODY>
</HTML>


