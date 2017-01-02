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
<HTML>


<!--
 --- Function: Displays chapter 4 of user's guide. 
 -->
 
<HEAD><TITLE>Chapter 4. Browsing Databases</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>

<A HREF="ug_toc.jsp">Table of Contents</A>

<BR>

<H2><U>Chapter 4. Browsing Databases</U></H2>


<A NAME="oview"><H3>4.1 Overview</H3></A>

<P>This chapter tells you how to browse a database. What it means is listing
tables of the database, displaying properties of the tables, viewing 
data of the tables and so on.
</P>


<A NAME="tl"><H3>4.2 Table List</H3></A>
<P>
As soon as you login into a database, list of tables if any in the database
are displayed in the left side of the screen. Number of rows currently
present in the table, type of the table, owner, schema and catalog 
information is displayed for each  table. Even though it is called table list,
the list also contains any views that might have been defined.
</P>

<P>You can also display table list by clicking link <U>Browse</U> present
in the navigation window at the top of the screen.</P>

<P>If a DBMS supports schemas or simulates them using owner name (user ID),
then a field <B>Owner/Schema</B> is displayed. Enter required name to list
tables/views present in the schema or owned by the owner.
</P>

<P>To display stored procedures and functions, click the button 
<INPUT TYPE=BUTTON VALUE="Procedures &amp; &#10; Functions"> that 
is present at the top of the table list.
</P>

<A NAME="prop"><H3>4.3 Table Properties</H3></A>
<P>
Each table is essentially an HTML link that takes you to table properties when
you click the table name. The initial properties displayed are columns of the 
the table with  
information such as name of the column, data type, whether it is nullable, etc.
This information is displayed in a window on the right side of the screen. One
can view data present in the table, keys and indexes of the table from the
properties screen. You can also drop the table using the screen.
</P>
<P>You can view key and indexes using button <INPUT 
TYPE=BUTTON VALUE="Keys">.

<P>You can also <B>drop</B> the table if required using button <INPUT 
TYPE=BUTTON VALUE="Drop">.
</P>


<A NAME="data"><H3>4.4 Viewing Data of a Table</H3></A>
Click button <INPUT TYPE=BUTTON VALUE="Data"> to display rows of the table.
Only a maximum of 300 rows are displayed by default. The displayed 
<B>Result</B> window contains fields where you can adjust number of row to be 
displayed, set the column window size and even execute any SQL statement.

<A NAME="oper"><H3>4.5 Operations on a Table</H3></A>
<P>Once you display rows from a table, you can  <B>insert</B> new rows into the 
table, <B>update</B> an existing row,  <B>delete</B> a row from the table 
or <B>select</B> rows once again using the 
buttons present for the operations at the top and bottom of the displayed
rows. Note that you can update or delete a row only if the table has a
<B>primary key</B>. Of course, you can always update or delete rows by
executing related SQL statements irrespective of whether or not the table
has primary key.
</P>

<A NAME="pfl"><H3>4.6 Procedure &amp; Function List</H3></A>

<P>From the window that contains table list you can display stored procedures 
and functions accessible by you click the button 
<INPUT TYPE=BUTTON VALUE="Procedures &amp; &#10; Functions"> that 
is present at the top of the table list.
</P>

<P>If a DBMS supports schemas or simulates them using owner name (user ID),
then a field <B>Owner/Schema</B> is displayed. Enter required name to list
procedures and functions present in the schema or owned by the owner.
</P>

<A NAME="pfprop"><H3>4.7 Procedure/Function Properties</H3></A>
<P>
Each procedure/function name in the Procedure &amp; Function list is 
essentially an HTML link that takes you to 
its properties when
you click the the name. The properties displayed are parameters,
return type and any result set columns of the 
the procedure/function with  
information such as name of the column, data type, whether it is nullable, etc.
This information is displayed in a window on the right side of the screen. 

<P>You can <B>drop</B> the selected procedure/function using button <INPUT 
TYPE=BUTTON VALUE="Drop">.
</P>


<A HREF="ug_toc.jsp">Table of Contents</A>

<HR>

<%@include file="../wji_common/cmn_copyright.jsp"%>

</BODY>
</HTML>
