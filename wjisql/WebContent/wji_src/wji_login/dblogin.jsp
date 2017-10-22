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
 --- Function: 		Displays Database Login screen.
 --- Description:	This file contains JDBC driver names, class names and URLs used for database connections.
 ---				Currently connections to databases of the following RDBMSs are supported:
 --- 					1. MySQL
 ---					2. SQLite
 ---					3. Oracle
 ---					4. MS SQL Server
 ---					5. PostgreSQL 
 --- 					6. MariaDB
 ---				You need to modify this file to support another RDBMS. 
 --- 				You can connect to any other RDBMS as long as you make its JDBC driver 
 ---				available to the web server you use.
 -->

<HTML>
<HEAD>
<TITLE>Login</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY>
<%@include file="../wji_common/imports.jsp"%>
<FORM METHOD="POST" NAME="login_form">

<%

   final String mssqlJDBCDriverName     = "Microsoft SQL Server JDBC Driver"; 
   final String mssqlJDBCDriverClass    = "com.microsoft.sqlserver.jdbc.SQLServerDriver"; 
   final String mssqlJDBCDriverURL      = "jdbc:sqlserver://localhost:1433;databaseName=testdb;"; 
	// W_B_20161221_52: URL formats on the login screen are incomplete.
   final String mssqlJDBCDriverURLFmt   = "jdbc:sqlserver://[<host>[\\<instance>][:<port>]][;<>property>=<value>[;<property>=<value>]...]"; 

   final String mysqlJDBCDriverName     = "MySQL JDBC Driver"; 
   final String mysqlJDBCDriverClass    = "com.mysql.jdbc.Driver"; 
   final String mysqlJDBCDriverURL      = "jdbc:mysql://localhost/testdb"; 
	// W_B_20161221_52: URL formats on the login screen are incomplete.
   final String mysqlJDBCDriverURLFmt   = "jdbc:mysql://[<host1>][:<port1>][,[<host2>][:<port2>]]...[/[<database>]]"
		   							+ "[?<propertyName1>=<propertyValue1>[&<propertyName2>=<propertyValue2>]...]"; 

   // W_F_20171006_77: 2017-10-06: Support for MariaDB is needed.
   final String mariadbJDBCDriverName     = "MariaDB JDBC Driver"; 
   final String mariadbJDBCDriverClass    = "org.mariadb.jdbc.Driver"; 
   final String mariadbJDBCDriverURL      = "jdbc:mariadb://localhost:3307/testdb"; 
   final String mariadbJDBCDriverURLFmt   = "jdbc:mariadb://[<host1>[:<port1>]][,[<host2>[:<port2>]]]...[/[<database>]]"
		   							+ "[?<propertyName1>=<propertyValue1>[&<propertyName2>=<propertyValue2>]...]"; 


   final String oracleJDBCDriverName    = "Oracle JDBC Driver"; 
   final String oracleJDBCDriverClass   = "oracle.jdbc.driver.OracleDriver"; 
   final String oracleJDBCDriverURL     = "jdbc:oracle:thin:@localhost:1521:XE"; 
	// W_B_20161221_52: URL formats on the login screen are incomplete.
   final String oracleJDBCDriverURLFmt  = "jdbc:oracle:<driver-type>:@<host>:<port>:<database>"; 
   
   final String postgresJDBCDriverName  = "PostgreSQL JDBC Driver"; 
   final String postgresJDBCDriverClass = "org.postgresql.Driver"; 
   final String postgresJDBCDriverURL   = "jdbc:postgresql://localhost:5432/testdb"; 
	// W_B_20161221_52: URL formats on the login screen are incomplete.
   final String postgresJDBCDriverURLFmt   = "jdbc:postgresql:[//<host>[:<port>]/]<database>"; 

   final String sqliteJDBCDriverName     = "SQLite JDBC Driver"; 
   final String sqliteJDBCDriverClass    = "org.sqlite.JDBC"; 
   // W_20161213_43 BEGIN: Browse for database file
   final String sqliteJDBCDriverURLPrefix      = "jdbc:sqlite:"; 
   final String sqliteJDBCDriverURL      =  sqliteJDBCDriverURLPrefix + "C:/sqlite/testdb";
   final String sqliteJDBCDriverURLLinux =  sqliteJDBCDriverURLPrefix + OsEnv.getHomeDir() + "/testdb";
   // W_20161213_43 END: Browse for database file
	// W_B_20161221_52: URL formats on the login screen are incomplete.
   final String sqliteJDBCDriverURLFmt     =  sqliteJDBCDriverURLPrefix + "<database file with path>";


   final String otherJDBCDriverName     = "(Other JDBC Driver)"; 
   final String otherJDBCDriverClass    = ""; 
   final String otherJDBCDriverURL      = "jdbc:"; 
   final String otherJDBCDriverURLFmt   = ""; 

   final String defaultJDBCDriverName   = sqliteJDBCDriverName;
   final String defaultJDBCDriverClass  = sqliteJDBCDriverClass;
   final String defaultJDBCDriverURL    = sqliteJDBCDriverURL;


   String targetFrNameStrs[] = request.getParameterValues("targetfr_name"); 
   String targetFrName = new String("");
   if (targetFrNameStrs != null)
		targetFrName = targetFrNameStrs[0];
   String nextPageStrs[] = request.getParameterValues("next_page"); 
   String nextPage = new String("");
   if (nextPageStrs != null)
	nextPage = nextPageStrs[0];
	
   String jDriverNameStrs[] = request.getParameterValues("jdriver_name"); 
   String jDriverName = "";
   if (jDriverNameStrs != null)
	jDriverName = jDriverNameStrs[0];
   String jDriverClassStrs[] = request.getParameterValues("jdriver_class"); 
   String jDriverClass = "";
   if (jDriverClassStrs != null)
	jDriverClass = jDriverClassStrs[0];
   String dbURLStrs[] = request.getParameterValues("dburl"); 
   String dbURL = "";
   if (dbURLStrs != null)
	dbURL = dbURLStrs[0];
   String dbURLFmtStr = request.getParameter("dburlfmt"); 
   // out.print(dbURLFmtStr);
   String dbURLFmt = "";
   if (dbURLFmtStr != null) {
	dbURLFmt = dbURLFmtStr;
	}
   // W_B_20161221_51 BEGIN: URL format shown for MySql in Login screen is incorrect after a connection failure.
	// W_B_20161221_52 BEGIN: URL formats on the login screen are incomplete.
   else {
		if (jDriverName.equalsIgnoreCase(mssqlJDBCDriverName)) {
			dbURLFmt = mssqlJDBCDriverURLFmt;
		} else	if (jDriverName.equalsIgnoreCase(mysqlJDBCDriverName)) {
			dbURLFmt = mysqlJDBCDriverURLFmt;
		}
		// W_F_20171006_77: 2017-10-06: Support for MariaDB is needed. 
		else	if (jDriverName.equalsIgnoreCase(mariadbJDBCDriverName)) {
			dbURLFmt = mariadbJDBCDriverURLFmt;
		} else	if (jDriverName.equalsIgnoreCase(oracleJDBCDriverName)) {
			dbURLFmt = oracleJDBCDriverURLFmt;
		} else	if (jDriverName.equalsIgnoreCase(postgresJDBCDriverName)) {
			dbURLFmt = postgresJDBCDriverURLFmt;
		} else	if (jDriverName.equalsIgnoreCase(sqliteJDBCDriverName)) {
			dbURLFmt = sqliteJDBCDriverURLFmt;
		}
	}
	// W_B_20161221_52 END
   // W_B_20161221_51 END
   String userIdStrs[] = request.getParameterValues("userid"); 
   String userId = new String("");
   if (userIdStrs != null)
	userId = userIdStrs[0];

   // W_20161213_43 BEGIN: Browse for database file
   String dbFolder = request.getParameter("db_folder"); 
   if (dbFolder == null) {
	   dbFolder = "";
   }
   String dbFile = request.getParameter("db_file"); 
   if (dbFile == null) {
	   dbFile = "";
   }
   // W_20161213_43 END
   
   
   String connNoStr = request.getParameter("conn_no"); 
   int connNo = 0;
   if (connNoStr != null)
	connNo = Integer.parseInt(connNoStr.trim());
	
