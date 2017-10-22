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
 --- Function:		Inserts selected rows (containing column values) in the given table. 
 --- Description:	Inserts NULL values in columns if check box in column value cell is checked.
 -->
<HTML>
<HEAD>
<TITLE>Insert</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>	
<BODY>

<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../wji_common/imports.jsp" %>
<%@include file="../wji_common/connvars.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>


<%-- Prepare a result set --%>
<%
    java.sql.PreparedStatement pStmt;   
    java.sql.Connection connX;
    java.sql.DatabaseMetaData md;
    java.sql.ParameterMetaData pmd;

    StringBuffer stmtStr = null;
    String colValue, fValue, nullInd; 
    boolean skipFlag = false; // skip rows from inserting
    String colName = "";
    String sqlStmt = "";

    int colType = 0;
    String typeName = "";
    String boolStr = "";

    String dbmsName = "";

    String tmpStr = "";
    int index = 0;



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
	    displayMessage("Error:", "", "No inserts are allowed on the resultset of a SELECT statement." +
                     "\n\nChoose a table from left side pane to insert data."); 
	    
        </SCRIPT>
<%
        return;
    }


    try {

	connX.setAutoCommit(false);
	md = connX.getMetaData();
        dbmsName = md.getDatabaseProductName();

        if (md.supportsSchemasInDataManipulation() == true)
            stmtStr = new StringBuffer("INSERT INTO " + schemaName + "." + tableName );   
        else
	    stmtStr = new StringBuffer("INSERT INTO " + tableName);   

        // Add column list
        // W_B_20161222_53 BEGIN: Inserting into a table with single column fails if the insertion is 
        // through “Result” window.
        for (int i = 1; i <= nCols; ++i) {
	    	colName = request.getParameter("vr0c" + Integer.toString(i)); 
            if (i == 1) {
                stmtStr.append(" ( " + colName);
            } else {
                stmtStr.append(", " + colName);
            }
        }
    	stmtStr.append(") VALUES " );
        // Add parameter markers
        for (int i = 1; i <= nCols; ++i) {
            if (i == 1) {
                stmtStr.append(" (?");
            } else {
                stmtStr.append(", ?");
            }
        }
        stmtStr.append(") " );
		// W_B_20161222_53 END
		
        // out.print("stmt=" + stmtStr.toString());

        pStmt = connX.prepareStatement(stmtStr.toString()); 

        /*
         * getParameterData() of MySQL and Oracle do not to work.
         */
        if (dbmsName.equals(DBMS_MYSQL) 
            || dbmsName.equals(DBMS_MARIADB) 
            || dbmsName.equals(DBMS_ORACLE) 
            )  {
            pmd = null;
        } else {
            pmd = pStmt.getParameterMetaData();
        }

        for (int i = 1; i <= nRows; ++i) { 
		    for (int j = 0; j <= nCols; ++j) { 
	            colName = request.getParameter("vr0c" + Integer.toString(j)); 
		        fValue = request.getParameter("vr" + Integer.toString(i) + "c" + Integer.toString(j)); 
		        nullInd = request.getParameter("vnullr" + Integer.toString(i) + "c" + Integer.toString(j)); 
	
		        // If the row is not selected, ignore the rows. --
                if (j == 0) {
		             if (fValue == null) {
			         skipFlag = true;
			         break;
		             } else {
	                         colValue = fValue; 
			         continue;
				     }
	       		 } 

                // If user did not enter any value in a column, assume that 
                // it is NULL as if null check box was checked!
                if (fValue == null || fValue.equals("")) {
		     nullInd = "1";
	        }
                colValue = fValue; // Do not trim here or you can not insert blanks in char columns! 
	        /*
	         * getParameterData() of MySQL does not seem to work.
	         * Till it is made to work, get type info from system tables.
	         */
	        if (pmd == null) {
	            colType = MetaData.getColType(connX, schemaName, tableName, colName);
		    typeName = MetaData.getColTypeName(connX, schemaName, tableName, colName);
	        } else {
	            colType = pmd.getParameterType(j); 
                    typeName = pmd.getParameterTypeName(j);
	        }
		/* 
                out.print("<BR>colType=" + colType + " (" + typeName + "), colName=" + colName + 
		", cValue="+StringOps.convertUtf8ToUnicode(colValue.trim()) +", nullind=" + nullInd);
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
                    pStmt.setNull(j, colType);
	        } else {
	            switch (colType) {
			/*
			* PostgesSQL JDBC driver does not convert  character strings to integers,
			* Hence introduced various cases to convert.
			*/
			case Types.TINYINT:
			    pStmt.setByte(j, Byte.parseByte(colValue.trim()));
			    break;
			case Types.SMALLINT:
			    pStmt.setShort(j, Short.parseShort(colValue.trim()));
			    break;
			case Types.INTEGER:
			    pStmt.setInt(j, Integer.parseInt(colValue.trim()));
			    break;
			case Types.BIGINT:
			    pStmt.setLong(j, Long.parseLong(colValue.trim()));
			    break;
		        case Types.DECIMAL:
		        case Types.NUMERIC:
		            pStmt.setBigDecimal(j, new BigDecimal(colValue.trim()));
		            break;

			case Types.REAL:
			    pStmt.setFloat(j, Float.parseFloat(colValue.trim()));
			    break;
		        case Types.FLOAT:
		            pStmt.setDouble(j, Double.parseDouble(colValue.trim()));
		            break;
		        case Types.DOUBLE:
		            pStmt.setDouble(j, Double.parseDouble(colValue.trim()));
		            break;
				
	                case Types.CHAR:
	                case Types.VARCHAR:
	                case Types.NCHAR:
		        case Types.NVARCHAR:
	                case Types.CLOB:
	                case Types.NCLOB:
		           pStmt.setString(j, StringOps.convertUtf8ToUnicode(colValue.trim()));
		           break;
	                case Types.BINARY:
	                case Types.VARBINARY:
		        case Types.LONGVARBINARY:
	                case Types.BLOB:
                            pStmt.setBytes(j, StringOps.hexToBytes(colValue.trim())); 
		            break;

	                case Types.DATE:
                            if (dbmsName.equals(DBMS_ORACLE)) {
                                pStmt.setTimestamp(j, Timestamp.valueOf(colValue.trim())); 
                            } else {
                                pStmt.setDate(j, Date.valueOf(colValue.trim())); 
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
                            pStmt.setTime(j, Time.valueOf(tmpStr)); 
		            break;
	                case Types.TIMESTAMP:
                            pStmt.setTimestamp(j, Timestamp.valueOf(colValue.trim())); 
		            break;
		        case Types.BOOLEAN:
		            boolStr = colValue.trim().toLowerCase();
		            // DEBUG: out.print("bool=[" + boolStr + "]");
		            if (boolStr.equals("true") || boolStr.equals("t") ||
		   	            boolStr.equals("yes") || boolStr.equals("y") ||
		    	            boolStr.equals("1")) {
		                pStmt.setBoolean(j, true);
		            } else if (boolStr.equals("false") || boolStr.equals("f") ||
		   	            boolStr.equals("no") || boolStr.equals("n") ||
		    	            boolStr.equals("0")) {
		                pStmt.setBoolean(j, false);
		            }
		            break;
                        
		        default:
                            pStmt.setString(j, colValue.trim()); 
	            }		
	        }
            }  // for j 
            if (skipFlag == true) {
	        skipFlag = false;
	        continue;
            }

            // Execute INSERT stmt.
            // out.print(stmtStr.toString());
	    pStmt.executeUpdate(); 
        } // for i 
	connX.commit();
    } catch (java.sql.SQLException se) { 
        connX.rollback();
        // out.print(stmtStr.toString());
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", "<%=StringOps.xForm4JS(se.toString() + "---" + stmtStr.toString())%>"); 
	    
        </SCRIPT>
<%
           // out.print(stmtStr.toString() + valuesStr.toString());
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
<!-- -->
<META http-equiv="refresh" content="0;url=../wji_sqlstmts/ss_results.jsp?conn_no=<%=connNo%>&sqlstmt=<%=sqlStmt%>&schema_name=<%=schemaName%>&table_name=<%=tableName%>">
<!-- -->
</BODY>
</HTML>


