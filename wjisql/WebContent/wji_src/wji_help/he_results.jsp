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
 --- Function: Displays help on html frame that contains results of an SQL statement execution. 
 -->
 
<HTML>

	<HEAD><TITLE>Result</TITLE>
        <LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	</HEAD>	</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>
<%@include file="he_cmnlinks.jsp"%>
<H2><U>Result</U></H2>

<P>
This part of the web page contains results of execution of SQL 
statements as well as contents of table selected from the left window. 
When you select a table this way, columns of the selected table are 
displayed in right bottom part of the screen.  If you click button
<INPUT TYPE=BUTTON VALUE="Data">, contents of the table (result set)
are displayed 
as if you have executed a select statement.
</P>

<P><B>Insert</B>, <B>Update</B> and <B>Delete</B> operations on a result set
are supported only if the result set is displayed when a table is 
selected from the table list and its data is displayed using the button
<INPUT TYPE=BUTTON VALUE="Data"> and that too only if the table 
has a primary key. 
</P>

<P>
If you execute multiple SQL statements, the Result window contains result for
each statement: status of executing a non-SELECT statement or result set of
a SELECT statement. Each statement executed is identified with a serial number
and the statement executed itself is displayed. If required, the statement 
can be modified or it can be replaced with a new statement and executed. Once
a statement is executed from Result window, the contents of the window is replaced
with the result of the statement. 
</P>

<P>
<B>Data entry fields</B> where you can enter data are as follows:
</P>
<UL>
<LI><B>SQL Statement</B>: Enter an SQL statement to be executed. 
You can modify existing statement or specify a new
SQL statement altogether and execute it.
<LI><B>Max row limit</B>: By default only 300 rows are displayed from
a table or from the result set of a SELECT statement. If actual number of 
rows are
more than this limit an alert is given and a warning message is written
at the end of the result set. To retrieve all rows, specify a large limit.
Specifying a limit more than 300 may make your browser slow or it may even
hang! Therefore, you specify an appropriate <B>search condition</B> to the 
SELECT statement so that only required 
small number of rows are retrieved. After changing row limit you need to 
re-execute the SQL statement to see the effect of the row limit.
<LI><B>Max column size</B>: Result set column size display is limited to
the size specified in this field. If actual size of a column is less than this,
only the actual size is used to display the column values. If a column size
is more than this limit, screen space size is limited to the limit value.
Of course you can see complete data of each column value by scrolling right
 or left inside the value field even though the limit is less than the column
value size. After changing the column size you need to re-execute the SQL
statement to see the effect of the column size limit.
</UL>

<P><B>Result set column fields</B> are as follows:</P>
<OL>
<LI><B>*</B>: Row selection column. For each row of a result set, a check box
<INPUT TYPE=CHECKBOX> is displayed. You need to tick mark as in
<INPUT TYPE=CHECKBOX CHECKED>  to  perform
INSERT/UPDATE/DELETE operations on a table.
<LI><B>SNO</B>: Serial number of the row. Each row is numbered starting from 1.
The value displayed is not from the table and hence there is no direct 
relationship between the serial number and actual row displayed for a table
or SELECT statement.
<LI><B><I>Column Name</I></B>: There will be one column displayed on the screen
for each result set column.
</OL>

<P>
<B>Actions</B> you can perform in this window are as follows:
</P>

<UL>
<P>
<I><B>Note:</B> Buttons other than <B>Execute</B>, <B>Select</B> and <B>Help</B> are visible 
only if the  window <B>Result</B> is reached using button <B>Data</B> of table properties window.</I>
</P>

<LI><INPUT TYPE=BUTTON VALUE="Execute">: Executes SQL statement as present
in the field <B>SQL Statement</B>.

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Select">: Same as the previous button but 
this is displayed only when a table content is displayed or when an SQL
statement is executed. The button is not displayed if you execute SQL statements
such as INSERT, UPDATE or DELETE.

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Insert">: Use this button to insert a new
row in a table. 
An empty row is generated when you click the <B>Insert</B> button. 
Enter each column data in the empty row of the result set displayed,
click check box that is in front of the row as in <INPUT TYPE=CHECKBOX CHECKED>
and click the <B>Confirm</B> button that saves newly added row.
<BR>
<B>Inserting NULL in a column</B>: Click check box as in 
<INPUT TYPE=CHECKBOX CHECKED> that exists on the right side or below the value
of each column that is nullable.


