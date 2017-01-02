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
  --- Function: 	Connects to a database using related JDBC driver. 
  ---           	If database connection is active, it simply returns.
  --- Description:	This file is included in all JSP files that need a database connection object.
  ---               Connection object "conn" represents connection to a database object. In case of
  ---               data transfer context, connection object "conn1" represents connection to 
  ---               source database where as connection object "conn2" represents connection to 
  --                destination database. 
  -->

<FORM METHOD="POST" NAME="conn_form">

<% 

   String dbURLStrs[] = request.getParameterValues("dburl");
   String dbURL = null;
   if (dbURLStrs != null)
      dbURL = dbURLStrs[0];
   String passwordStrs[] = request.getParameterValues("password"); 
   String password = null;
   if (passwordStrs != null)
      password = passwordStrs[0];

   String targetFrNameStrs[] = request.getParameterValues("targetfr_name"); 
   String targetFrName = new String("_top");
   if (targetFrNameStrs != null)
	targetFrName = targetFrNameStrs[0];
  
   String nextPage0Strs[] = request.getParameterValues("next_page"); 
   String nextPage0 = null;
   if (nextPage0Strs != null)
	nextPage0 = nextPage0Strs[0];

   String jDriverNameStrs[] = request.getParameterValues("jdriver_name"); 
   String jDriverName = null;
   if (jDriverNameStrs != null)
	jDriverName = jDriverNameStrs[0];
  
   String jDriverClassStr = request.getParameter("jdriver_class"); 
   String jDriverClass = null;
   if (jDriverClassStr != null)
	jDriverClass = jDriverClassStr;

    // For SQLite only
	String dbFolder = request.getParameter("db_folder"); 
	if (dbFolder == null) {
		dbFolder="";
	}
	
   boolean freshConn = false;

  %>

<%-- For debugging 
<SCRIPT LANGUAGE="JavaScript">
alert("1. driver class:<%=jDriverClass%>");
</SCRIPT>
--%>
<%@include file="../wji_common/connvars.jsp" %>

