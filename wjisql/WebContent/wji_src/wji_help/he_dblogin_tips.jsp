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
 --- Tips on database login.
 --- Not a stand-alone JSP file. To be included in other JSP files. 
 -->

<H4>1. Microsoft SQL Server Specific Tips</H4>
<P>
Make sure Microsoft SQL server is running before you try connection to SQL server database.
If your database connection does not work in spite of presence of a running SQL server, 
check network setup as following using Microsoft tool 
<b>SQL Server Configuration Manager</b>. 
</P>

<h4>1.1 Client Protocols</h4>
<P>Make sure TCP/IP protocol is <B>Enabled</B> in the list of <B>Client Protocols</B> 
as shown in the following picture:</P>
<IMG SRC="./he_mssql_nw_setup1.png">

<h4>1.2 Server Protocols</h4>
<P>Make sure TCP/IP protocol is <B>Enabled</B> for your <b>SQL Server instance</b> 
as shown in the following picture:</P>
<IMG SRC="./he_mssql_nw_setup2.png">  
<P>Note that the server instance in the above picture is "SQLEXPRESS". 
It could be different in your case.</P>

<h4>1.3 Server TCP/IP Protocol Properties</h4>
<P>Double click on the protocol <b>TCP/IP</b> and make sure TCP/IP protocol properties of the server 
instance are as shown in the following picture:</P>
<IMG SRC="./he_mssql_nw_setup3.png">  

<h4>1.4 Select Server IP Address</h4>
<P>Make sure IP address and port number are as shown in the following picture:</P>
<IMG SRC="./he_mssql_nw_setup4.png">  
<p>For example, the following picture shows one way of setting properties: <b>Active</b> and <b>Enabled</b> 
properties of fourth IP address entry 
<b>IP4</b> are set to <b>Yes</B> and  <b>IP address</b> to <b>127.0.0.1</b>. TCP port in address entry <b>IPALL</b> is 
is set to <b>1433</b>. </p>

<h4>1.5 Database name in JDBC URL</h4>
<p>Database name in URL is not necessary. In this case, you are connected to master database. 
Once your login is successful, you can create another database and next time you can specify
the database name in the JDBC URL.</p>

<h4>1.6 Database and User creation</h4>
<p>If you are using SQL server 2012 or later version, first connect to master database using wjISQL with 
system administrator user name 'sa' and related password. Then, execute the following SQL statements to
create <b>contained</b> database and user: </p>
<pre>
	EXEC SP_CONFIGURE 'show advanced options',1
	RECONFIGURE
	EXEC SP_CONFIGURE 'contained database authentication',1
	RECONFIGURE
	
	CREATE DATABASE mssqldb CONTAINMENT=PARTIAL;
	USE MSSQLDB;
	CREATE USER mssqlusr WITH PASSWORD = 'mssql123';
</pre>
<I>
<B>Notes:-</B>
<UL>
<LI> Make sure you restart the SQL Server instance after network configuration is done.
</UL>
</I>