<BR><BR>

<LI><INPUT TYPE=BUTTON VALUE="Update">: Use this button to update column
values of an existing row. You can <B><I>update only non-primary key 
column values</I></B>. If you modify primary key values, the button action 
updates rows in the table that match the modified primary key column
values! 
<BR><SPAN STYLE="COLOR:RED">The update operation is not supported
on tables that do not have primary keys.</SPAN>
<BR>
Make sure you click the check box that is in front of the row as in 
<INPUT TYPE=CHECKBOX CHECKED>
before clicking the <B>Confirm</B> button which saves modified values.

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Delete">: Use this button to delete selected 
one or more rows. Rows that match the primary key column values of the selected
rows on the screen are deleted from the table. 
<BR><SPAN STYLE="COLOR:RED">The update operation is not supported
on tables that do not have primary keys.</SPAN>
<BR>
Make sure you click the check box that is in front of the row as in 
<INPUT TYPE=CHECKBOX CHECKED>
before clicking the <B>Delete</B> button. Click the button <B>Confirm</B> to make the changes permanent.

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Confirm">: Use this button to commit the changes - new row, updates or deletions - to 
the database.
<BR><BR>
<I><B>Note:</B> The button is visible only if the window <B>Result</B> is reached using
button <B>Data</B> of table properties window.</I>

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Cancel">: Use this button to cancel Insert, Update or Delete operation.

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Clear row selection">: Use this to clear 
any tick marks/selection in check boxes present in front of rows.  

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Help">: Displays the help you are seeing now.
</UL>

<P><B>Tested data types:</B></P>
<P>Columns of these data types can be inserted or updated thorough the <B>Result</B> window.</P>
<P>Note that you can use almost all data types specific to your DBMS  
 in <B>SQL Statement</B> window.</p>
<TABLE BORDER=1>
<TR><TH>Datatype</TH><TH>MySQL</TH><TH>MariaDB</TH><TH>Oracle</TH><TH>PostgreSQL</TH><TH>SQLite</TH><TH>SQL Server</TH></TR>


<TR>
<TD COLSPAN=6 STYLE="FONT-STYLE:ITALIC;FONT-WEIGHT:BOLD;"><BR>Character string types:</TD>
</TR>

<TR>
<TD>CHAR</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>VARCHAR</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>NCHAR</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>NVARCHAR</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>CLOB</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!-- Does not support --></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>


<TR>
<TD>NCLOB</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>

<TR>
<TD COLSPAN=6 STYLE="FONT-STYLE:ITALIC;FONT-WEIGHT:BOLD;"><BR>Exact numeric types:</TD>
</TR>

<TR>
<TD>SMALLINT</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>INTEGER</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>BIGINT</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>DECIMAL</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>NUMERIC</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD COLSPAN=6 STYLE="FONT-STYLE:ITALIC;FONT-WEIGHT:BOLD;"><BR>Approximate numeric types:</TD>
</TR>

<TR>
<TD>REAL</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>FLOAT</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!-- Does not support --></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>DOUBLE PRECISION</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD COLSPAN=6 STYLE="FONT-STYLE:ITALIC;FONT-WEIGHT:BOLD;"><BR>Datetime types:</TD>
</TR>

<TR>
<TD>DATE</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>INTERVAL</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>


<TR>
<TD>TIME</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>TIMESTAMP</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>


<TR>
<TD COLSPAN=6 STYLE="FONT-STYLE:ITALIC;FONT-WEIGHT:BOLD;"><BR>Binary types:</TD>
</TR>

<TR>
<TD>BINARY</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>VARBINARY</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>BLOB</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!-- Does not support --></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>

<TR>
<TD COLSPAN=6 STYLE="FONT-STYLE:ITALIC;FONT-WEIGHT:BOLD;"><BR>Other types:</TD>
</TR>

<TR>
<TD>BOOLEAN</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>


<TR>
<TD COLSPAN=6 STYLE="FONT-STYLE:ITALIC;FONT-WEIGHT:BOLD;"><BR>Non - SQL Standard types:</TD>
</TR>

