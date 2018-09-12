<!-- 
     Copyright 2006-2018 Vidyasagar Mundroy

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
 --- Function: Displays release notes of wjISQL. 
 -->
 
<HTML>
<HEAD>
<TITLE>Release Notes</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY bgcolor="#ffffff">

<BR>

<CENTER>
<H2>Release Notes</H2>
<H1>wjISQL</H1>
</CENTER> 

<H2>wjISQL 1.20.4(456)<H2>
<H3>(Sep 12, 2018)</H3>
<P>
This version has enhancements and important bug fixes.
</P>

<%@include file="../wji_help/he_req_sw.html" %>

<%@include file="../wji_help/he_req_dbms.html" %>

<%@include file="../wji_help/he_req_jdbc.html" %>

<%@include file="../wji_help/he_req_os_rdbms_comb.html" %>

<%@include file="../wji_help/he_req_browsers.html" %>


<H4> List of Enhancements:</H4>
<OL>
<LI><B>W_F_20171201_84</B>: Made script execution to stop on first error to avoid user keep on
closing error message windows displayed for each error on executing SQL statements of the 
script.
</OL>

<H4> List of Bugs Fixed:</H4>
<OL>
<Li><B>W_B_20171009_79</B>: Stored procedure and function creation fails in MariaDB.<br>
You may have to execute statement 'SET GLOBAL log_bin_trust_function_creators = 1;' 
or add 'log_bin_trust_function_creators = 1' to MariaDB configuration file
before creating functions.
<LI><B>W_B_20180911_86</B>: Selection of MariaDB in login screen makes the login screen stuck and wjISQL unusable.
<LI><B>W_B_20180911_87</B>: Switching to "Procedures" in MariaDB results in error 
"Out of range value for column 'REMARKS': value is not Short range".
<LI><B>W_B_20180911_88</B>: Table list scroll position disturbs even  when a SELECT statement is executed.
</OL>

<H4> List of Major Known Issues:</H4>
<OL>
<LI><B>W_B_20161231_64</B>: Data transfer from MS SQL server (source) table  to Oracle (destination) 
table  fails if the destination table does not have all columns of the source table and/or it has 
more columns.</LI>
<LI><B>Creation of procedure/function</B>: A create procedure/function 
statement can not be executed if it is followed by other SQL statements in
text box of SQL Statement window. 
<LI><B>Procedure Type in MS SQL Server Databases</B>: Each procedure type is returned as function by SQL Server. 
<LI><B>Dropping of procedures in SQL Server does not work</B>: 
Dropping of procedures using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page 
does not work because procedure type returned by its JDBC driver is FUNCTION
instead of PROCEDURE.
<LI><B>Dropping of functions in PostgreSQL does not work</B>: 
Dropping of functions using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page does
not work.
<LI><B>W_B_20160811_33</B>: All columns  of primary key of SQLite tables are not displayed sometimes.
This is a problem with SQLite. Filed the bug at SQLite repository at https://bitbucket.org/xerial/sqlite-jdbc/issues/228/getprimarykeys-does-not-return-all-columns
</OL>

<BR><BR>

<H2>wjISQL 1.19.5(439)</H2>
<H3>(Nov 1, 2017)</H3>
<P>
This version has enhancements and important bug fixes.
</P>

<%@include file="../wji_help/he_req_sw.html" %>

<%@include file="../wji_help/he_req_dbms.html" %>

<%@include file="../wji_help/he_req_jdbc.html" %>

<%@include file="../wji_help/he_req_os_rdbms_comb.html" %>

<%@include file="../wji_help/he_req_browsers.html" %>


