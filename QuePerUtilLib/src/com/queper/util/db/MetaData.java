/*
     Copyright 2006-2017, QuePer 

     Licensed under the Apache License, Version 2.0 (the "License");
     you may not use this file except in compliance with the License.
     You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.
*/

package com.queper.util.db;

import java.sql.*;
import java.util.ArrayList;

public class MetaData {

    /**
     * Get data type of the given column.
     */
    public static int getColType(Connection conn, String sch, String tbl,
		    String col) 
    {
        DatabaseMetaData md = null;
		int colType = -99999; // invalid type
	
		if (conn == null) return colType;
	
		try {
		    md = conn.getMetaData();
		    ResultSet rs = md.getColumns(null, sch, tbl, col);
		    if (rs != null && rs.next()) {
			colType = rs.getInt(5);
		        rs.close();
		    }
		} catch (SQLException se) {
		}
		return colType;
    }

    /**
     * Get data type name for the given column.
     */
    public static String getColTypeName(Connection conn, String sch, String tbl,
		    String col) 
    {
        DatabaseMetaData md = null;
		String colTypeName = "";
	
		if (conn == null) return colTypeName;
	
		try {
		    md = conn.getMetaData();
		    ResultSet rs = md.getColumns(null, sch, tbl, col);
		    if (rs != null && rs.next()) {
			colTypeName = rs.getString(6);
		        rs.close();
		    }
		} catch (SQLException se) {
		}
		return colTypeName;
    }


    /**
     * Get list of columns of the given table.
     *
     * Column list object mdColList,  should be created by the caller.
     */
    public static void getColumnList(Connection conn, String sch, String tbl, ArrayList<MdColumn> mdColList) 
	    throws SQLException
    {
        DatabaseMetaData md = null;
		String colName;
		int dataType;
		String typeName;
		String nullable;
		String colDefault;
		String autoIncrement;
	
		if (conn == null) return;
	
		try {
		    md = conn.getMetaData();
		    ResultSet rs = md.getColumns(null, sch, tbl, null);
		    while (rs != null && rs.next()) {
			colName = rs.getString("COLUMN_NAME");
			dataType = rs.getInt("DATA_TYPE");
			typeName = rs.getString("TYPE_NAME");
			nullable = rs.getString("IS_NULLABLE");
			colDefault = rs.getString("COLUMN_DEF");
			if (rs.wasNull()) { colDefault = null; };
			/*
			 * Oracle and SQLite throw exception for autoincrement column!
			 */
			if (md.getDatabaseProductName().equals(DbNames.DBMS_ORACLE) == true ||
			    /* W_20140721_00019:v1.9.1:2014-07-21: Changed from DBMS_ORACLE to SQLITE */
			    md.getDatabaseProductName().equals(DbNames.DBMS_SQLITE) == true 
			   ) {
			    autoIncrement = "NO";
			} else {
			    autoIncrement = rs.getString("IS_AUTOINCREMENT");
			}
	
			/* SQLite returns "Y" instead of "YES" for nullable columns. */
			mdColList.add(new MdColumn(colName, dataType, typeName, 
				(nullable.equalsIgnoreCase("YES") || nullable.equalsIgnoreCase("Y")) 
				    ? true : false, 
				colDefault,
				(autoIncrement.equalsIgnoreCase("YES") || autoIncrement.equalsIgnoreCase("Y"))
				    ? true : false 
						));
		    }
		    rs.close();
		} catch (SQLException se) {
		    throw se;
		}
    }

    /**
     * Get columns common to the passed column lists. 
     *
     * In addtion to the common columns, the method also outputs columns of destination table that are not in
     * the source table.
     *
     * Both common column list and non-source column list objects should be created by caller.
     */
    public static void getCommonColList(ArrayList<MdColumn> mdSrcColList, ArrayList<MdColumn> mdDestColList,
		        ArrayList<MdColumn> mdCommonColList, ArrayList<MdColumn> mdDestNonSrcColList ) 
    {

		int srcSize = mdSrcColList.size();
		int destSize = mdDestColList.size();
		MdColumn srcCol;
		MdColumn destCol;
		int srcIdx, destIdx;
		boolean found;
	
		for (destIdx = 0; destIdx < destSize; ++destIdx) {
		    destCol = mdDestColList.get(destIdx);
		    found = false;
		    for (srcIdx = 0; srcIdx < srcSize; ++srcIdx) {
			srcCol = mdSrcColList.get(srcIdx);
				if (destCol.equals(srcCol)) {
				    mdCommonColList.add(destCol.getCopy()); 
				    found = true;
				    break;
				}
		    }
		    if (!found) { // dest column not in src column list
		        mdDestNonSrcColList.add(destCol.getCopy()); 
	            }
		}
    }
    
