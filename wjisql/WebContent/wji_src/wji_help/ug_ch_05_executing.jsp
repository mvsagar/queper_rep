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
 --- Function: Displays chapter 5 of user's guide. 
 -->
 
<HTML>

<HEAD><TITLE>Chapter 5. Executing SQL Statements</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>

<A HREF="ug_toc.jsp">Table of Contents</A>

<BR>

<H2><U>Chapter 5. Executing SQL Statements</U></H2>


<A NAME="oview"><H3>5.1 Overview</H3></A>

<P>
This chapter tells you how to execute SQL statements.
<P>

<P> After all, the purpose of <B>wjISQL</B> is to execute SQL statements! It gives
uniform interface for the popular database management systems and hopefully
distances you from the idiosyncrasies of client tools of the database management
systems thus making you more productive.
</P>

<P>In order to execute an SQL statement, first make sure the screen contains 
<B>SQL Statement</B> window
where you can enter one or more SQL statements and execute them. If this
is not visible, click the link <U>SQL</U> from the navigation menu that
is present at the top of the main screen of <B>wjISQL</B>. The SQL Statement
window is displayed on the right side of the screen just below the navigation
menu window.
</P>


<A NAME="tl"><H3>5.2 Single Statement Execution</H3></A>
<P>
The SQL statement window contains a data entry field, a text box,  and 
buttons to execute SQL statements specified in the field. Enter the SQL
statement to be executed in the field and click button
<INPUT TYPE=BUTTON VALUE="Execute">.
</P>

<P>It is not necessary to terminate single SQL statement with a semicolon.
</P>

<P>If the SQL statement is a <B>SELECT</B> statement or any other statement
that gives rise to result set of rows, the rows are displayed in 
a <B>Result</B> window below the SQL Statement window. If the statement
does not give rise to any result set, status of the execution is displayed in 
the window. 
</P>


<P>In case of a result set, only a maximum of first <B>300</b> rows are displayed.
If required, you can specify a higher number in a field <B>Max row limit</B>
and re-execute the statement from the Result window itself to get rows
as per the new limit. The Result window also contains a copy of the SQL 
statement executed  from SQL statement window so that you can re-execute 
with a different limit on rows or different column sizes of the resulting
rows.  The size of column value field by default is 30. You can
adjust this according to your requirement by specifying a different 
value in the field <B>Max column size</B> so that you can fit more columns
in the visible screen or more column size for each column to see more 
data of a column value.
</P>

<A NAME="tl"><H3>5.2 Multiple Statement Execution</H3></A>
<P> To execute multiple statements, specify a sequence of statements each
terminated by a semicolon in the data entry field of the window 
<B>SQL Statement</B> and click the button <INPUT TYPE=BUTTON VALUE="Execute">.
<B>wjISQL</B> executes each of the statements and displays status of the
execution in the <B>Result</B> window. Each statement is shown with a serial
number. If a statement is a <B>SELECT</B> statement, a result set containing
rows retrieved by the statement are displayed.
Each statement result is displayed in the Result window. 
</P>

<P>
A CREATE PROCEDURE or FUNCTION SQL statement that contains multiple
statements in its body can <SPAN STYLE="COLOR:RED;"> neither be preceded 
nor be followed by any other SQL statements </SPAN> 
unless it is <B>the last SQL statement</B> in the SQL Statement
window's text box. 
</p>

<P>The statements can contain UNICODE data as well.</P>
<P>Each SQL statement is executed in a <B>separate transaction</B>.</P>

<P>
Best way to execute
multiple statements is to copy and paste the statements from an SQL script
file. 
</P>
<P>Each SQL statement has to be terminated with a <B>semicolon</B>(;) if you 
are executing multiple statements at a time.</P>

<P>You can refer to sample SQL scripts (*.sql) in the following directory:</P>
<PRE STYLE="COLOR:BLUE;">
C:\Program Files\Apache Software Foundation\Tomcat 7.0\webapps\wjisql\wji_src\wji_test
</PRE>
<P STYLE="FONT-STYLE:ITALIC;">Note that above path could be different on 
your computer if version of Tomacat you installed is not 7.0</P>


<A NAME="tl"><H3>5.3 Comments</H3></A>
Each SQL statement can be preceded or followed by comments using 
<PRE>
<B>/*</B> and <B>*/</B> (bracketed comments).
<B>--</B> (two dashes) 
<B>//</B> (two forward slashes). 
</PRE>
<P>The last two types are single line comments and hence anything specified 
after two dashes or slashes are ignored by <B>wjISQL</B>. 
However, the first type 
comment can be specified even inside an SQL statement.
</P>


<A HREF="ug_toc.jsp">Table of Contents</A>

<HR>

<%@include file="../wji_common/cmn_copyright.jsp"%>

</BODY>
</HTML>