<H4> List of Enhancements:</H4>
<OL>
<LI><B>W_F_20170617_72</B>: Made the source of wjISQL available as a repository on <b>github</B>. Use the link
https://github.com/mvsagar/queper_rep to access the repository.  
<LI><B>W_F_20170617_73</B>: Added current URL at the top right corner of
the wjISQL screen so that you know which database and RDBMS you are using!
<LI><B>W_F_20171006_77</B>: Added support for MariaDB.
<LI><B>W_F_20171008_78</B>: Modified Login screen functionality to display actual 
error message returned by JDBC driver for database connection failures. 
<LI><B>W_F_20171013_80</B>: Added support for deleting all rows from a table. 
Result page displayed when button <INPUT TYPE="BUTTON" VALUE="Data" /> for the table 
is clicked contains button  <INPUT TYPE="BUTTON" VALUE="Delete All" /> beside  
button <INPUT TYPE="BUTTON" VALUE="Delete" /> for this purpose.
<LI><B>W_F_20171015_81</B>: Added support for visual cue of rows selected for Update or 
Delete. Values of rows selected by you for the update are shown in bold where as the 
rows for deletion are shown in italic style with red color.

</OL>

<H4> List of Bugs Fixed:</H4>
<OL>
<LI><B>W_B_20161226_58</B>: Destination database table list is not updated after data transfer.
<LI><B>W_B_20161226_60</B>: Table lists do not disappear after closing connections. 
<LI><B>W_B_20170617_74</B>: PostgreSQL gives permission error for each public table 
while displaying tables created by other users.
<LI><B>W_B_20170711_75</B>: SQL Script loading second time fails.
<LI><B>W_B_20170728_76</B>: Order of rows of a result set is not as per ORDER BY clause. 
</OL>

<H4> List of Major Known Issues:</H4>
<OL>
<LI><B>W_B_20161231_64</B>: Data transfer from MS SQL server (source) table  to Oracle (destination) 
table  fails if the destination table does not have all columns of the source table and/or it has 
more columns.</LI>
<LI><B>Creation of procedure/function</B>: A create procedure/function 
statement can not be executed if it is followed by other SQL statements in
text box of SQL Statement window. 
<LI><B>Procedure Type in MS SQL Server Databases</B>: Each procedure type is returned as function by SQL Server. 
<LI><B>Dropping of procedures in SQL Server does not work</B>: 
Dropping of procedures using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page 
does not work because procedure type returned by its JDBC driver is FUNCTION
instead of PROCEDURE.
<LI><B>Dropping of functions in PostgreSQL does not work</B>: 
Dropping of functions using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page does
not work.
<LI><B>W_B_20160811_33</B>: All columns  of primary key of SQLite tables are not displayed sometimes.
This is a problem with SQLite. Filed the bug at SQLite repository at https://bitbucket.org/xerial/sqlite-jdbc/issues/228/getprimarykeys-does-not-return-all-columns
<Li><B>W_B_20171009_79</B>: Stored procedure and function creation fails in MariaDB.<br>
<i>Note:- This may pass in your version of MariaDB as the problem seems to be MariaDB setup as 
the feature works as expected in MySQL.</i>
</OL>

<BR><BR>

<CENTER>
<H2>Release Notes</H2>
<H1>wjISQL</H1>
</CENTER> 

<H2>wjISQL Version 1.13.17</H2>
<H3>(January 01, 2017)</H3>
<P>
This version has a few enhancements and bug fixes. The version has been tested with the following RDBMSs and browsers:
</P>
<P>Relational Database Management Systems:</P>
<TABLE BORDER="1">
<TR><TH>SNO</TH><TH>OS</TH><TH>RDBMS</TH><TH>JDBC Driver</TH></TR>
<TR><TD>1</TD><TD>Ubuntu 16.04 LTS</TD><TD>MySQL 5.7.16-0ubuntu0.16.04.1</TD><TD>mysql-connector-java-5.1.25</TD></TR>
<TR><TD>2</TD><TD>Ubuntu 16.04 LTS</TD><TD>SQLite 3.8.11</TD><TD>3.8.11</TD></TR>
<TR><TD>3</TD><TD>Ubuntu 16.04 LTS</TD><TD>PostgreSQL 9.5.5</TD><TD>PostgreSQL 9.4.1212.jre7</TD></TR>
<TR><TD>4</TD><TD>Windows 7.0</TD><TD>Oracle Database 11.2.0.1.0</TD><TD>11.2.0.2.0</TD></TR>
<TR><TD>5</TD><TD>Windows 7.0</TD><TD>SQLite 3.8.11</TD><TD>3.8.11</TD></TR>
<TR><TD>6</TD><TD>Windows 7.0</TD><TD>MS SQL Server 12.00.2000</TD><TD>4.0.4621.201</TD></TR>
</TABLE>

