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
 --- Function: Displays chapter 3 of user's guide. 
 -->
 
<HTML>

<HEAD><TITLE>Chapter 3. Connecting to a Database</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>

<A HREF="ug_toc.jsp">Table of Contents</A>

<BR>

<H2><U>Chapter 3. Connecting to a Database</U></H2>


<A NAME="oview"><H3>3.1 Overview</H3></A>

<P>Once required software is installed on your computer system, the first
hurdle in using a database is connecting to the database successfully. 
More often that not, the very first connection may fail for many reasons:
</P>
<UL>
<LI>JDBC driver is not found by Tomcat
<LI>Tomcat server is not in a running state
<LI>JDBC URL is incorrect
<LI>Database does not exist
<LI>You do not have a user ID and password yet!
<LI>...
</UL>
</P>
This chapters tries to help you resolving database connection issues
and make the connection successful.
</P>


<A NAME="connfirst"><H3>3.2 Connecting to a Database for the First time</H3></A>

<P>To use a database created using any database management system(DBMS) 
other than SQLite, you need to login into database server and/or its 
database by supplying a <B>user ID</B> (user/login/account ID/name)
and a <B>password</B>. During a DBMS installation, you are asked to
provide an administrator user ID and/or password. You can use these 
to login to database server initially.
</P>

<P>To login into a database server, you need to specify a URL (uniform 
resource locator) that indicates information such as name or IP address
of computer system on which database server is running, port number if any,
database name and any related attributes. Except for string "jdbc",
everything else in URL is specific to a DBMS. For initial login, 
use a default database if one exists or do not specify database name in 
the URL. Use Root/super user/administrator user ID and password to login
into the server and/or database. In case of SQLite DBMS, no user ID and 
password are required. For database name, one has to specify path to a file.
If the file does not exist, it is created and the name of the file is
your database name.
</P>

<A NAME="trouble"><H3>3.3 Troubleshooting Database Connections</H3></A>

<A NAME="toublegen"><H4>3.3.1 General Tips</H3></A>

<P>As already mentioned, a database connection may fail for many reasons and
often it is frustrating! Here we discuss some issues that you can keep in
mind while connecting to a database:
</P>
<OL>
<LI>Make sure <B>Tomcat web server</B> is in running state. To check this, 
start Windows Services program(Run command "services.msc" to directly go to 
the service list or reach it from control panel), look for service with name
"Apache Tomcat 7.0 Tomcat7" (the name could be different if you are using
some other version of Tomcat) and make sure its status is "Started". 
Otherwise start it.
<LI>Make sure the <B>JDBC driver file</B> (*.jar) is already made available to
Tomcat. The jar file has to be  in "webapps/wjisql/WEB-INF/lib" directory of Tomcat home
directory. If the driver file is not present, copy the file into the directory
and <B>restart Tomcat service</B>. 
<LI>Make sure the JDBC driver jar file is of right <B>version</B> for
your DBMS. Some DBMSs have multiple versions of JDBC drivers. 
<A HREF="ug_chapter_02.jsp">Chapter 2</A> lists 
drivers used to test wjISQL.
<LI>Make sure your DBMS service is in running state. If it is not,
start the service using Windows service program or any other way as documented
by the DBMS documents.
<LI>Make sure the JDBC <B>URL</B> you specified on the <B>Login</B> is correct.
Compare the URL you specified with the default format displayed below the 
<B>Database URL</B> field in the login screen and do any corrections if 
required.
<LI>Make sure <B>host name</B> or <B>IP address</B> of the computer 
on which the database
server is running is correct in the URL. Also make sure <B>port number</B> 
if specified in the URL is correct. 
</OL>

<A NAME="toublemssql"><H4>3.3.2 RDBMS Specific Tips</H3></A>

<%@include file="he_dblogin_tips.jsp"%>


<A HREF="ug_toc.jsp">Table of Contents</A>

<HR>

<%@include file="../wji_common/cmn_copyright.jsp"%>

</BODY>
</HTML>
