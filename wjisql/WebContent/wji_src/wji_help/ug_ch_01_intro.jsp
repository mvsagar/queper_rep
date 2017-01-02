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
 --- Function: Displays chapter 1 of user's guide. 
 -->
 
<HTML>

<HEAD><TITLE>Chapter 1. Introduction</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>

<A HREF="ug_toc.jsp">Table of Contents</A>

<BR>

<H2><U>Chapter 1. Introduction</U></H2>

<A NAME="oview"><H3>1.1 Overview</H3></A>
<P>Welcome to <B>wjISQL</B>!</P>

<P>This chapter tells you what <B>wjISQL</B> is, why you need to use it and 
how to use it in a nutshell.</P>

<%@include file="../wji_help/he_what_isit.jsp"%>

<P>
<B>wjISQL</B> tries to keep away idiosyncrasies of client tools of 
various database management systems and provide uniform interface 
across multiple database management 
systems so that you can be more productive.
</P>

<A NAME="func"><H3>1.2 Functionality</H3></A>

You can do the following with <B>wjISQL</B>:
<OL>
<LI>Connect to a database and disconnect from it.
<LI>Display list of tables and procedures.
<LI>Display properties of tables and procedures  
<LI>Execute one or more SQL Statements or commands.
<LI>Perform Insert/Update/Delete operations on a table using GUI.
<LI>Transfer data between tables of a database to tables of another database.
Each database many be managed by a different database management system.
</OL>

<A NAME="layout"><H3>1.3 Screen Layout</H3></A>
<P>Each screen (actually, a web page) displayed by <B>wjISQL</B> is divided 
into multiple windows (parts of a screen/web page). 
</P>

<A NAME="main"><H4>1.3.1 Main Screen</H4></A>

<P>The first or main screen
is divided into three windows as follows:
</P>
<UL>
<LI><B>Navigation Window</B>: This window contains menu items that can be 
used to connect to a database, disconnect from a database, browse a database,
execute SQL statements against a database, transfer data from one database 
to another, get information about current database management system and 
help on using <B>wjISQL</B>. 
<BR>
Right side of this window contains <B>status of database connection</B>.
<Li><B>Left Data Window</B>: This window in the main screen contains links to 
<B>documentation</B> pages of <B>wjISQL</B>.
<LI><B>Right Data Window</B>: This window initially contains information about 
<B>wjISQL</B>.
Once a database connection is made, the window contents are replaced by two
windows one for executing SQL statements and another for displaying result
or status of execution of the SQL statements.
</UL>
<BR>
<IMG SRC="../wji_images/wji_main.png">

<A NAME="dbconn"><H4>1.3.2 SQL Statement &amp; Result Screen</H4></A>

<P>The screen displayed when a database connection is successfully made or
when you select link <U>SQL</U> from the main screen is 
divided into four windows as follows:
</P>
<UL>
<LI><B>Navigation Window</B>: As described earlier.
<LI><B>Table &amp; Procedure List Window</B>: This window contains list of 
accessible tables in the current schema or owner, if applicable, in current
database. You can also display procedure list by clicking a button at the top
of the window. You can toggle between table list and procedure list any time
using appropriate button at the top of the window.
<LI><B>SQL Statement Window</B>: You can use this window to specify one or more
SQL statements and execute them.
<LI><B>Result Window</B>: Result of execution of the SQL statements is displayed 
in this window. You can also display properties of a table or
procedure by clicking it in the <B>Table &amp; Procedure List Window</B>.
</UL>
<BR>
<IMG SRC="../wji_images/wji_stmt_result.png">

<A NAME="dbconn"><H4>1.3.3 Transfer Screen</H4></A>

<P>The screen is displayed when you click link <U>Transfer</U> from the 
main screen. It is divided into five windows as follows:

<UL>

<LI><B>Navigation Window</B>: As described earlier, but now it contains
menu items to connect to source and destination databases and for initiating
transfer of data from source database tables to destination database tables.

<LI><B>Source Database Table List Window</B>: This window contains list of 
accessible tables in the current 
source database. This is displayed once you login into the source database.

<LI><B>Destination Database Table List Window</B>: This window contains list of 
accessible tables in the current 
destination database. This is displayed once you login into the destination
 database.

<LI><B>Source Database Work Area Window</B>: This window is used to work with
the source database. When link <U>Connect Source</U> is selected from
the <B>Navigation Window</B>, login screen is 
displayed in this window. The window is also used to display properties of 
selected source table. You can also execute SQL statements against the source
database and view results in this window.

<LI><B>Destination Database Work Area Window</B>: This window is used to work with
the destination database. When link <U>Connect Destination</U> is selected from
the <B>Navigation Window</B>, login screen is 
displayed in this window. The window is also used to display properties of 
selected destination table. You can also execute SQL statements against 
the destination database and view results in this window.
</UL>
<BR>
<IMG SRC="../wji_images/wji_transfer.png">
</P>


<BR>

<A HREF="ug_toc.jsp">Table of Contents</A>

<BR>

<%@include file="../wji_common/cmn_copyright.jsp"%>

</BODY>
</HTML>
