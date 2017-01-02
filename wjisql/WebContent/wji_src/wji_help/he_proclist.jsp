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
 --- Function: Displays help on the frame containing list of database procedures/functions. 
 -->
 
<HTML>

<HEAD>
<TITLE>Procedure &amp; Function List</TITLE>
<link rel="shortcut icon" href="../wji_images/wjilogo32.ico">
</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>
<%@include file="he_cmnlinks.jsp"%>
<H2><U>Procedure &amp; Function List</U></H2>

<P>
This window displays list of <B>Stored Procedures</B> and <B>Functions</B> you 
can access.  
</P>

<P>If your database system
supports schemas or owners, it lists procedures and functions  available in 
your default schema or those owned by you. If you want to see procedures and
functions owned by another owner(user) or 
schema, enter the the name of the owner or schema in the corresponding field and
click <INPUT TYPE=BUTTON VALUE="Go">.
</P>


<P><B>Data entry fields</B> of this window:

<OL>
<LI><B>Owner/Schema</B>: Enter name of the owner/schema that is applicable
to your database system to list procedures and functions owned by the 
specified owner or present in the specified schema.
</OL>

<P>
<B>Actions</B> you can perform in this window are as follows:
</P>
<UL>
<LI><INPUT TYPE=BUTTON VALUE="Tables">: Lists tables.
<BR>
<A HREF="he_tbllist.jsp">More info...</A>
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Help">: Displays the help you are seeing now.
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Go">: Displays list of procedures and functions
for the specified <B>Owner/Schema</B>
<BR><BR>
<LI><U><I>Procedure/Function Name</I></U>: Displays properties of the procedure
or function. 
<BR>
<A HREF="he_procprop.jsp">More info...</A>

</UL>

<%@include file="he_cmnlinks.jsp"%>
<HR>
<%@include file="../wji_common/cmn_copyright.jsp"%>


</BODY>
</HTML>