<P>Browsers:</P>
<TABLE BORDER="1">
<TR><TH>SNO</TH><TH>OS</TH><TH>Browser</TH></TR>
<TR><TD>1</TD><TD>Ubuntu 16.04 LTS</TD><TD>Google Chrome 54.0<TD></TR>
<TR><TD>2</TD><TD>Ubuntu 16.04 LTS</TD><TD>Mozilla Firefox 50.0.2<TD></TR>
<TR><TD>3</TD><TD>Windows 7.0</TD><TD>Google Chrome 55.0<TD></TR>
<TR><TD>4</TD><TD>Windows 7.0</TD><TD>Mozilla Firefox 50.1.0<TD></TR>
<TR><TD>5</TD><TD>Windows 7.0</TD><TD>Internet Explorer 11<TD></TR>
</TABLE>


<P> List of enhancements:</P>
<OL>
<LI><B>SQL Script file</B>: Provided support to execute SQL statements present in a text file. 
Use file browsing and selection button present below window of "SQL Statement(s)" to browse and select
script file containing SQL statements. Once a file is selected, its contents (SQL statements) 
are displayed in the window for you to execute. Execute button <INPUT TYPE=BUTTON VALUE="Execute" />
will execute all SQL statements of 
the script sequentially. 
<P>The following image shows loading of SQL statements from an SQL script file:</P>
<img alt="" src="./he_sql_script_load.png">
<P>The following image shows results after executing all statements of the SQL script file:</P>
<img alt="" src="./he_sql_script_exec.png">
<BR><BR>
</LI>
<LI><B>Executing selected SQL statements</B>: User can execute one or more
consecutive SQL statements present in the text box of <B>SQL Statement(s)</B> by selecting text of 
the statements and clicking the execute button <INPUT TYPE=BUTTON VALUE="Execute" />. This feature, 
along with the feature of executing SQL script file, is particularly useful to execute one or more 
SQL statements after loading text box with contents of required SQL script file.   
<p>The following image shows two selected SQL statements ready for execution:</p>
<img alt="" src="./he_sql_stmt_sel.png">
<BR><BR>
</LI>
<LI><B>Browsing and selecting an SQLite database file</B>: Added folder specification and file 
selection button to the login screen to make it easy to specify SQLite database file.
<p>The following image shows folder and file selection fields on the <B>Login</B> screen for <B>SQLite</B>:</p>
<img alt="" src="./he_dblogin_sqlite.png"></OL>

