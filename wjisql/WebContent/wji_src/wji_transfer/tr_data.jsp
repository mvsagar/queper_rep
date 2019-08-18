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
 --- Function:		Transfer data from selected tables of source database to corresponding tables
 --- 				of destination databases.
 --- Description:	1.	The destination database and tables to which data from source tables should already
 ---                	exist. 
 ---                2. 	Columns of destination tables should be type compatible with corresponding
 ---      				columns of source tables.
 ---				3.	If destination table has columns that are not in the source table, such columns
 ---					are ignored. For successful data transfer, such columns should be nullable or 
 ---					should have default values.
 ---				4. 	All errors that may occur are not displayed. 
 ---				5.	Data from destination table is deleted if user indicates on the data transfer screen.
 ---				6. 	Foreign key constraints are disabled on the tables of destination database before
 ---					data transfer starts. They are re-enabled after data transfer completes.
 -->

<HTML>
<HEAD>
<TITLE>Data Transfer Status</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY>

<%-- Get database connection --%>
<%@include file="../wji_common/imports.jsp" %>
<%@include file="../wji_common/connvars.jsp" %>

<%
   java.sql.Statement stmt = null;
   java.sql.PreparedStatement pSelStmt = null, pInsStmt = null;;
   java.sql.ResultSet rs = null;
   java.sql.DatabaseMetaData md1 = null, md2 = null; 
   java.sql.ResultSetMetaData rsmd = null; 

   int MAX_ERRORS = 5;
   String bgColorRows = "WHITE";
   String fgColorRows = "DARK";

   int i = 0, j = 0;
   int nCols = 0;
   boolean firstTime = true;
   boolean errFlag = false;
   String tName1 = "";
   String tName2 = "";
   String colName = "";
   String fValue = "";
   String stmtStr = "";

   String nRowsStr1 = request.getParameter("nrows1");
   int nRows1 = 0;
   if (nRowsStr1 != null) 
       nRows1 = Integer.parseInt(nRowsStr1); 
   String nRowsStr2 = request.getParameter("nrows2");
   int nRows2 = 0;
   if (nRowsStr2 != null) 
       nRows2 = Integer.parseInt(nRowsStr2); 

   /* DEBUG 
   out.print("nRows1="+nRows1 + ", nRows2=" + nRows2);
   */

   String schemaNameStr1 = request.getParameter("schema_name1");
   String schemaName1 = null;
   if (schemaNameStr1 != null) 
       schemaName1 = schemaNameStr1;

   String schemaNameStr2 = request.getParameter("schema_name2");
   String schemaName2 = null;
   if (schemaNameStr2 != null) 
       schemaName2 = schemaNameStr2;
       
   String[] srcTblNames = new String[nRows1];
   int[] srcTblRows = new int[nRows1];
   int[] destTblRows = new int[nRows1];
   StringBuffer[] srcErrs   = new StringBuffer[nRows1];
   int srcErrNo = 0;
   StringBuffer[] destErrs   = new StringBuffer[nRows1];
   int destErrNo = 0;
   String[] miscErrs = new String[MAX_ERRORS];
   int miscErrNo = 0;
   StringBuffer[] warnings = new StringBuffer[nRows1];
   int warningNo = 0;

   java.lang.Object obj = null;
   Clob clob = null;
   NClob nclob = null;
   byte[] byteArray = null;
   InputStream textStrm = null;

   StringBuffer srcErrSb, destErrSb; 

   boolean delete_rows = false;

   String srcDBMS = "";
   String destDBMS = "";

   ArrayList<MdColumn> srcColList = null;
   ArrayList<MdColumn> destColList = null;
   ArrayList<MdColumn> commonColList = null;
   ArrayList<MdColumn> destNonSrcColList = null;
   int srcSize = 0;
   int destSize = 0;
   int commonSize = 0;
   int destNonSrcSize = 0;

   MdColumn mdCol = null;

   String val = null;
   String hexVal = null;
   String tmpStr = null;
   String boolStr = null;
   InputStream binStrm = null;
   int index = -1;
   
%>

<FORM NAME="tr_result_form" METHOD="POST">

<%-- @include file="tr_data_buttons.jsp" --%>