<%-- For debugging 
<SCRIPT LANGUAGE="JavaScript">
alert("2. userId after getattr=<%=(userId == null ? "null" : userId+"---")%>");
// alert("dbconnect:conn_no=<%=connNo%>, connobjname=<%=CONN_OBJ_NAME%>, conn1= <%=conn1%>");
</SCRIPT>
--%>
<%
    if ( (connNo == 0 && conn == null) || (connNo == 1 && conn1 == null) ||
          (connNo == 2 && conn2 == null)
       ) { 
           freshConn = true;
%>
   <%-- Debuuging info.
	   <P> First time connection </P> 
	   <P> conn obj name=<%=CONN_OBJ_NAME%> </P>
   --%>
<%
        if (jDriverClass == null) { 
            /*This means there is no connection and came to the jsp that included
	    this jsp without going thru login dialog box. Hence ask user
	    to login again.
            */
%>
            <SCRIPT LANGUAGE="JavaScript">
                 alert("Database connection is not active.\n\n" +
	          			"Please Connect to the database first." 
	          );
            </SCRIPT>
            <!--
            <META http-equiv="refresh" content="2;url=../wji_login/dblogin.jsp?targetfr_name=<%=targetFrName%>&next_page=<%=nextPage0%>">
            -->
<% 
            return; 
        } else { 
	    if (jDriverClass == null || dbURL == null ||
	          userId == null || password == null) { 
%>
                <P>Connect to database first.</P>
<%          } else {
	        try {
		   Class.forName(jDriverClass); 
		  } catch (Exception e) { 
%>
	              <SCRIPT LANGUAGE="JavaScript">
	                   alert("Error: Could not load the JDBC driver class " +
			                 "'<%=jDriverClass%>'" + "." +
	                       "\n\nCheck if you have specified correct driver class name\n" +
	                       "and made the driver available to TomCat.");
	                               conn_form.action="../wji_login/dblogin.jsp?jdriver_name=<%=jDriverName%>&jdriver_class=<%=jDriverClass%>&dburl=<%=dbURL%>&userid=<%=userId%>&targetfr_name=<%=targetFrName%>&next_page=<%=nextPage0%>";
                                       // conn_form.target="<%=targetFrName%>";
                                       //conn_form.submit(); 
						// W_B_20161226_61 BEGIN: If you try to login without selecting a JDBC driver, the login screen
						// disappears in main and transfer screens.
			            conn_form.action="../wji_login/dblogin.jsp?jdriver_name=<%=jDriverName%>" 
			            						+ "&jdriver_class=<%=jDriverClass%>&dburl=<%=dbURL%>" 
			            						+ "&userid=<%=userId%>"
			            						+ "&db_folder=<%=dbFolder%>" // Only for SQLite.  W_B_20161219_50
			            						+ "&targetfr_name=<%=targetFrName%>" 
			            						+ "&next_page=<%=nextPage0%>";
		                conn_form.target="<%=targetFrName%>";
		                conn_form.submit(); 
		             // W_B_20161226_61 END.
	              </SCRIPT>
<%                    
                 } 
                 try { 
                     tmpConn = java.sql.DriverManager.getConnection (
                          			dbURL,
                          			userId,
			  						password); 
                 } catch (java.sql.SQLException e) {
                 } 
                 if (tmpConn == null) { 
%>
        	    <BR><BR><BR><BR><BR>		   
	            <SCRIPT LANGUAGE="JavaScript">
                    alert("Error: Connection to database URL '<%=dbURLStrs[0]%>' failed." + 
                             "\n\nTry again with correct connection information after making sure your database server is running.");
	            conn_form.action="../wji_login/dblogin.jsp?jdriver_name=<%=jDriverName%>" 
	            						+ "&jdriver_class=<%=jDriverClass%>&dburl=<%=dbURL%>" 
	            						+ "&userid=<%=userId%>"
	            						+ "&db_folder=<%=dbFolder%>" // Only for SQLite.  W_B_20161219_50
	            						+ "&targetfr_name=<%=targetFrName%>" 
	            						+ "&next_page=<%=nextPage0%>";
	            // W_B_20161219_50 BEGIN: When connection fails, control does not come back to login screen 
	            // and info entered by the user not restored.
                conn_form.target="<%=targetFrName%>";
                conn_form.submit(); 
	            // W_B_20161219_50 END 
		   </SCRIPT>
               <% } else { 
                     if (connNo == 1) {
                         conn1 = tmpConn;
                         theSession.setAttribute(CONN_OBJ_NAME, conn1); 
                         theSession.setAttribute("userid1", userId); 
			 %>
	            <SCRIPT LANGUAGE="JavaScript">
	                 //alert("dbconnect:conn_no=<%=connNo%>, connobjname=<%=CONN_OBJ_NAME%>, conn1= <%=conn1%>");
		    </SCRIPT>
		    <%
                     } else if (connNo == 2) {
                         conn2 = tmpConn;
                         theSession.setAttribute(CONN_OBJ_NAME, conn2); 
                         theSession.setAttribute("userid2", userId); 
                     } else {
                         conn = tmpConn;
                         theSession.setAttribute(CONN_OBJ_NAME, conn); 
                         theSession.setAttribute("userid", userId); 
                     }

                  } 
	     } 
         } // end of else of if drivStrs[] == null
    }  // of if conn == null

    //out.print("<BR>conn1="+conn1);
    //out.print("<BR>conn2="+conn2);
    //out.print("<BR>conn="+conn);
    if (connNo == 0 && freshConn == true && conn != null) {
%>   
              <SCRIPT LANGUAGE="JavaSCRIPT">
                  conn_form.action="../wji_sqlstmts/ss_main.jsp";
                  conn_form.target="_top";
                  conn_form.submit();
              </SCRIPT>
<% 
    } else if ((connNo == 1 && conn1 != null) || 
                    (connNo == 2 && conn2 != null)) {
%>
              <SCRIPT LANGUAGE="JavaSCRIPT">
                  conn_form.action="../wji_transfer/tr_tbllist.jsp?conn_no=<%=connNo%>";
                  conn_form.target="leftdatafr<%=connNo%>";
                  conn_form.submit();
              </SCRIPT>
<%	 
    } 
%> 


</FORM>