<P> List of bugs fixed:</P>
<OL>
<LI><B>W_B_20160510_29</B>: Exception java.lang.ArrayIndexOutOfBoundsException while processing JSP page
/wji_src/wji_transfer/tr_data.jsp at line 203.</LI>
<LI><B>W_B_20161207_41</B>: Unused file tr_tblprop.jsp found in the source.</LI>
<LI><B>W_B_20161214_44</B>: Button <INPUT TYPE=BUTTON VALUE="Login" /> below field <B>Database URL</B> 
is not displayed when SQLite JDBC driver is selected in the <B>Login</B> screen.</LI>
<LI><B>W_B_20161216_46</B>: Long binary column retrieval gives file not found error.</LI>
<LI><B>W_B_20161216_47</B>: Button Clear makes browser unresponsive.</LI>
<LI><B>W_B_20161218_48</B>: Error resulting from login operation is displayed some times in a new tab.</LI>
<LI><B>W_B_20161219_49</B>: After disconnection, left side frame contains information about wjISQL instead of menu items.</LI>
<LI><B>W_B_20161219_50</B>: When login fails, control does not come back to login screen and info entered 
by the user not restored.</LI>
<LI><B>W_B_20161221_51</B>: URL format shown for MySql on Login screen is incorrect after a connection 
failure.</LI>
<LI><B>W_B_20161221_52</B>: URL formats on the login screen are incomplete.</LI>
<LI><B>W_B_20161222_53</B>: Insertion into a table with single column fails if the insertion is done 
through <B>Result</B> window.</LI>
<LI><B>W_B_20161226_56</B>: Number of tables in table list shows up on the right side instead of 
below source database table list in Transfer screen.</LI>
<LI><B>W_B_20161226_57</B>: Login failure of source or destination database in transfer screen 
takes control to a new tab. </LI>
<LI><B>W_B_20161226_61</B>: If you try to login without selecting a JDBC driver, the login screen
disappears in main and transfer screens.</LI>
<LI><B>W_B_20161230_62</B>: Update operation on a Result set row highlights key columns instead of 
non-key columns as input fields for modification.</LI>
<LI><B>W_B_20161230_63</B>: Delete operation on a Result set row highlights columns for updating 
as if user can modify them.</LI>
<LI><B>W_B_20161231_65</B>: Login screen for SQLite shows default path of Windows even for Linux 
systems.</LI>
</OL>

<BR>

<P> List of known issues:</P>
<OL>
<LI><B>W_B_20161231_64</B>: Data transfer from MS SQL server (source) table  to Oracle (destination) 
table  fails if the destination table does not have all columns of the source table and/or it has 
more columns.</LI>
<LI><B>Creation of procedure/function</B>: A create procedure/function 
statement can not be executed if it is followed by other SQL statements in
text box of SQL Statement window. 
<LI><B>Procedure Type in MS SQL Server Databases</B>: Each procedure type is returned as function by SQL Server. 
<LI><B>Dropping of procedures in SQL Server does not work</B>: 
Dropping of procedures using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page 
does not work because procedure type returned by its JDBC driver is FUNCTION
instead of PROCEDURE.
<LI><B>Dropping of functions in PostgreSQL does not work</B>: 
Dropping of functions using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page does
not work.
</OL>

<BR><BR>

<H2>wjISQL Version 1.10.0</H2>
<H3>(January 8, 2016)</H3>
<P>
This version has a few enhancements and bug fixes.
</P>

<P> List of enhancements:</P>
<OL>
<LI><B>W_20151210_25 - Login with Enter key</B>: 
Restored an earlier feature to enable users to login by pressing Enter key. 
This is in addition to existing feature of using <B>Login</B> button.
<LI><B>W_20151214_28 - Adjustable column widths</B>: Now result set column widths are adjustable to some extent
 depending on the existing column widths.
<LI><B>W_20160104_30...32 - Confirm and Cancel buttons</B>: Introduced button <B>Confirm</B> in the result set screen.
This button need to be clicked to complete
Insert, Update or Delete operation. The button <B>Cancel</B> can be used to abort the operation. 
<LI><B>W_20160104_36 - Serial number</B>: Introduced serial number column (SNO) in the list of columns
displayed for tables or procedures to know the number of columns without manually counting. 
Result set screen also has SNO column that contains serial number of each row displayed.  
<LI><B>W_20160104_35 - Color scheme for result sets</B>: Changed color scheme for result sets from Green to 
more sober colors. 
</OL>

