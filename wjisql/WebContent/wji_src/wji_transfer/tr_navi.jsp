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
 --- Function:		Displays menu for data transfer functionality. 
 -->
 
<%@include file="../wji_common/cmn_title.jsp" %>

<TABLE >

<TR>	

<TD>
<a href="../wji_main/wji_index.html" TARGET="_top">Home</a>
</TD>

<TD>&nbsp;</TD>

<TD>
<!-- W_B_20161226_57: Login failure of source or destination database in transfer screen takes 
  -- control to a new tab instead of right data frame 1.
  -- Added correct target frame name.
  -->
<a href="../wji_login/dblogin.jsp?conn_no=1&targetfr_name=rightdatafr1&next_page=../wji_common/header.jsp" TARGET="rightdatafr1">Connect source</a>
</TD>

<TD>&nbsp;</TD>


<TD>
<a href="../wji_login/dbdisconnect.jsp?conn_no=1" TARGET="rightdatafr1">Disconnect source</a>
</TD>

<TD>&nbsp;</TD>


<TD>
<a href="../wji_login/dblogin.jsp?conn_no=2&targetfr_name=rightdatafr2&next_page=../wji_common/header.jsp" TARGET="rightdatafr2">Connect destination</a>
</TD>

<TD>&nbsp;</TD>


<TD>
<a href="../wji_login/dbdisconnect.jsp?conn_no=2" TARGET="rightdatafr2">Disconnect destination</a>
</TD>

<TD>&nbsp;</TD>


<TD>
<a href="../wji_main/wji_index.html" TARGET="_top">Back</a>
</TD>

<TD>&nbsp;</TD>


<TD>
<a href="../wji_help/he_transfer.jsp" TARGET="_blank">Help</a>
</TD>

</TR>
</TABLE>
