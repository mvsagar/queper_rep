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
 --- Displays help on database login. 
 -->
 
<HTML>

	<HEAD>
		<TITLE>Database Login</TITLE>
		<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>
<%@include file="he_cmnlinks.jsp"%>

<H2><U>Database Login</U></H2>

<P>
Use this screen to login into the database you want to work with.
</P>

<P><B>Login information required</B>:</P>

<OL>
<LI><B>JDBC Driver</B>: Choose a JDBC driver from the drop-down list.
If the JDBC driver for your database management system is not listed, 
you can specify the JDBC driver class in the field below the drop-down list.
However, wjISQL may or may not work as the unlisted JDBC driver may not have
been ever tested.

<LI><B>Database URL</B>: If you select one of the tested JDBC driver from
the drop-down list, a default database URL is displayed in this field. 
Except for the initial protocol "jdbc", everything else in the URL is 
database management system specific. The URL definitely contains database
name unless you want to use an implied default database. Note that all 
database systems may or may not support connecting to default database. 
It also may contain host name, server port number and some other 
database management specific items. If you already used a database in an
earlier interaction with wjISQL, then previous URL you might have used is 
displayed in the field. If you find that the URL displayed automatically
by wjISQL is not correct for the chosen JDBC driver, you can reset it using
the button <INPUT TYPE=BUTTON VALUE="Reset URL"> to see default URL format
available with wjISQL.

<LI><I><B>URL Format</B>: Default URL format for the chosen JDBC driver 
is displayed in this read-only field for your convenience.</I>

<LI><B>User credentials for DBMSs other than SQLite:</B>
<OL>
<LI><B>User ID</B>: User/login/account ID/name that you have to enter 
to authenticate yourself as a valid user of the underlying database management
system. This field is not displayed if it is not applicable to chosen 
database management system such as SQLite.

<LI><B>Password</B>: Password of the the user. This is displayed only if
the field <B>User ID</B> is also displayed.
</OL>
</LI>

<LI><B>Database file for SQLite:</B> 
<OL>
<LI><B>folder</B>: Specify folder (directory) path that contains your database file.

<LI><B>file</B>: Select database file from the specified folder using file selection button.
</OL>
<P>Once folder and database file are selected, the field <B>Database URL</B> is set with the folder and
database file. If you do not specify folder in the field <B>folder</B>
and select database file using the Browse/select button, whatever value that is present in the field 
<B>Database URL</B> is used.</P>
</LI>


</OL>

<P>
<B>Actions</B> you can perform on this page are as follows:
</P>

<UL>
<LI><INPUT TYPE=BUTTON VALUE="Login">: Logs you into the specified
database so that you can work with it. Make sure your database server
is in running state before you click the button. In case of some 
database management systems such as SQLite, there is no server to start. 
Also make sure the database JDBC driver is made available to Tomcat
web server before you attempt to login into the database.
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Reset URL">: Resets value of field
<B>Database URL</B> with a default value that is right for the chosen 
JDBC driver so that
you need to change only small amount of information in the URL to be able
to connect to the database successfully.
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Help">: Displays the help you are seeing now.
</UL>


<I>
<B>Notes:-</B>
<UL>
<LI>Make sure the <B>JDBC driver</B> for the chosen database management system 
is already made available to <B>Tomcat</B> web server. Refer to installation
instructions of wjISQL for more information..
<LI>Make sure <B>database server</B> of your database management system 
is in running state if the 
database server is applicable to the chosen JDBC driver. For example, 
there is no server for SQLite and hence starting a server for the database
system is not applicable. Again refer to wjISQL installation instructions
for more information.
</UL>
</I>


<H2><U>Tips for Successful Database Login</U></H2>

<%@include file="he_dblogin_tips.jsp"%>


<%@include file="he_cmnlinks.jsp"%>
<HR>
<%@include file="../wji_common/cmn_copyright.jsp"%>


</BODY>
</HTML>