<%
    if (conn1 == null) {
        out.print("<BR><BR><BR>");
        out.print("<P ALIGN=CENTER>No source database connection exists.</P>");
        out.print("<P ALIGN=CENTER>Connect to a database first and try again.</P>");
        return;
    }
    if (conn2 == null) {
        out.print("<BR><BR><BR>");
        out.print("<P ALIGN=CENTER>No destination database connection exists.</P>");
        out.print("<P ALIGN=CENTER>Connect to a database first and try again.</P>");
        return;
    }
%>

<H2>Data Transfer Status</H2>
<TABLE BORDER=1>
<TR>
<TH></TH><TH>Database</TH><TH>User</TH><TH>Schema</TH>
</TR>
<TR>
<TH>From</TH> <TD><%=conn1%> </TD> <TD><%=userId1%></TD><TD><%=(schemaName1 == null ? "(None)" : schemaName1)%></TD>
</TR>
<TR>
<TH>To</TH> <TD><%=conn2%> </TD> <TD><%=userId2%></TD><TD><%=(schemaName2 == null ? "(None)" : schemaName2)%></TD>
</TR>
</TABLE>	

<% 
    try {
        md1 = conn1.getMetaData(); 
		srcDBMS = md1.getDatabaseProductName();
        md2 = conn2.getMetaData(); 
		destDBMS = md2.getDatabaseProductName();
    } catch (java.sql.SQLException se) {
        miscErrs[miscErrNo++] = se.toString(); 
    }


    /*
     * Disable constraints or set deferrable.
     */
    try {
        out.print("<BR><BR>Disabling Constraints temporarily...");
        stmt = conn2.createStatement();
	if (destDBMS.equalsIgnoreCase(DBMS_SQLITE) == true) {
            stmt.executeUpdate("PRAGMA foreign_keys=OFF");
	} else if (destDBMS.equalsIgnoreCase(DBMS_MYSQL) == true
                  || destDBMS.equalsIgnoreCase(DBMS_MARIADB) == true
	              ) {
            stmt.executeUpdate("SET FOREIGN_KEY_CHECKS=0");
	} else if (destDBMS.equalsIgnoreCase(DBMS_MSSQLSERVER) == true) {
            stmt.executeUpdate("EXEC sp_msforeachtable \"ALTER TABLE ? NOCHECK CONSTRAINT all\"");
	} else if (destDBMS.equalsIgnoreCase(DBMS_POSTGRESQL) == true) {
            /* 
             * There does not seem to be a stmt to disable constraints
             * temporarily in postgresql. Hence at least defer them.
             */
            stmt.executeUpdate("SET CONSTRAINTS ALL DEFERRED");
	} 
	stmt.close();
	out.print("<BR>Disabled Constraints temporarily...<BR>");
    } catch (java.sql.SQLException se) {
        if (miscErrNo < MAX_ERRORS) {
            miscErrs[miscErrNo] = "<BR>ERROR[" + miscErrNo + 
                         "]: Could not disable constraints; " + se.toString();
            ++miscErrNo;
        }
    }

    /*
    * Set autocommit to false so that all tables are transferred in a single transaction.
    */
    conn2.setAutoCommit(false);

    /* v1.9.1:2014-07-21: Initialize the vars so that errors get printed if control
    * breaks in the for-loop after the following initializing for-loop.
    */
    // W_20160510_29:BEGIN
    for (i = 0; i < nRows1; ++i) {

        srcTblRows[i] = destTblRows[i] = 0;
        srcTblNames[i] = "";
        srcErrs[i] = new StringBuffer("");
        destErrs[i] = new StringBuffer("");
        warnings[i] = new StringBuffer("");
    }
    for (i = 0; i < MAX_ERRORS; ++i) {
        miscErrs[i] = "";
    }
    // W_20160510_29:END
    for (i = 0; i < nRows1; ++i) {
        errFlag = false;
        warningNo = 0;
        // Buffers to hold all errors for a table.
	srcErrSb = srcErrs[i];
	destErrSb = destErrs[i];
	 
	/* Clear previous array elements before creating new array list. */
	if (srcColList != null) srcColList.clear();
	if (destColList != null) destColList.clear();
	if (commonColList != null) commonColList.clear();
	if (destNonSrcColList != null) destNonSrcColList.clear();

	srcColList = new ArrayList<MdColumn>();
	destColList = new ArrayList<MdColumn>();
	commonColList = new ArrayList<MdColumn>();
	destNonSrcColList = new ArrayList<MdColumn>();

    fValue = request.getParameter("t"+i);
    if (fValue == null) continue;
    tName1 = tName2 = srcTblNames[i] = fValue.trim();
	if (srcDBMS.equals(DBMS_ORACLE)) {tName1 = tName1.toUpperCase();}
	if (destDBMS.equals(DBMS_ORACLE)) {tName2 = tName2.toUpperCase();}

	// Check if check box is ticked to transfer data.
        fValue = request.getParameter("c1"+i);
        if (fValue == null) continue;

	// Check if check box delete rows in destination table is ticked.
        fValue = request.getParameter("c2"+i);
        if (fValue == null) delete_rows = false;
		else delete_rows = true;
		// out.print("i=" + i + "del="+delete_rows);
    
        StringBuffer colList = new StringBuffer(" ");
        
        /* DEBUG
        out.print("sch1="+schemaName1);
        out.print(", tname1="+tName1);
        out.print(", sch2="+schemaName2);
        out.print(", tname2="+tName2);
        */

        try {
        	/*
        	 * The following code assumes table name in dest db is exactly same as
        	 * as the table name in source. But this may not be true. For example,
        	 * if table name is in uppper case in Oracle, and it is in lower case
        	 * in mysql (destination), getColumnList() may not find the tanle.
        	 * TBF.
        	 */
		    MetaData.getColumnList(conn1, schemaName1, tName1, srcColList);
		    MetaData.getColumnList(conn2, schemaName2, tName2, destColList);
		    destSize = destColList.size();
		    if (destSize == 0) {
			    MetaData.getColumnList(conn2, schemaName2, tName2.toLowerCase(), destColList);
			    destSize = destColList.size();
			    if (destSize == 0) {
				    MetaData.getColumnList(conn2, schemaName2, tName2.toUpperCase(), destColList);
				    destSize = destColList.size();
			    }
		    }
		    MetaData.getCommonColList(srcColList, destColList, commonColList, destNonSrcColList); 
        } catch (Exception e) {
            if (miscErrNo < MAX_ERRORS) {
                miscErrs[miscErrNo] = "<BR>ERROR[" + miscErrNo + 
                         "]: Could not get columns data for the tables; " + e.toString();
                ++miscErrNo;
            }
            conn2.rollback();
	    /* DEBUG 
	    out.print(" i="+i+") " + e.toString());
	    */
            break;
        }
	srcSize = srcColList.size();
	destSize = destColList.size();
	commonSize = commonColList.size();
	destNonSrcSize = destNonSrcColList.size();

	/* DEBUG
	out.print("<BR>srcColList size=" + srcSize); 
	out.print("<BR>destColList size=" + destSize); 
	out.print("<BR>commonColList size=" + commonSize); 
	out.print("<BR>destNonSrcColList size=" + destNonSrcSize); 
	*/

	if (destSize == 0) {
	    ++warningNo;
	    warnings[i].append((warningNo == 1 ? "" : "<BR>") + warningNo + ") " +
                "<SPAN STYLE=\"COLOR:RED;\">Table does not exist in the destination database;" +
	        " the table data was not copied.</SPAN>");
            continue;
	}
     
	if (commonSize == 0) {
	    ++warningNo;
	    warnings[i].append((warningNo == 1 ? "" : "<BR>") + warningNo + ") " +
                "<SPAN STYLE=\"COLOR:RED;\">Source and destination tables do not have any common columns;" +
	        " the table data was not copied.</SPAN>");
            continue;
	}

	if (srcSize != destSize) {
	    ++warningNo;
	    warnings[i].append((warningNo == 1 ? "" : "<BR>") + warningNo + 
	            ") <SPAN STYLE=\"COLOR:RED;\">Number of columns in source (" + srcSize + ") " +
		    " and destination table (" + destSize + ")  are not equal.</SPAN>");
	}

	/*
	* Check if there are any columns in destination table that are not in source table,
	* and if so if destination DBMS can insert a value for the column. If not note an error
	* and continue.
	*/
	if (destNonSrcSize > 0) {
	    ++warningNo;
            warnings[i].append((warningNo == 1 ? "" : "<BR>") + warningNo + 
             ") <SPAN STYLE=\"COLOR:RED;\">Destination table has the following columns " +
             " not in the source table:</SPAN>" +
                               "<BR><SPAN STYLE=\"COLOR:BLUE;\">");
	    for (j = 0; j < destNonSrcSize; ++j) {
	        mdCol = destNonSrcColList.get(j);
                if (j == 0) warnings[i].append(mdCol.getColName());
                else warnings[i].append(", " + mdCol.getColName());
                /* DEBUG
                out.print("<BR>"+ mdCol.getColName() + 
                           ": is nullable=" + mdCol.isColNullable() + 
                           ", autoincr?=" + mdCol.isColAutoIncrement());
                */
		if (mdCol.isColNullable() == true ||
	       	        (mdCol.isColNullable() == false && mdCol.getColDefault() != null) ||
		        mdCol.isColAutoIncrement() == true) {
                     /*
                      * The column which is not in the source table is OK for copying if it satisfies 
                      * any of the following conditions:
                      * 	- Column is nullable.
                      * 	- Column is not nullable but it has a default value.
                      * 	- Column is an autoincrrment column.
                      */
		} else {
	            ++warningNo;
                    warnings[i].append((warningNo == 1 ? "" : "<BR>") + warningNo + ") " + 
		        "Destination table column <SPAN STYLE=\"COLOR:RED;\">" + tName2 + "." + mdCol.getColName() + 
			" is not present in the source table and it is neither nullable, " +
			" nor is it a non nullable column with a default value " +
			" nor is it an autoincrement column</SPAN>; can not copy data.</SPAN>");
                    errFlag = true;
		    break;
		}
	    }
	    /* DEBUG 
               out.print("<BR>ErrFlag=" + errFlag);
             */
            if (errFlag) continue;
	    else warnings[i].append("</SPAN>");
            warnings[i].append("<BR><SPAN STYLE=\"COLOR:RED;\">NULLs</SPAN> " +
                "or <SPAN STYLE=\"COLOR:RED;\">default values</SPAN> are inserted into the above columns."); 
	}

	/*
	* Form column list for selecting columns from the source table
	* and for using as column list of destination table for inserting
	* rows.
	*/
        firstTime = true;
        nCols = commonSize;
        for (j = 0; j < nCols; ++j) {
            colName = commonColList.get(j).getColName();
            if (firstTime == false) {
                colList.append(", ");
            }
            colList.append(colName);
            firstTime = false;
        }
	/* DEBUG 
	out.print("<BR>Col list = " + colList.toString());
        */
        
        stmtStr = " SELECT " + colList.toString() + " FROM " + tName1;
        if (srcSize != destSize) {
	    ++warningNo;
	    warnings[i].append((warningNo == 1 ? "" : "<BR>") + warningNo + 
	        ") Data of only the following columns is transferred - " + 
                colList + "."); 
        }
        out.print("<BR>[" + (i+ 1) + "] " + stmtStr);

	/* DEBUG 
	out.print("<BR>[" + (i+1) + "] " +  stmtStr);
	*/

	try {
            pSelStmt = conn1.prepareStatement(stmtStr);
            rs = pSelStmt.executeQuery();
            rsmd = rs.getMetaData();
        } catch (java.sql.SQLException se) {
            if (srcErrNo < MAX_ERRORS) {
                ++srcErrNo;
                srcErrSb.append("<BR>ERROR[" + srcErrNo + "]: Error executing stmt : [" + 
                                stmtStr + "]: " + se.toString());
				continue;
            }
        }

        StringBuffer ins = new StringBuffer(" INSERT INTO " + tName2 + " ( " + colList + " ) VALUES ( ");
        firstTime = true;
        for (j = 0; j < nCols; ++j) {
            if (firstTime == false) {
                ins.append(", ");
            }
            ins.append("?"); 
            firstTime = false;
        }
        ins.append(" ) "); 
        out.print("<BR>[" + (i+ 1) + "] " + ins.toString());


	if (delete_rows) {
	    try {
                stmt = conn2.createStatement();
                stmt.executeUpdate("DELETE FROM " + tName2);
                stmt.close();
	    } catch (java.sql.SQLException se) {
                if (destErrNo < MAX_ERRORS) {
                   ++destErrNo;
                   destErrSb.append("<BR>ERROR[" + destErrNo + 
                         "]: Write ERROR for DELETE Statement: [" + tName2 + "]:[" + se.getErrorCode() + "]" + se.toString());
                }
	        continue;
	    }
	}
       
        int ct = 0 ; // source column type.
	String tn = ""; // source type name.
        String cn = "";  // source table column name.
        int dct = 0; // destination table column type.
        String dtn = ""; // destination table column type name.
        String dcn = "";  // destination table column name.
	boolean isNull = false;
        ParameterMetaData pmd = null;
        while (rs.next()) {
            ++(srcTblRows[i]);
            errFlag = false;
	    /*
	    * Prepare the stmt used for inserting into destination table.
	    * The stmt may fail if columns referred to in the destination table do not exist.
	    */
	    try {
                pInsStmt = conn2.prepareStatement(ins.toString());

                /*
                 * Get aparameter meata data so that it can be passed
                 * to setNull(). This is needed because MS SQL server refuses
                 * if incorrect data type is passed to it eventhough the
                 * value is NULL.
                 *
                 * getParameterData() of MySQL and Oracle do not to work.
                 */
                if (destDBMS.equals(DBMS_MYSQL) 
                    || destDBMS.equals(DBMS_MARIADB) 
                    || destDBMS.equals(DBMS_ORACLE) 
                    )  {
                    pmd = null;
                } else {
                    pmd = pInsStmt.getParameterMetaData();
                } 
	    } catch (java.sql.SQLException se) {
                if (destErrNo < MAX_ERRORS) {
                   ++destErrNo;
                   destErrSb.append("<BR>ERROR[" + destErrNo + 
                         "]: Prepare faild for stmt: [" + ins.toString() + "]:[" + se.getErrorCode() + "]" + se.toString());
                }
	        break;
	    }

            /*
             * Read column values from source table and insert into destination table.
             *
             *  NB: As SQLite does not support stream related menthods for CLOB and BLOB types,
             *  data trnasfer is done using getString() and getBytes() which may throw
             *  error in case of large amounts of data.
             */
            /* DEBUG 
	    out.print("<BR>ncols="+nCols);
            */
            for (j = 1; j <= nCols; ++j) {
                try {
                    ct = rsmd.getColumnType(j);
                    tn = rsmd.getColumnTypeName(j);
                    cn = commonColList.get(j-1).getColName();
		            isNull = false;

	            /*
	             * getParameterData() of MySQL and Oracle do not seem to work.
	             * Till it is made to work, get type info from system tables.
	             */
	            if (pmd == null) {
	                dct = MetaData.getColType(conn2, schemaName2, tName2, cn);
		        dtn = MetaData.getColTypeName(conn2, schemaName2, tName2, cn);
	            } else {
	                dct = pmd.getParameterType(j); 
                        dtn = pmd.getParameterTypeName(j);
	            }


		    /* DEBUG 
		    out.print((j == 1 ? "<BR><BR>" : "<BR>") + j + ") Col=" + cn + 
                           ", Original src type="+ct + "(" + tn + ")");
		    */

                    // Remap types due to idiosyncracies of database systems.
		    switch (ct) {
	            case Types.BIT:
	                if (srcDBMS.equals(DBMS_POSTGRESQL)) {
		            if (tn.equals("bool")) {
                                 ct = Types.BOOLEAN;
		            }
		        }
                        break;
	            case Types.OTHER:
	                if (srcDBMS.equals(DBMS_ORACLE)) {
		            if (tn.equalsIgnoreCase("NCHAR")) {
                                 ct = Types.NCHAR;
		            } else if (tn.equalsIgnoreCase("NVARCHAR2")) {
			         ct = Types.NVARCHAR;
		            } else if (tn.equalsIgnoreCase("NCLOB")) {
			         ct = Types.NCLOB;
			    }
		        }
                        break;
                     
                    case Types.NULL: 
                        /*
                         * SQLite returns 0 (Types.NULL) as the data type for columns having
                         * NULLs. If this 0 is passed as type to setNULL() method, MS SQL server
                         * throws an error. May be other DBMSss also throw the error. Hence 
                         * the following hack.
                         */
	                if (srcDBMS.equals(DBMS_SQLITE)) {
                            ct = Types.CHAR;
                        }
                        break;
	            }
                   
	            if (destDBMS.equals(DBMS_SQLITE)) {
		        if (ct != Types.BINARY && ct != Types.VARBINARY &&
                                ct != Types.BLOB && ct != Types.LONGVARBINARY) { 
                            ct = Types.VARCHAR;
                        }
                    }

		    switch (dct) {
	            case Types.BIT:
	                if (destDBMS.equals(DBMS_POSTGRESQL)) {
		            if (dtn.equals("bool")) {
                                 dct = Types.BOOLEAN;
		            }
		        }
                        break;
	            case Types.OTHER:
	                if (destDBMS.equals(DBMS_ORACLE)) {
		            if (dtn.equalsIgnoreCase("NCHAR")) {
                                 dct = Types.NCHAR;
		            } else if (dtn.equalsIgnoreCase("NVARCHAR2")) {
			         dct = Types.NVARCHAR;
		            } else if (dtn.equalsIgnoreCase("NCLOB")) {
			         dct = Types.NCLOB;
			    }
		        }
                        break;
                     
	            }
		    /* DEBUG  
		    out.print(", after remap ct="+ct + ", Dest ct=" + dct);
		     */

                   /* Retrieve data for the column from the source table. */
                   switch (ct) {
                   case Types.BLOB :
                   case Types.LONGVARBINARY : 
	               if (conn1.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_SQLITE) == true) {
	                   byte[] byteArr = rs.getBytes(j);
		           if (rs.wasNull()) {
                              isNull = true;
		           } else {
		              binStrm = new ByteArrayInputStream(byteArr);
		           }
	               } else {
                           binStrm = rs.getBinaryStream(j); 
		           if (rs.wasNull()) {
		              isNull = true;
		           }
	               }
                       try {
                          if (isNull == false) {
                             int avlBytes = binStrm.available();
                             byteArray = new byte [512]; 
			     int bytesRead = binStrm.read(byteArray);

			     StringBuffer hexStr = new StringBuffer("");
                             while (bytesRead > 0) {
			         hexStr.append(StringOps.bytesToHex(byteArray));
	                         bytesRead = binStrm.read(byteArray);
                             }
                             hexVal = hexStr.toString();
                          }
                       } catch (IOException ioe) {
                             // TBD
                       }
                       break;
                   case Types.BINARY:
                   case Types.VARBINARY:
		       byte ba[] = rs.getBytes(j);
                       if (rs.wasNull()) {
                           isNull = true;
                       } else {
                           hexVal = StringOps.bytesToHex(ba);
                       }
                       break;
                   case Types.CHAR:
                   case Types.VARCHAR:
                   case Types.LONGVARCHAR:
                   case Types.NCHAR:
                   case Types.NVARCHAR:
                   case Types.LONGNVARCHAR:
		       val = rs.getString(j);
                       if (rs.wasNull()) {
                           isNull = true;
                       } 
                       break;
                   default:
		       val = rs.getString(j);
                       if (rs.wasNull()) {
                           isNull = true;
                       } 
                    }
                } catch (java.sql.SQLException se) {
                    if (srcErrNo < MAX_ERRORS) {
                        ++srcErrNo;
                        srcErrSb.append("<BR>ERROR[" + srcErrNo + "]: Read ERROR: [" + 
                                tName1 + "," + rsmd.getColumnLabel(j) + "]: " + se.toString());
                        errFlag = true;
                    }
                    break;
                }

		/*
                 * Set the read column value to the corresponding parameter 
                 * of the ins stmt used to insert a row in the destination 
                 * table.
                 */

                /* Set parameter based on the input type for all DBMSs
                 * other than ORACLE as it fails if char data is passed
                 * to date columns due to ORACLE required timestamp format
                 * for date.
                 */
                if (!destDBMS.equals(DBMS_ORACLE) && !destDBMS.equals(DBMS_POSTGRESQL)) {
                   dct = ct;
                }
                try {
                    if (isNull == true) {
                        pInsStmt.setNull(j, dct); 
                    } else {
	            switch (dct) {
			case Types.TINYINT:
			    pInsStmt.setByte(j, Byte.parseByte(val));
			    break;
			case Types.SMALLINT:
			    pInsStmt.setShort(j, Short.parseShort(val));
			    break;
			case Types.INTEGER:
			    pInsStmt.setInt(j, Integer.parseInt(val));
			    break;
			case Types.BIGINT:
			    pInsStmt.setLong(j, Long.parseLong(val));
			    break;
		        case Types.DECIMAL:
		        case Types.NUMERIC:
		            pInsStmt.setBigDecimal(j, new BigDecimal(val));
		            break;

			case Types.REAL:
			    pInsStmt.setFloat(j, Float.parseFloat(val));
			    break;
		        case Types.FLOAT:
		            pInsStmt.setDouble(j, Double.parseDouble(val));
		            break;
		        case Types.DOUBLE:
		            pInsStmt.setDouble(j, Double.parseDouble(val));
		            break;
				
	                case Types.CHAR:
	                case Types.VARCHAR:
	                case Types.NCHAR:
		        case Types.NVARCHAR:
	                case Types.CLOB:
	                case Types.NCLOB:
		           //pInsStmt.setString(j, StringOps.convertUtf8ToUnicode(val));
		           pInsStmt.setString(j, val);
		           break;
	                case Types.BINARY:
	                case Types.VARBINARY:
		        case Types.LONGVARBINARY:
	                case Types.BLOB:
                            pInsStmt.setBytes(j, StringOps.hexToBytes(hexVal)); 
		            break;

	                case Types.DATE:
                            if (destDBMS.equals(DBMS_ORACLE)) {
				if (val.length() == 10) { // only date. 
                                    pInsStmt.setDate(j, Date.valueOf(val)); 
				} else {
                                    pInsStmt.setTimestamp(j, Timestamp.valueOf(val)); 
				}
                            } else {
                                pInsStmt.setDate(j, Date.valueOf(val)); 
                            }
		            break;
	                case Types.TIME:
		            /*
		             * Ignore any fractional seconds in time values as Time class
		             * does not support them.
		             */
		            tmpStr = val;
		            index = tmpStr.indexOf('.');
			    if (index != -1) {
                                tmpStr = tmpStr.substring(0, index);
			    }
                            pInsStmt.setTime(j, Time.valueOf(tmpStr)); 
		            break;
	                case Types.TIMESTAMP:
                            /*
                             * Oracle driver returns TIMESTAMP data type
                             * for DATE column; hence the following code.
                             */
                            if (destDBMS.equals(DBMS_ORACLE)) {
				if (val.length() == 10) { // only date. 
                                    pInsStmt.setDate(j, Date.valueOf(val)); 
				} else {
                                    pInsStmt.setTimestamp(j, Timestamp.valueOf(val)); 
				}
                            } else {
                                pInsStmt.setTimestamp(j, Timestamp.valueOf(val)); 
                            }
		            break;
		        case Types.BOOLEAN:
		            boolStr = val.toLowerCase();
		            // DEBUG: out.print("bool=[" + boolStr + "]");
		            if (boolStr.equals("true") || boolStr.equals("t") ||
		   	            boolStr.equals("yes") || boolStr.equals("y") ||
		    	            boolStr.equals("1")) {
		                pInsStmt.setBoolean(j, true);
		            } else if (boolStr.equals("false") || boolStr.equals("f") ||
		   	            boolStr.equals("no") || boolStr.equals("n") ||
		    	            boolStr.equals("0")) {
		                pInsStmt.setBoolean(j, false);
		            }
		            break;
                        
		        default:
                            pInsStmt.setString(j, val); 
	            }	// switch.
                    }
                } catch (java.sql.SQLException se) {
                    if (destErrNo < MAX_ERRORS) {
                       ++destErrNo;
                       destErrSb.append("<BR>ERROR[" + destErrNo + "]: Write ERROR: [" + tName2 + "," + rsmd.getColumnLabel(j) + "]: " + se.getErrorCode() + se.toString());
                       errFlag = true;
                    }
                    break;
                } catch (Exception e) {
                    if (destErrNo < MAX_ERRORS) {
                       ++destErrNo;
                       destErrSb.append("<BR>ERROR[" + destErrNo + "]: Write ERROR: [" + tName2 + "," + rsmd.getColumnLabel(j) + "]:" + e.toString());
                       errFlag = true;
                    }
                    break;
                } 
            } // for each column

            if (errFlag == false) {
                // Execute insert stmt.
                try {
                    pInsStmt.executeUpdate();
                    ++(destTblRows[i]);
                } catch (java.sql.SQLException se) {
                    errFlag = true;
                    if (destErrNo < MAX_ERRORS) {
                        ++destErrNo;
                        destErrSb.append("<BR>ERROR[" + destErrNo + "]: Write ERROR for ins stmt exec: [" + tName2 +  "]: " + 
                             se.toString());
                    }
                }
            }
            pInsStmt.close();
        }  // while for reading and inserting.
        rs.close();
        pSelStmt.close();
    } // for each tbl.	  

    /* Commit at the end of trasfer of data of all selected tables. */
    conn2.commit();

    if (srcColList != null) srcColList.clear();
    if (destColList != null) destColList.clear();
    if (commonColList != null) commonColList.clear();
    if (destNonSrcColList != null) destNonSrcColList.clear();

    /*
     * Enable constraints.
     */
    conn2.setAutoCommit(false);
    try {
    out.print("<BR><BR>Enabling Constraints...");
        stmt = conn2.createStatement();
	if (destDBMS.equalsIgnoreCase(DBMS_SQLITE) == true) {
	    // Nothing is reqd.
	} else if (destDBMS.equalsIgnoreCase(DBMS_MYSQL) == true
	           || destDBMS.equalsIgnoreCase(DBMS_MARIADB) == true
	    ) {
	    // Nothing is reqd.
	} else if (destDBMS.equalsIgnoreCase(DBMS_MSSQLSERVER) == true) {
            stmt.executeUpdate("EXEC sp_msforeachtable \"ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all\"");
	}
	stmt.close();
        conn2.commit();
	out.print("<BR>Enabled Constraints...<BR><BR>");
    } catch (java.sql.SQLException se) {
        if (miscErrNo < MAX_ERRORS) {
            miscErrs[miscErrNo] = "<BR>ERROR[" + miscErrNo + 
                         "]: Could not enable constraints; " + se.toString();
            ++miscErrNo;
        }
        conn2.rollback();
    }


