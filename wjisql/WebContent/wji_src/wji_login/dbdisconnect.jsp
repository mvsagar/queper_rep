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
 --- Function:		Disconnects from current database using connection object "conn".
 --- Description:	In case of data transfer operation, it disconnects source database
 ---				using connection object "conn1" and disconnects destination database
 ---				using connection object "conn2".
 -->

<HTML>
<HEAD>
<TITLE>Disconnect</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY>
<%@include file="../wji_common/imports.jsp"%>	
<SCRIPT LANGUAGE="JavaScript">
    <%@include file="../wji_common/cmn_js_funcs.jsp" %>
</SCRIPT>
<%
   String targetFrNameStrs[] = request.getParameterValues("targetfr_name"); 
   String targetFrName = new String("navifr");
   if (targetFrNameStrs != null)
	targetFrName = targetFrNameStrs[0];
  
   String nextPageStrs[] = request.getParameterValues("next_page"); 
   String nextPage = new String("");
   if (nextPageStrs != null)
	nextPage = nextPageStrs[0];

%>

<%@include file="../wji_common/connvars.jsp" %>

<FORM METHOD="POST" NAME="disconn_form">
<% 
    try {
        if (connNo == 1) { 
            if (conn1 == null) {
	        	out.print("<BR><BR><BR>");
                out.print("<P ALIGN=CENTER>No database is active.</P>");
            } else { 
                conn1.close();
	            theSession.setAttribute(CONN_OBJ_NAME, null); 
	            theSession.setAttribute("userid1", null); 
	            out.print("<BR><BR><BR>");
                out.print("<P ALIGN=CENTER>Disconnected database successfully.</P>");
                // W_B_20161226_60 BEGIN: 2019-10-04 - Table lists do not disappear after closing connections 
%>
                <SCRIPT LANGUAGE="JavaSCRIPT">
                    disconn_form.action="../wji_transfer/tr_clear.jsp";
                    disconn_form.target="leftdatafr<%=connNo%>";
                    disconn_form.submit();
                </SCRIPT>
<%              // W_B_20161226_60 END
            }
        } else if (connNo == 2) {
            if (conn2 == null) {
	            out.print("<BR><BR><BR>");
                out.print("<P ALIGN=CENTER>No database is active.</P>");
            } else {
                conn2.close();
	            theSession.setAttribute(CONN_OBJ_NAME, null); 
	            theSession.setAttribute("userid2", null); 
	            out.print("<BR><BR><BR>");
                out.print("<P ALIGN=CENTER>Disconnected database successfully.</P>");
                // W_B_20161226_60 BEGIN: 2019-10-04 - Table lists do not disappear after closing connections 
%>
                <SCRIPT LANGUAGE="JavaSCRIPT">
                    disconn_form.action="../wji_transfer/tr_clear.jsp";
                    disconn_form.target="leftdatafr<%=connNo%>";
                    disconn_form.submit();
                </SCRIPT>
<%              // W_B_20161226_60 END
            }
        } else if (connNo == 0) {
	    if (conn == null ) {
	        out.print("<BR><BR><BR>");
                out.print("<P ALIGN=CENTER>No database is active.</P>");
	    } else {
                conn.close();
		/*
		 * Invalidate the session so that 
		 * if user connects to a different RDBMS, attributes of old
		 * connection will not be used for the new connection.
		 * e.g. schema name.
		 */
	        theSession.invalidate();
	        out.print("<BR><BR><BR>");
                out.print("<P ALIGN=CENTER>Disconnected database successfully.</P>");
	    }
%>	     
             <SCRIPT LANGUAGE="JavaSCRIPT">
             disconn_form.action="../wji_common/cmn_navi.jsp";
             disconn_form.target="navifr";
             disconn_form.submit();
             </SCRIPT>
<%
       }
} catch (java.sql.SQLException se) {
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
        </SCRIPT> 
<%
     return;
   }	   
%>
	      
</FORM>
</BODY>
</HTML>

