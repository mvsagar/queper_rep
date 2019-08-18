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
<% 
   String CONN_OBJ_NAME = "";
   java.sql.Connection conn = null; 
   java.sql.Connection conn1 = null; 
   java.sql.Connection conn2 = null; 
   java.sql.Connection tmpConn = null; 

   // DBMS specific constants.
   String DBMS_MYSQL = "MySQL";
   String DBMS_MARIADB = "MySQL"; // As of 10.2.9, JDBC returns this instead of
                                  // something like "MariaDB"
   String DBMS_MSSQLSERVER = "Microsoft SQL Server";
   String DBMS_SQLITE = "SQLite";
   String DBMS_ORACLE = "Oracle";
   String DBMS_POSTGRESQL = "PostgreSQL";
   
   /* W_B_20190816_92: wjISQL does not work with MySQL 8.x */
   String MARIADB_TERM = "MariaDB";
   String MYSQL_TERM = "MySQL";

   HttpSession theSession = request.getSession(true); 
   String connNoStr = request.getParameter("conn_no"); 
   int connNo = 0;
   if (connNoStr != null)
       connNo = Integer.parseInt(connNoStr.trim());	

   String userIdStr = request.getParameter("userid");
   String userId = null;
   String userId1 = null;
   String userId2 = null;
   if (userIdStr != null) 
      userId = userIdStr;
   if (userId == null) {
      userId = (String) theSession.getAttribute("userid"); 
      if (userId == null) userId = "";
      userId1 = (String) theSession.getAttribute("userid1"); 
      if (userId1 == null) userId1 = "";
      userId2 = (String) theSession.getAttribute("userid2"); 
      if (userId2 == null) userId2 = "";
   } else {
        if (connNo == 1) {
           userId1 = userId;
        } else if (connNo == 2) {
           userId2 = userId;
        } 
   }
   if (connNo == 1) {
           CONN_OBJ_NAME = "connobj_" + connNo + "_" + userId1;
      conn1 = (java.sql.Connection) theSession.getAttribute(CONN_OBJ_NAME); 
   } else if (connNo == 2) {
           CONN_OBJ_NAME = "connobj_" + connNo + "_" + userId2;
      conn2 = (java.sql.Connection) theSession.getAttribute(CONN_OBJ_NAME); 
   } else {
      CONN_OBJ_NAME = "connobj_" + 1 + "_" + userId1;
      conn1 = (java.sql.Connection) theSession.getAttribute(CONN_OBJ_NAME); 

      CONN_OBJ_NAME = "connobj_" + 2 + "_" + userId2;
      conn2 = (java.sql.Connection) theSession.getAttribute(CONN_OBJ_NAME); 

      CONN_OBJ_NAME = "connobj_" +  userId;
      conn = (java.sql.Connection) theSession.getAttribute(CONN_OBJ_NAME); 
   }
%>