%>

<%@include file="dblogin_buttons.jsp" %>


<CENTER>
<% if (connNo == 1) { %>
<P><B>Login into Source Database </B></P>
<% } else if (connNo == 2) { %>
<P><B>Login into Destination Database </B></P>
<% } else  { %>
<BR>
<P><B>Database Login</B></P>
<BR>
<% } %>

<TABLE>
<TR>
<TD>JDBC Driver:</TD>
<TD></TD>
</TR>

<TR>
<TD ALIGN=RIGHT>Choose</TD>
<TD>
<!-- Keep the drivers in Ascending order. -->
<SELECT TYPE=TEXT NAME="jdriver_name"  ONCHANGE="react(this.form)">
<OPTION>select a database system
<!-- W_F_20171006_77: 2017-10-06: Support for MariaDB is needed. -->
<OPTION <%=(jDriverName.equals(mariadbJDBCDriverName) ? "SELECTED" : "")%> ><%=mariadbJDBCDriverName%>
<OPTION <%=(jDriverName.equals(mssqlJDBCDriverName) ? "SELECTED" : "")%> ><%=mssqlJDBCDriverName%>
<OPTION <%=(jDriverName.equals(mysqlJDBCDriverName) ? "SELECTED" : "")%> ><%=mysqlJDBCDriverName%>
<OPTION <%=(jDriverName.equals(oracleJDBCDriverName) ? "SELECTED" : "")%> ><%=oracleJDBCDriverName%>
<OPTION <%=(jDriverName.equals(postgresJDBCDriverName) ? "SELECTED" : "")%> ><%=postgresJDBCDriverName%>
<OPTION <%=(jDriverName.equals(sqliteJDBCDriverName) ? "SELECTED" : "")%> ><%=sqliteJDBCDriverName%>
<OPTION> (Other JDBC Driver)
</SELECT>
</TD>
</TR>
<TR><TD ALIGN=RIGHT>or, specify</TD>
<TD>
<INPUT TYPE=TEXT NAME="jdriver_class" VALUE="<%=jDriverClass%>" SIZE="50" ONCHANGE="setCookie(this.name, this.value)">
</TD>
</TR>

