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
 --- Function: Displays help on main menu items of wjISQL. 
 -->
 
<HTML>

<HEAD>
<TITLE>Main Menu</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>

<HR>
<%@include file="he_cmnlinks.jsp"%>

<H2><U>wjISQL</U></H2>

<P>
<B>wjISQL</B> is an Internet browser based interactive SQL tool that can be
used to execute SQL statements and browse data in tables of databases managed
by relational database management systems. The tool  can be used with 
any database management system that has a JDBC driver. It can work with 
any web server that supports Java Server Page(JSP)s and any browser that 
supports JavaScript.
</P>

<P><B>Actions</B> you can perform on this page are as follows</P>

<UL>
<LI><INPUT TYPE=BUTTON VALUE="Home">: Brings you back to this home page
of <B>wjISQL</B>

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Connect">: Displays a screen for you to
connect to a database hosted by selected relational database management 
system (RDBMS).
<BR>
<A HREF="he_dblogin.jsp">More info...</A>

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Disconnect">: Disconnects from current
database, if there is one. Once disconnected, you have to connect again
to work with any database.

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Browse">: Displays a list of tables 
for you to browse data present in the tables.
<BR>
<A HREF="he_tbllist.jsp">More info...</A>

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="SQL">: Displays a window where you can 
specify one or more SQL statements and execute them and view the results.
<BR>
<A HREF="he_sqlstmt.jsp">More info...</A>


<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Transfer">: Displays a screen where you 
connect to two databases and transfer data from tables of one database to
another database.
<BR>
<A HREF="he_transfer.jsp">More info...</A>


<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="DBMS Info">: Displays a screen that contains
information  about the database management system you have connected to.
The information consists of the database product name, its version, JDBC 
driver name, its version and a lot of other information that the JDBC driver
can give.


<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Help">: Displays the help you are seeing now.
</UL>


<%@include file="he_cmnlinks.jsp"%>
<HR>
<%@include file="../wji_common/cmn_copyright.jsp"%>

</BODY>
</HTML>
