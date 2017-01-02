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
 --- Function:		Updates selected rows in the database.
 --- Description:	The updating is done based on primary key column values. 
 ---				If a table does not have primary keys, updating from table data screen
 ---                is not possible. 
 ---                Further, key columns can not be updated.
 --- 
 -->
 
<HTML>
<HEAD>
<TITLE>Update</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY>

<%-- Processes database updates. --%>

<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../wji_common/imports.jsp" %>
<%@include file="../wji_common/connvars.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>

<%-- Variable definitions --%>
<%! java.sql.ResultSet rs; 
    java.sql.PreparedStatement pStmt; 
    java.sql.ResultSetMetaData rsmd; 
    java.sql.Statement stmt;
    java.sql.DatabaseMetaData md;
    java.sql.ParameterMetaData pmd;

    // Used to access request object from methods.
    HttpServletRequest cRequest = null; 
    
    String colValue, fValue, nullInd, colName;
    boolean skipFlag = false; // skip rows from inserting
    String pkColName = null;

    // Arrays to store column names. Assumes a maximum of 100 columns. 
    String[] columnNames = new String[100]; 
    String[] primaryKeyColumnNames = new String[100]; 
    String[] setClauseColumnNames = new String[100]; 
    String[] whereClauseColumnNames = new String[100]; 
    
    int i = 0; 
    int nColumns = 0;
    int nKeyColumns = 0;
    int nSetColumns = 0;

    int nSetCols = 0, nWhereCols = 0;
    String setCols[] = new String[100];
    String whereCols[] = new String[100];

    String sqlStmt = "";
    String updStmt = "";

    String boolStr = "";
    String dbmsName = "";
    int colType = 0;
    String typeName = "";

    String tmpStr = "";
    int index = 0;
%>

<%-- Make request object available through a class member for methods. --%>
<% cRequest = request; %>

<%-- Extract name of table, number of rows and number of columns passed. --%>
<% 
   String schemaNameStrs[] = request.getParameterValues("schema_name"); 
   String schemaName = schemaNameStrs[0]; 

   String tableNamesStrs[] = request.getParameterValues("table_name");
   String tableName = tableNamesStrs[0]; 

   String nRowsStrs[] = request.getParameterValues("noofrows"); 
   int nRows = Integer.parseInt(nRowsStrs[0]); 

   String nColsStrs[] = request.getParameterValues("noofcolumns");
   int nCols = Integer.parseInt(nColsStrs[0]); 

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

    if (tableName == null || tableName.trim().equals("")) {   
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error:", "", "No updates are allowed on the resultset of a SELECT statement." +
                     "\n\nChoose a table from left side pane to update data."); 
	    
        </SCRIPT>
<%
        return;
    }
%>


<%-- Method definitions begin --%>

<%-- Get primary key column name given form field number. 
     Gets column name corresponding to the passed field number
     from the header field "v0<fFieldNo>". Returns the column name if
     it is one of the primary key column names.
--%>
<%! String getPrimaryKeyColumn(int fFieldNo) 
    {
       String valStrs[] = cRequest.getParameterValues("vr0" + "c" + Integer.toString(fFieldNo) );
       for (int i = 0; i < nKeyColumns; ++i) 
           if (valStrs[0].equals(primaryKeyColumnNames[i])) 
	       return valStrs[0];
       return null;
    }
%>

<%-- Get set clause column name given form field number. --%>
<%-- Gets column name that can be used in the SET clause of an UPDATE
     statement given its form field number. 
     Gets column name corresponding to the passed field number
     from the header field "v0<fFieldNo>". Returns the column name if
     it is one of the set clause column names.
--%>
<%! String getSetClauseColumnName(int fFieldNo) 
   {
       String valStrs[] = cRequest.getParameterValues("vr0" + "c" + Integer.toString(fFieldNo) );
       for (int i = 0; i < nSetColumns; ++i) 
           if (valStrs[0].equals(setClauseColumnNames[i])) 
	       return valStrs[0];
       return null;
   }