<TR>
<TD>Database URL:</TD>
<TD>
<INPUT TYPE=TEXT NAME="dburl" VALUE="<%=dbURL%>"
		SIZE="50" ONCHANGE="setCookie(this.name, this.value)">
</TD>
</TR>

<TR>
<TD>
<INPUT TYPE=TEXT VALUE="URL Format"  
		READONLY DISABLED STYLE="FONT-STYLE:ITALIC;BORDER-STYLE:NONE;">
</TD>		
<TD>
<INPUT TYPE=TEXT NAME="dburlfmt" 
	VALUE="<%=(jDriverClass.equals(mysqlJDBCDriverClass) ? dbURLFmt + "?useUnicode=true&characterEncoding=UTF-8" : dbURLFmt)%>"  
	READONLY DISABLED SIZE="50" STYLE="FONT-STYLE:ITALIC;BORDER-STYLE:NONE;">
</TD>
</TR>
<%
if (jDriverClass.equals(sqliteJDBCDriverClass)) {
%>
    <INPUT TYPE=HIDDEN NAME="userid" VALUE="" />
    <INPUT TYPE=HIDDEN NAME="password" VALUE="" />
    
    <!-- W_20161213_43 BEGIN: Browse for database file -->
    <TR>
    <TD>Or, select SQLite database file from</TD><TD></TD>
    </TR>
    <TR>
    <TD ALIGN="RIGHT">folder:</TD>
    <TD><INPUT TYPE=TEXT NAME="db_folder" VALUE="<%=dbFolder%>" /> </TD>
    </TR>
    <TR>
    <TD ALIGN="RIGHT">file:</TD>
    <TD> 
    <INPUT TYPE=FILE  NAME="db_file" ID="sqlite_db_files"   
    	ONCHANGE="select_sqlite_db_file(this.form)"/>
    </TD>
    </TR>
    <!-- W_20161213_43 END -->
<%
} else {
%>
   	<!-- W_20161213_43 BEGIN: Browse for database file -->
    <INPUT TYPE=HIDDEN NAME="db_folder" VALUE="" />
    <INPUT TYPE=HIDDEN NAME="db_file" VALUE="" />
   	<!-- W_20161213_43 END -->
   	
    <TR>
    <TD>User ID:</TD>
    <TD>
    <INPUT TYPE=TEXT NAME="userid" VALUE="<%=userId%>"
		ONCHANGE="setCookie(this.name, this.value)">
    </TD>
    </TR>

    <TR>
    <TD>Password:</TD>
    <TD><INPUT TYPE=PASSWORD NAME="password" VALUE=""></TD>
    </TR>

<%
}
%>
<!-- W_20151210_25 BEGIN: Login does not work when Enter key is pressed. -->
   	<!-- W_20161213_43 BEGIN: Browse for database file -->

    <TR>
    <TD COLSPAN=2>&nbsp;</TD>
    </TR>

    <TD ALIGN=CENTER COLSPAN=2 >
    <INPUT TYPE=SUBMIT VALUE="Login" STYLE="BACKGROUND:AQUA;" ONCLICK="react_submit(this.form)">
    </TD>
    </TR>
   	<!-- W_20161213_43 END: Browse for database file -->
