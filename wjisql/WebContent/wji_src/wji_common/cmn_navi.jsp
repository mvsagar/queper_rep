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

<HTML>
<HEAD>
<TITLE>Main Navigation Menu</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY>

<%@include file="cmn_title.jsp" %>

<TABLE>
<TR>
<TD>
<a href="../wji_main/wji_index.html" TARGET="_top">Home</a>
</TD>

<TD>&nbsp;</TD>

<TD>
<a href="../wji_login/dbopen.jsp" TARGET="_top">Connect</a>
</TD>

<TD>&nbsp;</TD>

<TD>
<a href="../wji_login/dbclose.jsp" TARGET="_top">Disconnect</a>
</TD>

<TD>&nbsp;</TD>

<TD>
<a href="../wji_browse/br_main.jsp" TARGET="_top">Browse</a>
</TD>

<TD>&nbsp;</TD>

<TD>
<a href="../wji_sqlstmts/ss_main.jsp" TARGET="_top">SQL</a>
</TD>

<TD>&nbsp;</TD>

<TD>
<a href="../wji_transfer/tr_main.jsp?targetfr_name=datafr&next_page=../wji_transfer/tr_navi.jsp" TARGET="_top">Transfer</a>
</TD>

<TD>&nbsp;</TD>

<TD>
<a href="../wji_common/cmn_dbmsinfo.jsp?targetfr_name=datafr&next_page=../wji_common/dbmsinfo.jsp" TARGET="datafr">DBMS Info</a>
</TD>

<TD>&nbsp;&nbsp;</TD>

<TD>
<a href="../wji_help/he_main_menu.jsp" TARGET="_blank">Help</a>
</TD>
</TR>
</TABLE>

</BODY>
</HTML>