    /**
     * Get list of Parameters
     *
     * Column list object mdParamList,  should be created by the caller.
     */
    public static void getParamList(Connection conn, String sch, String procFunc, ArrayList<MdParameter> mdParamList) 
	    throws SQLException
    {
        DatabaseMetaData md = null;
		String dbmsName = "";
	
		String paramName;
		int inOutType;
		int dataType;
		String typeName;
		// String nullable;
		int nullable;
		String paramDefault;
		int position;
	
		if (conn == null) return;
	
	
		try {
		    md = conn.getMetaData();
	            dbmsName = md.getDatabaseProductName();
	
		    // Convert proc/func name to upper case for Oracle.
		    if (dbmsName.equals(DbNames.DBMS_ORACLE)) procFunc = procFunc.toUpperCase();
	
		    // ResultSet rs = md.getProcedureColumns(null, sch, procFunc, null);
		    ResultSet rs = md.getProcedureColumns(null, sch, procFunc, "%");
		    position = 0;
		    while (rs != null && rs.next()) {
			paramName = rs.getString("COLUMN_NAME");
			inOutType = rs.getInt("COLUMN_TYPE");
	
			/* SQL Server returns OUT type is INOUT. Hence the following code. */
			if (dbmsName.equals(DbNames.DBMS_MSSQLSERVER)) {
			     if (inOutType == DatabaseMetaData.procedureColumnInOut) {
				 inOutType = DatabaseMetaData.procedureColumnOut;
			     }
			}
			dataType = rs.getInt("DATA_TYPE");
			typeName = rs.getString("TYPE_NAME");
			/* 
			 * MySQL does not upport IS_NULLABLE column.
			 * Hence using NULLABLE column.
			 * nullable = rs.getString("IS_NULLABLE");
			 */
			nullable = rs.getInt("NULLABLE");
	
			if (dbmsName.equals(DbNames.DBMS_MYSQL)) {
			    /* MySQL does not support COLUMN_DEF and ORDINAL_POSITION columns. */
			    paramDefault = null;
			    position = (inOutType ==  DatabaseMetaData.procedureColumnReturn
					    ? 0 : ++position);
			} else {
			    paramDefault = rs.getString("COLUMN_DEF");
			    position = rs.getInt("ORDINAL_POSITION");
			    if (rs.wasNull()) { paramDefault = null; };
			}
	
			/* 
			 * We do not want result columns in the output as our interest
			 * is to support parameter markers only for return and actual
			 * parameters.
			 */
			if (inOutType == DatabaseMetaData.procedureColumnIn ||
				inOutType == DatabaseMetaData.procedureColumnOut ||
				inOutType == DatabaseMetaData.procedureColumnInOut ||
				inOutType == DatabaseMetaData.procedureColumnReturn) { 
			    mdParamList.add(new MdParameter(paramName, inOutType, dataType, typeName, 
				/*
				(nullable.equalsIgnoreCase("YES") || nullable.equalsIgnoreCase("Y")) 
				    ? true : false, 
				 */
				(nullable  == DatabaseMetaData.procedureNullable 
				    ? true : false), 
	
				paramDefault, position)
					);
			}
		    }
		    rs.close();
		} catch (SQLException se) {
		    throw se;
		}
    }


    public static String getCallStmtWithParamMarkers(String nameProcFunc, String stmtStr , 
		    ArrayList<MdParameter> mdParamList
		   )
    {
        int i = 0, index1 = -1, index2 = -1;
        int paramNo = 0;
        int nParams = mdParamList.size();
		MdParameter param = null;
		StringBuffer sb = new StringBuffer("");
		String tok = null;
	
		if (nParams == 0) {
		    return stmtStr;
		}
	
		// Replace special chars with spaces before and after
		// so that they come as separate tokens.
		stmtStr = stmtStr.replaceAll("\\(", " ( ");
		stmtStr = stmtStr.replaceAll("\\)", " ) ");
		stmtStr = stmtStr.replaceAll(",", " , ");
	
		String tokens[] = stmtStr.split("\\s+");
	
		// Form call stmt with parameter markers.
		for (i = 0; i < nParams; ++i) {
		    param = mdParamList.get(i);
		    if (i == 0) {
			   if (param.getParamInOutType() ==  DatabaseMetaData.procedureColumnReturn) {
			       sb.append("? = CALL " + nameProcFunc + "(");
			       ++paramNo;
			   } else {
			      sb.append("CALL " + nameProcFunc + "(? ");
			   }
		    } else {
			sb.append(", ?");
		    }
		}
		sb.append(")");
	
	
		/*
		 * Save IN parameter values if  present in the original stmt
		 * in the corresponding parameter object so that the values
		 * can be set using set methods of callable statement later.
		 *
		 * First we extract everything between parenthese and split
		 * it based on commas. 
		 *
		 * (Earlier way of splitting based on white space does not work
		 * here because it splits character string arguments into
		 * multiple tokens and hence we will not be able to know
		 * which value is for which parameter!)
		 */
	
		index1 = stmtStr.indexOf("(");
		index2 = stmtStr.indexOf(")");
		if (index1 != -1 && index2 != -1) {
		    stmtStr = stmtStr.substring(index1+1, index2);
		} else {
		    stmtStr = "";
		}
	
	
		if (stmtStr.trim().length() != 0) {
	
		    // Split parameter list.
		    tokens = stmtStr.split(",");
	
		    //Trim and remove quotes from string literal ends.
		    for (i = 0; i < tokens.length; ++i) {
			tok = tokens[i].trim();
			if (tok.charAt(0) == '\'' && tok.charAt(tok.length()-1) == '\'') {
		            tokens[i] = tok.substring(1, tok.length()-1);
		        }
	
		    }
	
		    for (i = 0; i < tokens.length; ++i) {
		        if (tokens[i].equals("?")) { ++paramNo; continue;}
		        else {
		           param = mdParamList.get(paramNo);
		           param.setParamVal(tokens[i]);
		           ++paramNo;
		        }
		    }
		}

        return sb.toString();
    }


    /*
    public static String[] getColNames(Connection conn, String sch, String tbl) 
    {
        DatabaseMetaData md = null;
        String colNames[] = null;

	try {
	    md = conn.getMetaData();
	    ResultSet rs = md.getColumns(null, sch, tbl, null);
	    int nCols = rs.getColumnCount();
            colNames = new String[nCols];
	    int i = 0;
	    while (rs != null && rs.next() && i < nCols) {
		colNames[i] = rs.getString(6);
		++i;
	    }
	    rs.close();
	} catch (SQLException se) {
	}
	return colNames;
    }
    */

} // class