<P> List of bugs fixed:</P>
<OL>
<LI><B>W_20140721_19</B>: 
Transfer of data from one SQLite to another fails without any error.
<LI><B>W_20140810_22</B>: 
Procedure link crashes wjISQL when used with SQLite.
<LI><B>W_20140810_23</B>: 
Help file "help_procprop.jsp" is not found when More info is clicked for Procedure/Function Name.
<LI><B>W_20140918_24</B>: 
Deletion operation on rows of some tables gives syntax error (no ANDs found in WHERE clause).
<LI><B>W_20151210_26</B>: 
Navigation menu items not visible after login on some monitors(display systems).
<LI><B>W_20151214_27</B>: 
In table properties for keys and indexes, name "Primary key columns" is displayed right side of 
the table instead of above the table.
<LI><B>W_20160104_29</B>: 	
Table data screen not refreshed after an update.
<LI><B>W_20160105_37</B>:
Back button in the result set and keys and indexes screens does not work. 
<LI><B>W_20160105_38</B>: 
Long binary column values in the result sets contain ">" at the end.
<LI><B>W_20160105_39</B>: 
Function name list is garbled.
<LI><B>W_20160105_41</B>:
Data transfer operation does not show all errors. 
<LI><B>W_20160105_42</B>:
Menu items "Data", "Keys" and "Drop" displayed for a table of source/destination database 
do not work. "Insert", "Update" and "Delete" on result sets also do not work. 
<LI><B>W_20160105_43</B>:
Multi-lingual data does not work with MySQL.
<LI><B>W_20160106_44</B>: 
A window in a screen image in user guide used for transfer screen has been wrongly referred 
to as "Destination Database Work Area Window".
</OL>

<BR>

<P> List of known issues:</P>
<OL>
<LI><B>Script file</B>: Some times loading of SQL statement from script file does not work. To circumvent 
the problem, click the menu button <B>SQL</B> once and try loading again.
<LI><B>Max column size</B>: This field in Result window does not work as expected.
<LI><B>Creation of procedure/function</B>: A create procedure/function 
statement can not be executed if it is followed by other SQL statements in
text box of SQL Statement window. 
<LI><B>Procedure Type in MS SQL Server Databases</B>: Each procedure type is returned as function by SQL Server. 
<LI><B>Dropping of procedures in SQL Server does not work</B>: 
Dropping of procedures using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page 
does not work because procedure type returned by its JDBC driver is FUNCTION
instead of PROCEDURE.
<LI><B>Dropping of functions in PostgreSQL does not work</B>: 
Dropping of functions using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page does
not work.
</OL>

<BR><BR>

<H2>wjISQL Version 1.9.0</H2>
<H3>(April 21, 2014)</H3>
<P>
This version is one of the main releases of wjISQL. It has many new features
and bug fixes.
</P>

<P> List of enhancements:</P>
<OL>
<LI><B>Data transfer support</B>: Enhanced data transfer functionality 
to work between any two databases of database management systems <B>Microsoft
SQL Server</B>, <B>MySQL</B>, <B>Oracle Database</B>, <B>PostgreSQL</B> and 
<B>SQLite</B>. See the help of <B>Result</B> window for the supported
data types of columns for which the transfer works. 