<TR>
<TD>BIGSERIAL</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>

<TR>
<TD>BIT</TD>
<TD ALIGN=CENTER><!--MySQL --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!-- Does not support --></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>BYTEA</TD>
<TD ALIGN=CENTER><!--MySQL --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>

<TR>
<TD>DATETIME</TD>
<TD ALIGN=CENTER><!-- MySQL --><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!-- MariaDB --><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!-- Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>DATETIME2</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>DATETIMEOFFSET</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>IMAGE</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>MEDIUMINT</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!-- MariaDB --><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!-- Does not support --></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>



<TR>
<TD>MONEY</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>NTEXT</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>NUMBER</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!-- MariaDB --><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>

<TR>
<TD>NVARCHAR2</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>

<TR>
<TD>SMALLDATETIME</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>SMALLMONEY</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>SERIAL</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>


<TR>
<TD>SMALLSERIAL</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>

<TR>
<TD>TEXT</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><INPUT TYPE=CHECKBOX CHECKED ></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>TINYINT</TD>
<TD ALIGN=CENTER><!--MySQL--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--MariaDB--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!-- Does not support --></TD>
<TD ALIGN=CENTER><!--SQLite--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>


<TR>
<TD>VARCHAR2</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><INPUT TYPE=CHECKBOX CHECKED></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
</TR>


<TR>
<TD>VARCHAR(MAX)</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>

<TR>
<TD>VARBINARY(MAX)</TD>
<TD ALIGN=CENTER><!--MySQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--MariaDB--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--Oracle--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--PostgreSQL--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQLite--><!--INPUT TYPE=CHECKBOX CHECKED--></TD>
<TD ALIGN=CENTER><!--SQL Server--><INPUT TYPE=CHECKBOX CHECKED></TD>
</TR>
<TR><TH>Datatype</TH><TH>MySQL</TH><TH>MariaDB</TH><TH>Oracle</TH><TH>PostgreSQL</TH><TH>SQLite</TH><TH>SQL Server</TH></TR>
</TABLE>

<BR>
<I>
<B>Notes:-</B>
<UL>
<LI> If data is not entered in a column and check box is not selected, NULL is assumed for the column.
<LI STYLE="COLOR:RED"> Result rows that is the result of executing an SQL statement can not be updated/deleted.
<LI STYLE="COLOR:RED"> Table data can not be updated/deleted if the table does not have primary key.
<LI> A row column data is updated  based on primary key column values. Hence,
if you modify primary key column values some other row matching the primary
key columns is updated. If there is no row matching the primary key columns,
then no row is updated. If your intention is to update primary key column 
values as well, use "Insert" button to insert a row with modified primary
key columns and any other columns with modified values and delete the row with 
old primary key column values after modified row is inserted.
<LI> Use <B>hexadecimal</B> representation for binary columns including BLOB 
columns.
You <SPAN STYLE="COLOR:RED"> should not use any prefix or enclose 
the binary value in a pair of quotes</SPAN>.
<Li><B>Primary key columns</B> are displayed in <SPAN STYLE="COLOR:ORANGE">
orange color</SPAN> in the Result window.
<LI>Updating of rows of tables that contain non-standard data types, for example
SET and ENUM of MySQL, may not work through the Result window. In such cases
execute an UPDATE statement in SQL Statement window.
<LI><B>SQLite</B> database management system maps specified data type in 
a column definition to one of its storage classes NULL, INTEGER, REAL, TEXT 
and BLOB based on affinity rules. Length specification for data types 
such as CHAR/VARCHAR is ignored. The data types specified as supported are
not really native data types of SQLite but they are mapped to one of the storage
classes. In this sense it is possible to use any data type with SQLite. It is
up to the user to store data properly. For example BLOB allows any thing to be
stored even though wjISQL expects hexadecimal digits to be input!
<LI>The list of data types w.r.t each DBMS is not exhaustive. They indicate 
the data types that have been tested.
</UL>
</I>
<%@include file="he_cmnlinks.jsp"%>
<HR>
<%@include file="../wji_common/cmn_copyright.jsp"%>


</BODY>
</HTML>