%>
<%! 
    int getParameterNumber(String colName) 
    {
       for (int i = 0; i < nSetCols; ++i) 
           if (setCols[i].equals(colName)) 
	       return (i + 1);
       for (int i = 0; i < nWhereCols; ++i) 
           if (whereCols[i].equals(colName)) 
	       return (nSetCols + i + 1);

       return -1;
    }
%>


<%-- Method definitions end --%>

<%
   StringBuffer stmtStr = null;
   if (connX.getMetaData().supportsSchemasInDataManipulation() == true)
      stmtStr = new StringBuffer("UPDATE " + 
		schemaName + "." + tableName); 
   else
      stmtStr = new StringBuffer("UPDATE " + tableName); 
%>

<%-- Get column names and primary key column names of the table to be updated.
--%>
<% try {
   md = connX.getMetaData(); 
   dbmsName = md.getDatabaseProductName();
   // Get columns of the given table from the database. 
   rs = md.getColumns(null, null, tableName, "%"); 
   i = 0; 
   while (rs.next()) {
       columnNames[i] = new String(rs.getString(4)); 
       ++i;
   }
   nColumns = i;
%>

<%-- Get primary key columns of the given table from the database. --%>
<% rs = md.getPrimaryKeys(null, null, tableName); %>
<% i = 0; %>
<% while (rs.next()) {
       primaryKeyColumnNames[i] = new String(rs.getString(4)); %>
	       
       <%-- Debug stmts
       <P>primary key column = [<%=primaryKeyColumnNames[i]%>]</P>
       --%>

       <%
       ++i;
   }
   nKeyColumns = i;
%>

<%-- Form where clause and set clause columns. --%>
<% if (nKeyColumns == 0) { %>
  <SCRIPT LANGUAGE="JavaScript">
    alert("Error: You can not update table having no primary keys!\n" +
          "Use SQL statement facility of wjISQL for updating such tables.");
  </SCRIPT>
  <META http-equiv="refresh" content="0;url=../wji_sqlstmts/ss_results.jsp?schema_name=<%=schemaName%>&table_name=<%=tableName%>&sqlstmt=<%=sqlStmt%>">	  
<% 
    return;
  } else {
	 int k = 0; 
	   boolean keyColumn = false;
	   for (i = 0; i < nColumns; ++i) {
	       keyColumn = false;
	       for (int j = 0; j < nKeyColumns; ++j) {
	           if (columnNames[i].equals(primaryKeyColumnNames[j])) {
		       keyColumn = true;
		       break;
		   }
	       }
	       if (!keyColumn) {
	           setClauseColumnNames[k] = new String(columnNames[i]);
                   %>

		   <%-- Debug stmts.   
	             <P>set claue column name = [<%=columnNames[i]%>]</P>
		   --%>
		   
	           <%
		   ++k;
	       }
	   }
	   nSetColumns = k;
        %>	   
<% } %>
   
<%-- Debug info.
<P>nColumns = <%=nColumns%></P>
<P>nKeyColumns = <%=nKeyColumns%></P>
<P>nSetColumns = <%=nSetColumns%></P>
--%>


<%-- For each row that was selected, form set clause and where clause
     for UPDATE stmt and execute.
--%>

<% 
    connX.setAutoCommit(false);
    StringBuffer setClause = new StringBuffer(" SET "); 
    StringBuffer whereClause = new StringBuffer(" WHERE "); 
    

    // Form stmt for preparation.
    boolean firstSetCol = true, firstWhereCol = true;
    nSetCols = nWhereCols = 0;
    for (int j = 1; j <= nCols; ++j) { 
        pkColName = getPrimaryKeyColumn(j); 
	if (pkColName == null) {
            if (firstSetCol) {
               firstSetCol = false;
            } else {
               setClause.append(", ");
            }
            setCols[nSetCols] = getSetClauseColumnName(j);
	    setClause.append( setCols[nSetCols] + " = ? ");  
            ++nSetCols;
	} else {
            if (firstWhereCol) {
               firstWhereCol = false;
            } else {
               whereClause.append(" AND ");
            }
            whereCols[nWhereCols] = pkColName;
	    whereClause.append(pkColName + " = ? "); 
            ++nWhereCols;
        }
    }

    updStmt =  stmtStr.toString() + setClause.toString() + whereClause.toString();
    //out.print("<BR>stmt=" + updStmt);

    // prepare
    pStmt = connX.prepareStatement(updStmt); 

    /*
     * getParameterData() of MySQL and Oracle do not to work.
     */
    if (dbmsName.equals(DBMS_MYSQL) || dbmsName.equals(DBMS_ORACLE) )  {
        pmd = null;
    } else {
        pmd = pStmt.getParameterMetaData();
    }

    // set params and execute.
    int paramNo = -1;
    for (int i = 1; i <= nRows; ++i) { 
        int l = 0; int m = 0; 
    
        for (int j = 0; j <= nCols; ++j) { 
            colName = request.getParameter("vr0c" + Integer.toString(j)); 
  	    	fValue = request.getParameter("vr" + Integer.toString(i) + "c" + Integer.toString(j)); 
	    	nullInd = request.getParameter("vnullr" + Integer.toString(i) + "c" + 
						Integer.toString(j)); 

	    // If the row is not selected using the 0th field, ignore the row. 
            if (j == 0) {
	        if (fValue == null) {
		    skipFlag = true;
	            break;
	        }
	        else
	           continue;	// to process other columns of the row.
	    } 

            colValue = fValue; // Do not trim here or you can not insert blanks in char columns!
   
            paramNo = getParameterNumber(colName);

	    /*
	     * getParameterData() of MySQL and Oracle do not seem to work.
	     * Till it is made to work, get type info from system tables.
	     */
	    if (pmd == null) {
	        colType = MetaData.getColType(connX, schemaName, tableName, colName);
		typeName = MetaData.getColTypeName(connX, schemaName, tableName, colName);
	    } else {
	        colType = pmd.getParameterType(paramNo); 
                typeName = pmd.getParameterTypeName(paramNo);
	    }
            /* DEBUG  
	    out.print("<BR>paramNo=" + paramNo + ", colType="+ colType + " (" +
	         typeName + "), value=" + StringOps.convertUtf8ToUnicode(colValue));
            */

	    // Remap types due to idiosyncracies of database systems.
	    switch (colType) {
	        case Types.BIT:
	            if (dbmsName.equals(DBMS_POSTGRESQL)) {
		        if (typeName.equals("bool")) {
                            colType = Types.BOOLEAN;
		        }
		    }
                    break;
	         case Types.OTHER:
	             if (dbmsName.equals(DBMS_ORACLE)) {
		         if (typeName.equalsIgnoreCase("NCHAR")) {
                             colType = Types.NCHAR;
		         } else if (typeName.equalsIgnoreCase("NVARCHAR2")) {
			     colType = Types.NVARCHAR;
		         } else if (typeName.equalsIgnoreCase("NCLOB")) {
			     colType = Types.NCLOB;
			 }
		     }
                     break;
	    }
          
	    if (nullInd != null) {
                pStmt.setNull(paramNo, colType); 
                // DEBUG: out.print(", NULL");
	    } else {
	        switch (colType) {
		/*
		 * PostgesSQL JDBC driver does not convert  character strings to integers,
		 * Hence introduced various cases to convert character strings to
		 * appropriate SQL data types.
		 */
		case Types.TINYINT:
		    pStmt.setByte(paramNo, Byte.parseByte(colValue.trim()));
		    break;
		case Types.SMALLINT:
		    pStmt.setShort(paramNo, Short.parseShort(colValue.trim()));
		    break;
		case Types.INTEGER:
		    pStmt.setInt(paramNo, Integer.parseInt(colValue.trim()));
		    break;
		case Types.BIGINT:
		    pStmt.setLong(paramNo, Long.parseLong(colValue.trim()));
		    break;
		case Types.DECIMAL:
		case Types.NUMERIC:
		    pStmt.setBigDecimal(paramNo, new BigDecimal(colValue.trim()));
		    break;

		case Types.REAL:
		    pStmt.setFloat(paramNo, Float.parseFloat(colValue.trim()));
		    break;
		case Types.FLOAT:
		    pStmt.setDouble(paramNo, Double.parseDouble(colValue.trim()));
		    break;
		case Types.DOUBLE:
		    pStmt.setDouble(paramNo, Double.parseDouble(colValue.trim()));
		    break;
		
	        case Types.CHAR:
	        case Types.VARCHAR:
	        case Types.NCHAR:
		case Types.NVARCHAR:
	        case Types.CLOB:
	        case Types.NCLOB:
		case Types.LONGNVARCHAR: // MS SQL NTEXT 
		    pStmt.setString(paramNo, StringOps.convertUtf8ToUnicode(colValue));
		    break;
	        case Types.BINARY:
	        case Types.VARBINARY:
		case Types.LONGVARBINARY:
	        case Types.BLOB:
		    // out.print("colValue=" + colValue + ", length=" + colValue.length());
		    byte ba[] = StringOps.hexToBytes(colValue.trim());
		    // out.print("ba length=" + ba.length);
                    pStmt.setBytes(paramNo, StringOps.hexToBytes(colValue.trim())); 
		    break;

	        case Types.DATE:
		    if (dbmsName.equals(DBMS_ORACLE)) {
                        pStmt.setTimestamp(paramNo, Timestamp.valueOf(colValue.trim())); 
                    } else {
                        pStmt.setDate(paramNo, Date.valueOf(colValue.trim())); 
                    }
		    break;
	        case Types.TIME:
		    /*
		     * Ignore any fractional seconds in time values as Time class
		     * does not support them.
		     */
		    tmpStr = colValue.trim();
		    index = tmpStr.indexOf('.');
		    if (index != -1) {
                       tmpStr = tmpStr.substring(0, index);
		    }
                    pStmt.setTime(paramNo, Time.valueOf(tmpStr)); 
		    break;
	        case Types.TIMESTAMP:
                    pStmt.setTimestamp(paramNo, Timestamp.valueOf(colValue.trim())); 
		    break;
		case Types.BOOLEAN:
		    boolStr = colValue.trim().toLowerCase();
		    // DEBUG: out.print("bool=[" + boolStr + "]");
		    if (boolStr.equals("true") || boolStr.equals("t") ||
		   	    boolStr.equals("yes") || boolStr.equals("y") ||
		    	    boolStr.equals("1")) {
		        pStmt.setBoolean(paramNo, true);
		    } else if (boolStr.equals("false") || boolStr.equals("f") ||
		   	    boolStr.equals("no") || boolStr.equals("n") ||
		    	    boolStr.equals("0")) {
		        pStmt.setBoolean(paramNo, false);
		    }
		    break;

		default:
                    pStmt.setString(paramNo, colValue.trim()); 
	        }		
       	    }
	}
        if (skipFlag == true) {
	    skipFlag = false;
	    continue;
	}
    
        // Execute the stmt. 
        pStmt.executeUpdate();
    } 

    connX.commit();
  } catch (java.sql.SQLException se) { 
    connX.rollback();
     
%>

        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
	    
        </SCRIPT>

<%
  } catch (NumberFormatException e) { 
    connX.rollback();
     
%>

        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "", 
	         "<%=StringOps.xForm4JS(e.toString())%>"); 
	    
        </SCRIPT>

<%
  } catch (Exception e) { 
    connX.rollback();
%>

        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "", 
	         "<%=StringOps.xForm4JS(e.toString())%>"); 
	    
        </SCRIPT>

<%
   }	   
%>
<META http-equiv="refresh" content="0;url=../wji_sqlstmts/ss_results.jsp?conn_no=<%=connNo%>&schema_name=<%=schemaName%>&table_name=<%=tableName%>&sqlstmt=<%=sqlStmt%>" target="rightdatafr">

</BODY>
</HTML>


