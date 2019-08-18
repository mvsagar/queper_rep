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
 --- Function: Display help on database table list part of screen. 
 -->
 
<HTML>

	<HEAD>
		<TITLE>Table List</TITLE>
		<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="../wji_common/cmn_title.jsp"%>

<HR>
<%@include file="he_cmnlinks.jsp"%>

<H2><U>Table List</U></H2>

<P>
This window displays list of <B>tables</B> you can access. 
</P>
<P>The table list is displayed once you login into a database successfully. You 
can also display the table list at will by clicking link <U>Browse</U> or <U>SQL</U> of the navigation frame.
</P>

<P>If your database system
supports schemas or owners, it lists tables available in your default 
schema or those owned by you. If you want to see tables owned by another owner(user) or 
schema, enter the the name of the owner or schema in the corresponding field and
click <INPUT TYPE=BUTTON VALUE="Go">.
</P>

<I>
<SPAN STYLE="COLOR:RED;">Note:- 
<OL TYPE=i>
<LI>You may not see any list of tables if the owner name or schema name 
in the field <B>Owner/Schema</B> does not belong to the current database! 
This may happen if you used another owner or schema of another database
in an earlier occasion. If this is the case, change owner/schema name 
to the right name and click the button <INPUT TYPE=BUTTON VALUE="Go">
</OL>
</SPAN>
</I>

<P><B>Data entry fields</B> on this frame:</P>

<OL>
<LI><B>Owner/Schema</B>: Enter name of the owner/schema that is applicable
to your database system to list tables owned by the specified owner or 
present in the specified schema.
</OL>

<P>
<B>Actions</B> you can perform on this frame are as follows:
</P>

<UL>
<LI><INPUT TYPE=BUTTON VALUE="Procedures &amp;&#10; Functions">: Lists stored procedures and functions.
<BR>
<A HREF="he_proclist.jsp">More info...</A>

<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Help">: Displays the help you are seeing now.
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Go">: Displays list of tables for the specified
 <B>Owner/Schema</B>.
<BR><BR>
<LI><U><I>Table Name</I></U>: Displays properties of the table.
<BR>
<A HREF="he_tblprop.jsp">More info...</A>
</UL>

<%@include file="he_cmnlinks.jsp"%>
<HR>
<%@include file="../wji_common/cmn_copyright.jsp"%>


</BODY>
</HTML>