<LI><B>Execution of multiple statements</B>: The SQL statement execution
feature has been enhanced to execute multiple SQL statements separated
by a semicolon from text box of the <B>SQL Statement</B> window. 
The statements may
contains bracketed comments using /* and */, single line comments that
start with two dashes(--) or even two forward slashes(//). If you have 
an SQL script file, you copy the statements from the file, paste them 
in the SQL Statement text box and execute all of them at once. There will be 
status or resultset for each statement in the <B>Result</B> window.
<BR>
However a <B>stored procedure</B> or <B>function</B>
can be <B>executed only alone</B> or <B>at the end of all other statements</B>.

<LI><B>Maximum Row Limit</B>: Added a field <B>Max row limit</B> at the top
of the <B>Result</B> window so that number of rows retrieved by default is
limited by the specified number. Default value is 300. You can increase the 
number and re-execute statement to retrieve more rows. If the number is 
large, your browser may crash or hang. 

<LI><B>Maximum Column Size</B>: Added a field <B>Max column size</B> at the top
of the <B>Result</B> window to specify maximum size for each column on the
browser screen. Default is 30. You can increase the size to see more of each
column value if they are big or specify a smaller number if column values are
small and hence you can fit more columns in the visible part of the screen.

<LI><B>TEXTAREA for resultset column values</B>: Used HTML tag TEXTAREA for
the resultset column values so that you can drag and see complete value of
each column.

<LI><B>NULL indicator</B>: Added a check box for each nullable column value
in the <B>Result</B> window so that one needs to simply tick mark the check
box to indicate NULL to be inserted/updated in the column.

<LI><B>Row number</B>: Added a number for each row of resultset in the
<B>Result</B> window. The row number is given by wjISQL and is nothing to do
with any column of tables related to the resultset.

<LI><B>Identification of primary key columns</B>: In the resultset of 
a select statement or data of a table, primary columns are shown in orange
color.

<LI><B>Disabled modification of primary key columns</B>: You are not allowed
to modify values of primary key columns in the <B>Result</B> window as these
values are used to identify rows to be modified for other columns in the table.

<LI><B>Refresh Button</B>: Added refresh button in table list windows of 
source and destination databases to refresh information on tables. 

<LI><B>No user ID and password field for SQLite</B>: As user ID and password are not 
required 
for SQLite databases, these have been disabled on <B>Database Login</B> screen.

<LI><B>Reset URL Button</B>: Added this button in the <B>Database Login</B> 
screen so that you can get default URL format in the field <B>Database URL</B>
in case you messed up it.

<LI><B>URL format</B>: Added a read-only field that shows the URL format
for chosen driver.

<LI><B>Option to delete data before transferring</B>: Check box has been provided
in each source table to indicate if deletion of rows from the corresponding 
table in the destination database is required. If so the transfer operation
deletes all rows from the destination table before transferring data from the
source table.

<LI><B>SQL statement execution from Result window</B>: Added a small field
for execution of any SQL statement from Result window. This is particularly
useful when you are working on transferring data from one database to 
another. If you face any problem, you can quickly execute a statement and
proceed with your data transfer working without coming to main screen of
wjISQL.

<LI><B>Dropping of procedures</B>: Added a button on the property window of
procedures so that selected procedure can be dropped.

<LI><B>Help</B>: Added context help in all screens of wjISQL.
<LI><B>Release Notes</B>: Added a link to release notes in the first screen of 
wjISQL.
<LI><B>User's Guide</B>: Added a link to User's Guide in the first screen of 
</OL>

<P> List of bugs fixed:</P>
<OL>
<LI><B>W_20130724_00001</B>: 
If a destination table does not have default for non-nullable columns, though 
wjISQL gives errors, it shows wrong number of rows as transferred.
<LI><B>W_20130724_00002</B>: Read error is thrown for BLOB column data transfer 
from SQLite to MySQL.
<LI><B>W_20130724_00003</B>: wjISQL crashes if Transfer button of the 
source database window is clicked without connecting to any database.
<LI><B>W_20130724_00004</B>: Transfer of data from BLOBs and CLOBs does not
work.
<LI><B>W_20130819_00005</B>: Delete operation to delete rows from table that
has long columns (BLOB/CLOB or its equivalents) and nulls fails.
<LI><B>W_20140304_00006</B>: wjISQL fails to display tables of PostgreSQL 
database if any table has a primary key or index.
<LI><B>W_20140304_00007</B>: Deletion of data from a table fails if there is 
no primary key for the table.
<LI><B>W_20140305_00008</B>: Error processing is error prone!
<LI><B>W_20140305_00009</B>: Processing of cookies for login information gives
unexpected values as old values for fields on the Database Login screen.
<LI><B>W_20140305_00010</B>: Deletion of empty rows results in error.
<LI><B>W_20140306_00011</B>: Binary data display for PostgreSQL tables is not correct.
<LI><B>W_20140406_00012</B>: Stored procedure meta data display does not work for Microsoft SQL Server.
<LI><B>W_20140407_00013</B>: Creation of a procedure containing multiple statements fails.
<LI><B>W_20140407_00014</B>: Execution of a procedures containing OUT or INOUT parameters fail.
<LI><B>W_20140407_00015</B>: Dropping of views fails.
</OL>

<BR>

<P> List of known issues:</P>
<OL>
<LI><B>Creation of procedure/function</B>: A create procedure/function 
statement can not be executed if it is followed by other SQL statements in
text box of SQL Statement window. 
<LI><B>Procedure Type in MS SQL Server Databases</B>: Each procedure type is returned as function by SQL Server. 
<LI><B>Dropping of procedures in SQL Server does not work</B>: 
Dropping of procedures using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page 
does not work because procedure type returned by its JDBC driver is FUNCTION
instead of PROCEDURE.
<LI><B>Dropping of functions in PostgreSQL does not work</B>: 
Dropping of functions using
button <INPUT TYPE=BUTTON VALUE="Drop"> in Procedure/Function property page does
not work.
</OL>

<BR><BR>

<H2>wjISQL Version 1.8.5</H2>
<H3>(July 17, 2013)</H3>
<OL>
<LI><B>SQLite support</B>: wjISQL now works with SQLite. You need a JDBC driver 
to use it. 

<LI><B>Null values</B>: Null values in columns of result sets are shown as
<FONT STYLE="BACKGROUND:ORANGE;">NULL</FONT>. 

<LI><B>BLOB data display</B>: If there are any BLOB or LONGVARBINARY columns 
in the resultant rows  of execution of a SELECT statement, 
they are displayed as images even though the BLOB columns may contain other 
data such as audio or video. This may be fixed in future.

<LI><B>Data Transfer</B>: Added a menu item <U>Transfer</U> in the maim menu. 
With this, it is possible now to transfer data between two databases of two 
different RDBMSs. Once you click the menu item, you are provided with a sub-menu
to login into source and destination databases and transfer data from 
all tables or
chosen tables. Before you transfer, make sure you create the tables in the
destination database as tables are not created automatically. 
<P><FONT  STYLE="COLOR:RED;">Note that rows in the destination tables are 
deleted</FONT>
before transferring data into the tables. Hence save destination table data
if required.</P>

<P>The data transfer <FONT STYLE="COLOR:RED;">may not work</FONT> 
with all SQL data types. Data transfer of LOBs from SQLite does not
work. Data transfer of CLOBs may not work. These are going to be fixed soon.
</OL>

<BR>


<H2>wjISQL Version 1.8.4</H2>
<H3>(Jan 01, 2010)</H3>
<OL>
<LI>Provided support for Microsoft SQL Server.
<LI>Fixed the problem of login failure when one directly chooses a menu option 
without first logging in.
<LI>Replaced main menu item <B>About</B> with more general menu item 
<B>Help</B>.
<LI>Now the product is licensed under Apache License 2.0.
</OL>
<U>Known Problems</U>
<OL>
<LI> When you delete  rows from a result set displayed after execution of a 
statement, the table list window is updated with result set rows instead of 
the result set window. Similar problem exists when new rows are inserted using
the result set window.
<LI> Insertion into or deletion from result set of joins are not expected to
be allowed but no clear error message is displayed.
</OL>

<BR>


<H2>wjISQL Version 1.8.3</H2>
<H3>(September 24, 2007)</h3>
<OL>
<LI>Fixed a bug with deletion of rows: If rows of a table have NULL values, 
the rows could not be deleted from the list of displayed rows. 
<LI>In SQL Statement execution window, button <INPUT TYPE=BUTTON VALUE="Clear">
cleared only SQL statement field. Now the button clears everything in 
result set window also.
<LI>Fixed failure of update operation on rows in result sets displayed by 
execution of an SQL statement.
</OL>
<U>Known Problems</U>
<OL>
<LI> When you delete  rows from a result set displayed after execution of a 
statement, the table list window is updated with result set rows instead of 
the result set window. Similar problem exists when new rows are inserted using
the result set window.
<LI> Insertion into or deletion from result set of joins are not expected to
be allowed but no clear error message is displayed.
</OL>

<BR>


<H2>wjISQL Version 1.8.2 </H2>
<H3>(June 14, 2007)</h3>
<OL>
<LI>The utility jar file <B>queper_util.jar</B> supplied with 1.8.1 
version of wjISQL was incompatible with J2SDK version 1.4.2_09 version. Hence, 
SQL statement execution functionality of wjISQL did not work correctly with the JDK. wjISQL version 1.8.2 
has fix for the problem.
</OL>

<BR>


<H2>wjISQL Version 1.8.1 </H2>
<H3>(June 10, 2007)</h3>
<OL>
<LI>Fixed the problem of not able to drop table from MySQL databases using
link <U>Drop Table</U> when a table link is clicked.
<LI>Fixed the problem of not able to get a list of tables or procedures of
an Oracle database if owner name is entered in lower case in Owner/Schema 
field. Now, the name is converted into uppercase before the lists are obtained.
</OL>

<BR>

<H2>wjISQL Version 1.8 </H2>
<H3>(June 6, 2007)</h3>
<OL>
<LI>This is a re-release of Version 1.7 with new directory names. No functionality was added. However, this has been tested with Tomcat version 5.5.
</OL>


<BR>

<H2>wjISQL Version 1.7 </H2>
<H3>(May 27, 2007)</h3>
<OL>
<LI>Provided support for Oracle Databases in login screen.
<LI>Corrected information displayed when <U>Primary key and Indexes</U> link
is selected from the screen that is displayed when a table is selected from 
a left window. Earlier, table statistics information was displayed as an index
containing a column having ordinal position as 0. Now the information is 
correctly identified and displayed explicitly as Table Statistics. The link
name has been changed to <U>Primary key, Table statistics and Indexes</U>.
</OL>

<BR>

<H2>wjISQL Version 1.6 </H2>
<H3>(May 21, 2007)</h3>
<OL>
<LI>Removed printing of internal values during table update and delete operations.
<LI>Irrespective of login user ID, once schema/owner name is entered in
the left table list window, it is preserved even across screens till changed explicitly.
<LI>Added support for <B>dropping tables</B>. To drop a table, click <U>Browse Database</U> or <U>SQL</U> link, select the table from a left window and click it. Click the link <U>Drop Table</U> from the right window to drop the table.  
<LI>Enhanced table list such that it gets automatically updated whenever a new table is added or any table is dropped.
</OL>

<BR>

<H2>wjISQL Version 1.5 </H2>
<H3>(February 12, 2007)</H3>
<OL>
<LI>Enhanced wjISQL to work with PostgreSQL 8.2.
<LI>For database browse operation, provided a field to enter schema/owner for which tables or procedures can be listed. 
<LI>Improved error handling.
<LI>Enhanced login screen so that wjISQL can be connected to any DBMS.
<LI>Enhanced login screen to remember previously entered connection information except for password.
<LI>Enhanced DBMS Info option to display database meta data.
</OL>

<BR>

<H2>wjISQL Version 1.4 </H2>
<H3>(Jan 29, 2007)</H3>
<OL>
<LI>Added a menu option <B>DBMSInfo</B> to get information on the database management system you are working with.
<LI>Navigation window has been enhanced to display the database management system you are currently using.
</OL>

<BR>

<H2>wjISQL Version 1.3 </H2>
<H3>(October 22, 2006)</H3>
<OL>
<LI>Single and double quotes are now allowed in character strings of character columns.
<LI>Reorganized internal source directory structure to make it easy to mix with other products.
<LI>Redesigned login screen for aesthetics.
</OL>

<BR>

<H2>wjISQL Version 1.2 </H2>
<H3>(September 17, 2006)</H3>
<OL>
<LI> Added display of Stored Procedure list and support for getting each procedure details.
<LI> Added display of Primary key and Indexes and their columns.
</OL>

<BR>

<h2>wjISQL Version 1.1</h2>
<h3>(September 11, 2006</h3>
	
<OL>
<LI> Added notes in login window to make it easy for users to enter right data.
<LI> Added <B>Release Notes</B> menu item to know features introduced in the current release.
<LI> If a menu item is chosen without login or login time out occurs, an alert is thrown asking users to login again. Earlier the application used to crash with stack trace.
<LI> Improved error handling but it is not yet completed!
</OL>

</BODY>
</HTML>
