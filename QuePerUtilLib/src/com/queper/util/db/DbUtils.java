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

/*
 * Class used to store metadata of a column of a table.
 */
public class DbUtils {
	
	public static String getDbmsName(Connection conn) {
		String dbName = "";
		DatabaseMetaData dbmd = null;
		
		if (conn == null) {
			return dbName;
		}
		try {
			dbmd = conn.getMetaData();
			dbName = dbmd.getDatabaseProductName();
		} catch (SQLException e) {
		}
		return dbName;
	}
		
	public static void deferForeignKeyChecks(Connection conn)
	{
		Statement stmt = null;
		String dbmsName = getDbmsName(conn);
		try {
			stmt = conn.createStatement();
			if (dbmsName.equalsIgnoreCase("SQLite")) {
				// Defer to transaction commit/roolback
				stmt.execute("PRAGMA defer_foreign_keys=ON");
			} else	if (dbmsName.equalsIgnoreCase("MySQL")) {
				// Mysql Does not seem to allow defering. So do not do!
			}
			stmt.close();
		} catch (SQLException e) {
		}
		
	}
        
	public static void disableForeignKeyChecks(Connection conn)
	{
		Statement stmt = null;
		String dbmsName = getDbmsName(conn);
		try {
			stmt = conn.createStatement();
			if (dbmsName.equalsIgnoreCase("SQLite")) {
				stmt.execute("PRAGMA foreign_keys=OFF");
			} else	if (dbmsName.equalsIgnoreCase("MySQL")) {
				stmt.execute("SET foreign_key_checks = 0");
			}
			stmt.close();
		} catch (SQLException e) {
		}		
	}
	
	public static void dnableForeignKeyChecks(Connection conn)
	{
		Statement stmt = null;
		String dbmsName = getDbmsName(conn);
		try {
			stmt = conn.createStatement();
			if (dbmsName.equalsIgnoreCase("SQLite")) {
				stmt.execute("PRAGMA foreign_keys=ON");
			} else	if (dbmsName.equalsIgnoreCase("MySQL")) {
				stmt.execute("SET foreign_key_checks = 1");
			}
			stmt.close();
		} catch (SQLException e) {
		}		
	}
} // class
