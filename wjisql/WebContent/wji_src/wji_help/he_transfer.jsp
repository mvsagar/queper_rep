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
 --- Function: Displays help on data transfer feature of wjISQL. 
 -->
 
<HTML>

	<HEAD>
		<TITLE>Transfer</TITLE>
		<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>

<HR>
<%@include file="he_cmnlinks.jsp"%>

<H2><U>Transfer</U></H2>

<P>Use this screen to <B>transfer data</B> from one or more tables from one database
(source)  to another database (destination). </P>

<P>First you need to connect to a
source database and a destination database. List of tables for transfer 
need to be selected from the source table list that is displayed once the 
source database connection is successful and initiate transfer to copy
data from the selected tables to the tables of the destination database.
Tables in the destination database corresponding to the selected tables
for transfer in the source database should already exist for the transfer
to take place. The tables are not created in the destination database by wjISQL.
Data types of columns of each destination table should be <B>compatible</B> 
with those of the corresponding source table. If a destination table has more
columns than those in the source table, then the additional columns should be
either nullable or should have a default value defined.
</P>

<P>If there are any errors while transferring data, only first few errors are
reported by wjISQL.
</P>


<P><B>Actions</B> you can perform on this page are as follows</P>

<UL>
<LI><B><U>Home</U></B>: Takes you to the home page of <B>wjISQL</B>

<BR><BR>
<LI><B><U>Connect source</U></B>: Displays a window for you to
<B>connect to a source database</B>. 
Once connection is successful, a list of tables
available in the database is displayed in the left side of the screen for 
you to select tables for transfer.
<BR>
<A HREF="he_transfer_source.jsp">More info...</A>

<BR><BR>
<LI><B><U>Disconnect source</U></B>: Disconnects from the source database.

<BR><BR>
<LI><B><U>Connect destination</U></B>: Displays a window for you to
<B>connect to a destination database</B>. 
Once connection is successful, a list of tables
available in the database is displayed in the left side of the screen.
<BR>
<A HREF="he_transfer_destination.jsp">More info...</A>

<BR><BR>
<LI><B><U>Disconnect destination</U></B>: Disconnects from the destination database.


<BR><BR>
<LI><B><U>Back</U></B>: Takes you back to the previous screen.


<BR><BR>
<LI><B><U>Help</U></B>: Displays the help you are seeing now.
</UL>

<%@include file="he_cmnlinks.jsp"%>
<HR>
<%@include file="../wji_common/cmn_copyright.jsp"%>

</BODY>
</HTML>
