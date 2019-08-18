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
 --- Function: Displays chapter 6 of user's guide. 
 -->
 
<HTML>

<HEAD><TITLE>Chapter 6. Data Transfer</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>

<A HREF="ug_toc.jsp">Table of Contents</A>

<BR>

<H2><U>Chapter 6. Data Transfer</U></H2>


<A NAME="oview"><H3>6.1 Overview</H3></A>

<P>
You can transfer data from tables of one database to another database
using <B>Transfer</B> functionality of <B>wjISQL</B>. The DBMS that manages
<B>source database</B>, the database containing tables (source tables) 
from which you want to transfer data, 
could be different from the DBMS that manages the <B>destination database</B>,
the database containing tables (destination tables) into which the data has 
to be transferred.
</P>
<P>This chapter tells you requirements and steps you need to follow to
transfer data from the source database to the destination database.</P>

<A NAME="req"><H3>6.2 Requirements</H3></A>
<OL>
<LI>Tables in the destination database should already exist. 
<BR><B>wjISQL</B> does not create the tables if they do not exist.
<LI>Names of tables in the source and the destination databases should match.
<LI>Source and destination databases should be managed by
one of the DBMSs as mentioned in section 
<A HREF="ug_chapter_02.jsp#dbms">2.3 Database Management Systems</A>.
<LI>SQL data types of columns of source and destination database tables
should be compatible.
<LI>There should  be one or more columns that have the same names in source
and corresponding destination table and data types of the columns are 
compatible.
</OL>

<A NAME="dts"><H3>6.3 Data Transfer</H3></A>
<P>
The following are the steps to transfer data from tables of source 
database to those of destination database.
</P>
<OL>
<LI>Click menu item <U>Transfer</U> from the maim menu of <B>wjISQL</B>.
<LI>From the displayed screen, connect to source and destination databases
using links <U>Connect source</U> and <U>Connect destination</U>. Once 
source database connection is successful, list of tables are displayed
in the left side window (<B>Source Database System</B>). 
Similarly, table list from destination database
is also displayed in another left side window (<B>Destination Database 
System</B>)
once connection to the destination database is successful.
<LI>If required and applicable to the source and destination databases, 
choose required schema/owner of tables of the source and destination 
databases.
<LI> Select tables to be transferred in the Source Database System window.
To select a table to transfer, click check box <INPUT TYPE=CHECKBOX CHECKED> 
against the table under column <B>Transfer?</B> in the table list. To select
all tables of the source database, click check box <INPUT TYPE=CHECKBOX CHECKED>
just below the column <B>Transfer?</B>.
<LI>If existing rows have to be <B>deleted</B> in a table in the destination 
database, click check box <INPUT TYPE=CHECKBOX CHECKED> 
against the table under column <B>Delete?</B> in the table list of the 
Source Database System. To delete existing rows from 
all tables of the destination database, click check box <INPUT TYPE=CHECKBOX 
CHECKED> just below the column <B>Delete?</B>.
<LI>Click button <INPUT TYPE=BUTTON VALUE="Transfer"> present at the top of
Source Database System window to initiate the data transfer
from the selected tables of the source database to the corresponding tables 
of the destination database.
</OL>

<P>Status of transfer for each selected table is displayed in a separate web page.
Details of source and destination databases, SELECT statements used to 
select rows from the source database, INSERT statements used to insert the
rows in the destination database, number of rows read from each table, number of
rows transferred to the corresponding table and any errors encountered are 
displayed in the web page.
</P>

<P>Rows from a source table to the corresponding destination table
are transferred based on matching columns, i.e, only values for those columns
that are common to both the tables are transferred from source table to the
destination table. Therefore, it is not necessary that schemas of both 
the tables have to match completely. Degree of tables need not be same. Only names of
columns and data types of the columns matter. The data types have to be 
compatible.
</P>


<A HREF="ug_toc.jsp">Table of Contents</A>

<HR>

<%@include file="../wji_common/cmn_copyright.jsp"%>

</BODY>
</HTML>
