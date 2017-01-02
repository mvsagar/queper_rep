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

<%
   HttpSession theSession = request.getSession(true); 
   String userId = (String) theSession.getAttribute("userid"); 
   java.sql.Connection conn = 
      (java.sql.Connection) theSession.getAttribute("connobj_" + userId); 
   %>

   
<% try { %>
<TABLE WIDTH="100%">
<TR>

<TD ALIGN=LEFT VALIGN="BOTTOM" WIDTH="35%">
<%@include file="../wji_common/cmn_company_name.jsp"%>
</TD>

<TD ALIGN=CENTER> 
<%@include file="../wji_common/cmn_product_version.jsp"%>
</TD>

<!-- W_20151210_26 BEGIN: Navigation items not visible. 
     Reduced font size of right top dbms text so that 
     they are visible. -->
<TD ALIGN=RIGHT WIDTH="35%"  STYLE="FONT-SIZE:8pt;">
<!-- W_20151210_26 END -->
<%  String dbProductName = "", dbProductVersion = "", dbUserName = ""; 
    if (conn == null) {
        out.print("Not connected");
    } else {
        dbProductName =  conn.getMetaData().getDatabaseProductName();
	dbProductVersion = conn.getMetaData().getDatabaseProductVersion();
        dbUserName = conn.getMetaData().getUserName();
        out.print(dbProductName + "&nbsp;" + dbProductVersion + 
            (dbUserName == null ? "" : ":" + dbUserName));  
    }
%>
</TD>

<TR>
</TABLE>
<%
  } catch (java.sql.SQLException se) { 
%>
<META http-equiv="refresh" content="0;url=../wji_error/er_display.jsp?sql_state=<%=se.getSQLState()%>&err_msg=<%=se.toString()%>"> 
<%
     return;
   }	   
%>
