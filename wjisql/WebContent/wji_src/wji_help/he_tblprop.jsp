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
 --- Function: Displays help on properties of a database table.  
 -->
 
<HTML>

	<HEAD>
		<TITLE>Table Properties</TITLE>
		<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="../wji_common/cmn_title.jsp"%>

<HR>
<%@include file="he_cmnlinks.jsp"%>

<H2><U>Table Properties</U></H2>

<P>
This window displays <B>column properties</B> of selected table. 
</P>

<P>
Each column along with various properties such as name, data type, size, etc.,
of the column are displayed.
</P>

<P>
<B>Actions</B> you can perform in this window are as follows:
</P>

<UL>
<LI><INPUT TYPE=BUTTON VALUE="Data">: Displays rows of the table.
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Keys">: Displays keys and indexes of the table.
<BR>
<A HREF="he_tblindexes.jsp">More info...</A>
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Drop">: Drops the table.
<BR><BR>
<LI><INPUT TYPE=BUTTON VALUE="Help">: Displays the help you are seeing now.
</UL>

<%@include file="he_cmnlinks.jsp"%>
<HR>
<%@include file="../wji_common/cmn_copyright.jsp"%>


</BODY>
</HTML>
