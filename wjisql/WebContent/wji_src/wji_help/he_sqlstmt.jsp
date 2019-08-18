<!-- 
     Copyright 2006-2019 Vidyasagar Mundroy

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
 --- Function: Displays help on a window of htmp page used to specify 
 ---           an SQL statement for execution.  
 -->

<HTML>

	<HEAD>
		<TITLE>SQL Statement</TITLE>
        	<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>
<%@include file="he_cmnlinks.jsp"%>

<H2><U>SQL Statement(s)</U></H2>

<P>
Use text box of the <B>SQL Statement(s)</B> window to specify one or
more SQL statements and 
execute them. 
</P>

<P>The results of the execution are displayed in <B>Result</B> 
window that is just below the SQL Statement window.
</P>

<P>Each SQL statement, in the text box,  has to be terminated with 
a <B>semicolon</B>(;). 
The statement can 
contain comments using <B>/*</B> and <B>*/</B> (bracketed comments), 
<B>--</B> (two dashes) or even <B>//</B> (two forward slashes). 
Each statement result is displayed in the Result window. Best way to execute
multiple statements is to copy and paste the statements from a file. The 
statement can contain UNICODE data as well.
</P>

<P>
A CREATE PROCEDURE or FUNCTION SQL statement that contains multiple
statements in its body can <SPAN STYLE="COLOR:RED;"> neither be preceded 
nor be followed by any other SQL statements </SPAN> 
unless it is <B>the last SQL statement</B> in the text box. 
</p>

<P>Each SQL statement is executed in a <B>separate transaction</B>.</P>

<P><B>Executing SQL script file</B>: You can choose an SQL script file present in a folder and execute
SQL statements of the file sequentially. Once you select a script file, its contents are loaded  into 
the text box.  Clicking the execute button <INPUT TYPE=BUTTON VALUE="Execute" /> executes
all statements of the text box one after the other. The following image shows the usage:
<P>The following image shows loading of SQL statements from an SQL script file:</P>
<img alt="" src="./he_sql_script_load.png">
<P>The following image shows results after executing all statements of the SQL script file:</P>
<img alt="" src="./he_sql_script_exec.png">
<P><B>Executing selected SQL statements</B>: User can execute one or more
consecutive SQL statements present in the text box by selecting text of 
the statements and clicking the execute button <INPUT TYPE=BUTTON VALUE="Execute" />. This feature, 
along with the feature of executing SQL script file, is particularly useful to execute one or more 
SQL statements after loading the text box with contents of required SQL script file.   
</P>
<p>The following image shows two selected SQL statements ready for execution:</p>
<img alt="" src="./he_sql_stmt_sel.png">

<P><B>Data entry fields</B> of this window:</P>
<OL>
<LI><B><I>SQL Statement(s)</I></B>: Enter one or more SQL statements for execution.
</OL>

<P><B>Script file selection button</B> of this window:</P>
<OL>
<LI><B><I>Browse/Choose File</I></B>: Use this file selection button to select a file that contains 
SQL statements to be executed. The text box field <B>SQL Statement(s)</B> is filled with the SQL 
statements. Each SQL statement must be terminated with semicolon.
</OL>

<P>
<B>Actions</B> you can perform on this page are as follows:
</P>

<UL>
<LI><INPUT TYPE=BUTTON VALUE="Execute">: Executes all 
SQL statements specified in the text box of <B>SQL Statement</B> window.
The result of execution is displayed in the <B>Result</B> window.
<BR>
<A HREF="he_results.jsp">More info...</A>

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Clear">: Deletes SQL statements specified 
in the text box.
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Help">: Displays the help you are seeing now.
</UL>


<I>
<B>Notes:-</B>
<UL>
<LI>Each SQL statement has to be terminated with a semicolon.
<LI>Each SQL statement is executed in autocommit (on) mode. 
<LI STYLE="COLOR:RED;FONT-STYLE;ITALIC;">You are not allowed to INSERT/UPDATE/DELETE rows from the result set 
displayed by any SELECT statement even if it contains one table in its
FROM clause.
<LI STYLE="COLOR:RED;FONT-STYLE;ITALIC;">Parameter markers are not supported in SQL statements.
</UL>
</I>

<%@include file="he_cmnlinks.jsp"%>
<HR>
<%@include file="../wji_common/cmn_copyright.jsp"%>


</BODY>
</HTML>