<!-- W_20151210_25END -->

</TABLE>

<%
if (connNo == 0) { 
%>
    <BR>
<%
}
%>

</CENTER>

<SCRIPT LANGUAGE="JavaScript">

var expires = new Date();
expires.setTime(expires.getTime() + 24 * 60 * 60 * 30 * 1000); 

function getCookieVal(offset)
{
   var endStr = document.cookie.indexOf(";", offset);
   if (endStr == -1)
      endStr = document.cookie.length;
   return unescape(document.cookie.substring(offset, endStr));
}

function getCookie(cookieName)
{
   var arg = cookieName + "=";
   var argLen = arg.length;
   var cookieLen = document.cookie.length;
   var i = 0;
   var val = "";

   while (i < cookieLen) {
     var j = i + argLen;
     var nm = document.cookie.substring(i, j); 
     if (nm == arg) {
	val = getCookieVal(j);
	break;
     }
     i = document.cookie.indexOf(" ", i) + 1;
     if (i == 0)
	break;
   }
   // alert(val);
   return val;
}

function setCookie(cookieName, cookieVal)
{
   document.cookie = cookieName + "=" + escape(cookieVal) +
	   "; expires=" + expires.toGMTString();
}

function react(form)
{
   var ck = "";
   
   // W_F_20171006_77: 2017-10-06: Support for MariaDB is needed.
   if (form.jdriver_name.selectedIndex == 1) /* mariadb */
   {
      	if (form.jdriver_name.value != null)
        	form.jdriver_name.value = "<%=mariadbJDBCDriverName%>";
      	if (form.jdriver_class.value != null)
	 		form.jdriver_class.value = "<%=mariadbJDBCDriverClass%>";
      	if (form.dburl.value != null)
	 		form.dburl.value = "<%=mariadbJDBCDriverURL%>";
		if (form.dburlfmt.value != null)
	 		form.dburlfmt.value = "<%=mariadbJDBCDriverURLFmt%>";
      	form.jdriver_class.enabled = false;
   }
   else if (form.jdriver_name.selectedIndex == 2) /* mssql */
   {
		if (form.jdriver_name.value != null)
        	form.jdriver_name.value = "<%=mssqlJDBCDriverName%>";
      	if (form.jdriver_class.value != null)
	 		form.jdriver_class.value = "<%=mssqlJDBCDriverClass%>";
	 	// W_B_20161221_52 BEGIN: URL formats on the login screen are incomplete.
      	if (form.dburl.value != null)
	 		form.dburl.value = "<%=mssqlJDBCDriverURL%>";
	    if (form.dburlfmt.value != null)
	 		form.dburlfmt.value = "<%=mssqlJDBCDriverURLFmt%>";
	 	// W_B_20161221_52 END
      	form.jdriver_class.enabled = false;
   }
   else if (form.jdriver_name.selectedIndex == 3) /* mysql */
   {
      	if (form.jdriver_name.value != null)
        	form.jdriver_name.value = "<%=mysqlJDBCDriverName%>";
      	if (form.jdriver_class.value != null)
	 		form.jdriver_class.value = "<%=mysqlJDBCDriverClass%>";
		// W_B_20161221_52 BEGIN: URL formats on the login screen are incomplete.
      	if (form.dburl.value != null)
	 		form.dburl.value = "<%=mysqlJDBCDriverURL%>";
		if (form.dburlfmt.value != null)
	 		form.dburlfmt.value = "<%=mysqlJDBCDriverURLFmt%>";
	 	// W_B_20161221_52 END
      	form.jdriver_class.enabled = false;
   }
   else if (form.jdriver_name.selectedIndex == 4) /* oracle */
   {
      	if (form.jdriver_name.value != null)
        	form.jdriver_name.value = "<%=oracleJDBCDriverName%>";
      	if (form.jdriver_class.value != null)
	 		form.jdriver_class.value = "<%=oracleJDBCDriverClass%>";
		// W_B_20161221_52 BEGIN: URL formats on the login screen are incomplete.	 		
      	if (form.dburl.value != null)
	 		form.dburl.value = "<%=oracleJDBCDriverURL%>";
     	if (form.dburlfmt.value != null)
    		form.dburlfmt.value = "<%=oracleJDBCDriverURLFmt%>";
    	// W_B_20161221_52 END
      	form.jdriver_class.enabled = false;
   }
   else if (form.jdriver_name.selectedIndex == 5) /* PostgreSQL */
   {
      if (form.jdriver_name.value != null)
         form.jdriver_name.value = "<%=postgresJDBCDriverName%>";
      if (form.jdriver_class.value != null)
         form.jdriver_class.value = "<%=postgresJDBCDriverClass%>";
 	  // W_B_20161221_52 BEGIN: URL formats on the login screen are incomplete.
      if (form.dburl.value != null)
         form.dburl.value = "<%=postgresJDBCDriverURL%>";
      if (form.dburlfmt.value != null)
             form.dburlfmt.value = "<%=postgresJDBCDriverURLFmt%>";
      // W_B_20161221_52 END
      form.jdriver_class.enabled = false;
   }
   else if (form.jdriver_name.selectedIndex == 6) /* sqlite */
   {
      if (form.jdriver_name.value != null)
         form.jdriver_name.value = "<%=sqliteJDBCDriverName%>";
      if (form.jdriver_class.value != null)
         form.jdriver_class.value = "<%=sqliteJDBCDriverClass%>";
 	  // W_B_20161221_52 BEGIN: URL formats on the login screen are incomplete.
      if (form.dburl.value != null)
    	  if (<%=(OsEnv.isWindows() == true)%>) {
				form.dburl.value  = "<%=sqliteJDBCDriverURL%>";
    	  } else {
				form.dburl.value  = "<%=sqliteJDBCDriverURLLinux%>";
    	  }
      if (form.dburlfmt.value != null)
         form.dburlfmt.value =  "<%=sqliteJDBCDriverURLFmt%>";
      // W_B_20161221_52 END
      form.jdriver_class.enabled = true;
   }
   else if (form.jdriver_name.selectedIndex == 7) /* other */
   {
      if (form.jdriver_name.value != null)
         form.jdriver_name.value = "<%=otherJDBCDriverName%>";
      if (form.jdriver_class.value != null)
         form.jdriver_class.value = "<%=otherJDBCDriverClass%>";
 	  // W_B_20161221_52 BEGIN: URL formats on the login screen are incomplete.
      if (form.dburl.value != null)
         form.dburl.value  = "<%=otherJDBCDriverURL%>";
      if (form.dburlfmt.value != null)
         form.dburlfmt.value  = "<%=otherJDBCDriverURLFmt%>";
      // W_B_20161221_52 END
      form.jdriver_class.enabled = true;
   }
   
   /*
   * Replace field values with cookies provided 
   * driver name matches with whatever user selected!
   */
   ck = getCookie("jdriver_name");
   if (ck != null && ck != "") {
       if (form.jdriver_name.value == ck) {
           ck = getCookie("jdriver_class");
           if (ck != null && ck != "") {
               form.jdriver_class.value = ck;
           }
           ck = getCookie("dburl");
           if (ck != null && ck != "") {
               form.dburl.value = ck;
           }
           ck = getCookie("userid");
           if (ck != null && ck != "" && form.userid != null) {
              form.userid.value = ck;
           }
           
           // W_20161213_43 BEGIN: Browse for database file 

           ck = getCookie("db_folder");
           if (ck != null && ck != "" && form.db_folder != null) {
              form.db_folder.value = ck;
           }
           
           // Looks like default vaue for FILE type can not be set.
           // Hence the following code may not work.
           ck = getCookie("db_file");
           if (ck != null && ck != "" && form.db_file != null) {
              form.db_file.value = ck;  
           }
           // W_20161213_43 END 
       }
   }
   // alert(form.dburlfmt.value);
   // W_B_20161226_57: Login failure of source or destination database in transfer screen takes 
   // control to a new tab instead of right data frame 1.
   // Added correct target frame name.
   form.action = "dblogin.jsp?conn_no=<%=connNo%>&dburlfmt=" + form.dburlfmt.value
		   + "&targetfr_name=<%=targetFrName%>"
		   ;
   form.target = "_self";	// W_20161218_48: Error in different tab.
   form.submit();   
}

