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

/**
 * Class used to get various names related to a database.
 */
public class DbNames {

    // DBMS specific constants.
    public static final String DBMS_MYSQL = "MySQL";
    public static final String DBMS_MSSQLSERVER = "Microsoft SQL Server";
    public static final String DBMS_SQLITE = "SQLite";
    public static final String DBMS_ORACLE = "Oracle";
    public static final String DBMS_POSTGRESQL = "PostgreSQL";

    /**
     * Get isolation level name given isolation number.
     */
    public static String getIsolationLevelName(int isol)
    {
      switch(isol) {
         case Connection.TRANSACTION_NONE: 
            return Integer.toString(isol) + " (NO ISOLATION LEVEL SUPPORT)";
         case Connection.TRANSACTION_READ_UNCOMMITTED: 
	    return Integer.toString(isol) + " (READ_UNCOMMITTED)";
         case Connection.TRANSACTION_READ_COMMITTED: 
	    return Integer.toString(isol) + " (READ_COMMITTED)";
         case Connection.TRANSACTION_REPEATABLE_READ: 
	    return Integer.toString(isol) + " (REPEATABLE_READ)";
         case Connection.TRANSACTION_SERIALIZABLE: 
	    return Integer.toString(isol) + " (SERIALIZABLE)";
         default: 
	    return Integer.toString(isol) + " (Invalid isoation level number)";
      }
    } 

    /**
     * Get database name from the given connection.
     */
    public static String getDbName(Connection conn) 
    {
		String url = "";
		String rdbmsName = "";
		String dbName = "";
		String[] parts = null;
		String lastPart = "";
		int i = -1;
	
		if (conn == null) return "";
	
		try {
		    url = conn.getMetaData().getURL();
	            parts = url.split(":");
		    lastPart = parts[parts.length -1];
		    rdbmsName = conn.getMetaData().getDatabaseProductName();
		    if (rdbmsName.equalsIgnoreCase(DBMS_POSTGRESQL)) {
		         // jdbc:postgresql:[//host[:port]/]database
		        dbName = lastPart.substring(lastPart.lastIndexOf('/') + 1);
	        } else if (rdbmsName.equalsIgnoreCase(DBMS_SQLITE)) {
		        // jdbc:sqlite:C:/sqlite/db1
		        dbName = lastPart.substring(lastPart.lastIndexOf('/') + 1);
	        } else if (rdbmsName.equalsIgnoreCase(DBMS_MYSQL)) {
		        // jdbc:mysql://localhost/qppsdb
		        i = lastPart.lastIndexOf('/');
		        dbName = lastPart.substring(i + 1);
	        } else if (rdbmsName.equalsIgnoreCase(DBMS_ORACLE)) {
		        // jdbc:oracle:thin:@localhost:1521:XE
		        i = lastPart.lastIndexOf('/');
		        dbName = lastPart.substring(i + 1);
	        } else if (rdbmsName.equalsIgnoreCase(DBMS_MSSQLSERVER)) {
		        // jdbc:sqlserver://localhost:1433;databaseName=testdb;
		        dbName = lastPart.substring(lastPart.indexOf("databaseName"));
	            dbName = dbName.substring(dbName.indexOf('=') + 1);
	            i = dbName.indexOf(';');
	            if (i != -1) dbName = dbName.substring(0, i);
	        }
		} catch (SQLException se) {
			return "";
		}
		return dbName;
    }
} // class