%>

<TABLE BORDER=1 id='tbl-xfr-status'>
    <THEAD>
        <TR>      
            <TH>SNO</TH><TH>Table</TH><TH># Rows Read</TH><TH> # Rows Wrote</TH><TH># Read Errors</TH><TH> # Write Errors</TH>
<TH>Other Errors/Warnings</TH>
        </TR>
    </THEAD>
    <TBODY>

<%
    for (i = 0; i < nRows1; ++i) {

        out.print("<TR>");
        out.print("<TD>" + (i+1) + "</TD>");
        out.print("<TD>"+srcTblNames[i] + "</TD>");
		out.print("<TD>"+srcTblRows[i] + "</TD>");
		if (destTblRows[i] != srcTblRows[i]) {
		    bgColorRows = "RED";
		    fgColorRows = "WHITE";
		} else {
		    bgColorRows = "WHITE";
		    fgColorRows = "BLACK";
        } 
        out.print("<TD STYLE=\"BACKGROUND:" + bgColorRows + ";COLOR:" + fgColorRows + ";\">" + destTblRows[i] + "</TD>");
        out.print("<TD>"+srcErrs[i].toString() + 
                  (srcErrs[i].toString().trim().equals("") == false ? 
                       "<BR><SPAN STYLE=\"COLOR:RED;\">Note:- Not all errors are shown.</SPAN>" : "")  +
                  "</TD>");
        out.print("<TD>"+destErrs[i].toString() + 
                  (destErrs[i].toString().trim().equals("") == false ? 
                       "<BR><SPAN STYLE=\"COLOR:RED;\">Note:- Not all errors are shown.</SPAN>" : "")  +
                 "</TD>");
        out.print("<TD>" + warnings[i].toString() + "</TD>");
        out.print("</TR>");
    }

    for (i = 0; i < miscErrNo; ++i) {
        
        if (i == 0) {
            out.print("<TR>");
            out.print("<TD COLSPAN=6>Miscellaneous Errors:</TD>");
            out.print("</TR>");
        }
        out.print("<TR>");
        out.print("<TD>" + (i+1) + "</TD>");
        out.print("<TD COLSPAN=5>"+miscErrs[i] + "</TD>");
        out.print("</TR>");
    }
%>
    </TBODY>
</TABLE>

</FORM>
<!-- W_B_20161226_58 BEGIN: 2017-10-04 - Destination database table list not updated. -->
<SCRIPT LANGUAGE="JavaSCRIPT">
     // Refresh destination table list after the transfer. 
     tr_result_form.action="../wji_transfer/tr_tbllist.jsp?conn_no=2";
     tr_result_form.target="leftdatafr2";
     tr_result_form.submit();
</SCRIPT>
<!-- W_B_20161226_58 END -->
</BODY>
</HTML>