function react_submit(form)
{
   if (form.jdriver_name.selectedIndex == 7) /* other */
   {
      form.jdriver_name.value = form.jdriver_class.value;
   }
   setCookie("jdriver_name", form.jdriver_name.value);
   setCookie("jdriver_class", form.jdriver_class.value);
   setCookie("dburl", form.dburl.value);
   setCookie("userid", form.userid.value);

   form.action = "dbconnect.jsp?conn_no=<%=connNo%>&targetfr_name=<%=targetFrName%>";
   form.target = "_self";	// W_20161218_48: Error in different tab.
   form.submit();   
}

function reset_url(form)
{
    form.dburl.value = form.dburlfmt.value;

}

// W_20161213_43 BEGIN: Browse for database file 
function select_sqlite_db_file(form)
{
	var db_file_path = "";
	var db_file_name = "";
	var db_files = [];
	
	db_files = document.getElementById("sqlite_db_files").files;
    if (!db_files.length) {
      	return;
    }
    
    db_file_name = db_files[0].name;
    db_file_path = form.db_folder.value  + db_file_name;
	form.dburl.value = "<%=sqliteJDBCDriverURLPrefix%>" + db_file_path;
	
	setCookie("db_folder", form.db_folder.value);
	setCookie("db_file", db_files[0].name);
}
// W_20161213_43 END: Browse for database file 


function display_help(form)
{
    form.action = "../wji_help/he_dblogin.jsp";
    form.target = "_blank";
    form.submit();
}

// alert(document.cookie);
</SCRIPT>

</FORM>
</BODY>
</HTML>

