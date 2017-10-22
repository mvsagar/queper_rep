<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
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
/*
*
* Copyright (c) 2007 Andrew Tetlaw & Millstream Web Software
* http://www.millstream.com.au/view/code/tablekit/
* Version: 1.2.1 2007-03-11
* 
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use, copy,
* modify, merge, publish, distribute, sublicense, and/or sell copies
* of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
* BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
* ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
* * 
*/
 -->
 
 <!--
  --- Function:		Displays result set of an SQL statement execution. 
  -->
<HEAD>
	<TITLE>Results</TITLE>
	<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
	<link rel="stylesheet" type="text/css" media="all" href="../wji_css/style.css" />
	<%@page contentType="text/html; charset=UTF-8"%>
	<%@include file="../wji_common/imports.jsp"%>
	<%@include file="../wji_common/connvars.jsp" %>
	<SCRIPT LANGUAGE="JavaScript">
    	<%@include file="../wji_common/cmn_js_funcs.jsp" %>
    </SCRIPT>
    
    <!--  Third party software used to display nice html tables and sorting data.  -->
	<script type="text/javascript" src="../wji_js/prototype.js"></script>
	<script type="text/javascript" src="../wji_js/fabtabulous.js"></script>
	<script type="text/javascript" src="../wji_js/tablekit.js"></script>    	
	<script type="text/javascript">
		TableKit.Sortable.addSortType(new TableKit.Sortable.Type('status', {
				pattern : /^[New|Assigned|In Progress|Closed]$/,
				normal : function(v) {
					var val = 4;
					switch(v) {
						case 'New':
							val = 0;
							break;
						case 'Assigned':
							val = 1;
							break;
						case 'In Progress':
							val = 2;
							break;
						case 'Closed':
							val = 3;
							break;
					}
					return val;
				}
			}
		));

		/*
		TableKit.options.editAjaxURI = '../wji_echo/';
					
		TableKit.Editable.multiLineInput('title');
		
		var _tabs = new Fabtabs('tabs');
		$$('a.next-tab').each(function(a) {
			Event.observe(a, 'click', function(e){
				Event.stop(e);
				var t = $(this.href.match(/#(\w.+)/)[1]+'-tab');
				_tabs.show(t);
				_tabs.menu.without(t).each(_tabs.hide.bind(_tabs));
			}.bindAsEventListener(a));
			
		});
		*/
	</script>	
	
</HEAD>
<BODY>
<FORM METHOD="POST" NAME="ss_results_form">

<%  

   java.sql.ResultSet rs = null; 
   java.sql.DatabaseMetaData md = null; 
   java.sql.ResultSetMetaData rsmd = null; 
   java.sql.PreparedStatement prepStmt = null; 
   java.sql.CallableStatement callStmt = null; 

   String dbmsName = "";
   boolean isProcFunc = false;
   boolean isCallStmt = false;
   boolean execStatus = false;
   String nameProcFunc = "";
   int nParams = 0;
   int markerNo = 0;
   MdParameter param = null;
   ArrayList<MdParameter> paramList = null;
   String oper="select";
   int selRowNo = 0;

   String strVal = "";
   
   oper = request.getParameter("oper");
   if (oper == null) {
	   oper = "select";
   }
%>

<%!
   // 
   // Constants
   final int MAX_PK_COLS = 25;
   int nPKCols = 0;
   String pkCols[] = new String[MAX_PK_COLS];
   String pkVals[] = new String[MAX_PK_COLS];
   String pkStr = null;
   String stmtStr = "";
   String navDir = "next"; // Resultset navigation direction.
   String msg = "";
   // W_B_20161230_62 BEGIN: Update operation on a Result set row displays key columns instead of non-key fields 
   // as input fields for modification.
   String BG_COLOR_CELL_NONKEY = "IVORY";	// TD cell color non-key fields.
   String BG_COLOR_CELL_KEY = "ORANGE";	// TD cell color used for keys.
   String BG_COLOR_FIELD_NONKEY = "LIGHTSTEELBLUE"; 	// Fields non-key fields.
   String BG_COLOR_FIELD_KEY = "SANDYBROWN"; 	// Color of Key fields .
   String bgColorCell = "IVORY"; 
   String bgColorField = "IVORY"; 
   String UPDATED_ROW_STYLE = "font-weight:bold;";
   String DELETED_ROW_STYLE = "font-style:italic;color:red;";
   // W_B_20161230_62 END 
   String readOnly = "";

   int getColumnSize(java.sql.ResultSetMetaData r, int col, int max) {
       int size = 0;
       String name = "";
       try {
           name = r.getColumnName(col).trim();
           size = r.getPrecision(col);
	   if (size == 0) { // SQLite case
	      size = max;
	   }
       } catch (SQLException se) {
           size = 10;
       }
       if (size < name.length()) {
           size = name.length();
       } else if (size > max) {
           size = max;
       }
       return size;
   }

   // Get primary key column position
   int getPKColPos(String name)
   {
       int i;
       for (i = 0; i < nPKCols; ++i) {
            if (pkCols[i].equals(name)) {
                return i;
            }
       }
       return -1;
   }

%>


<%

   String NULL_STR = "(NULL)";
   int DEF_MAX_ROW_LIMIT = 300;
   int DEF_MAX_COLUMN_SIZE = 25;	// W_20151211_27: Display size is too big.	

   int nRows = 0, nCols = 0;
   int maxRowLimit = DEF_MAX_ROW_LIMIT;
   int maxColSize = DEF_MAX_COLUMN_SIZE; 
   String tmpFldStr = "";
   int colSize = 0;
   String colName = "";
   int colPos = -1;
   String sqlStmt = "";

   String schemaName = (String) request.getParameter("schema_name");    
   String tableName = (String) request.getParameter("table_name");    
   String objType = (String) request.getParameter("obj_type");    
   tmpFldStr = (String)request.getParameter("max_row_limit");
   if (tmpFldStr != null) {
       tmpFldStr = tmpFldStr.trim();
       if (tmpFldStr.length() > 0) {
          maxRowLimit = Integer.parseInt(tmpFldStr);
       }
   }
   tmpFldStr = (String)request.getParameter("max_col_size");
   if (tmpFldStr != null) {
       tmpFldStr = tmpFldStr.trim();
       if (tmpFldStr.length() > 0) {
          maxColSize = Integer.parseInt(tmpFldStr);
       }
   }
   tmpFldStr = (String)request.getParameter("sel_row_no");
   if (tmpFldStr != null) {
       tmpFldStr = tmpFldStr.trim();
       if (tmpFldStr.length() > 0) {
          selRowNo = Integer.parseInt(tmpFldStr);
       }
   }

   /*
   tmpFldStr = (String)request.getParameter("pk_str");
   if (tmpFldStr == null || tmpFldStr.trim().equals("")) {
       pkStr = null;
       nPKCols = 0;
   } else {
       String tmpArr[] = tmpFldStr.split(":");
       nPKCols = tmpArr.length;
       for (int i = 0; i < nPKCols; ++i) { pkVals[i] = tmpArr[i]; }
   }
   tmpFldStr = (String)request.getParameter("nav_dir");
   if (tmpFldStr == null) {
       navDir = "next";
   } 
   out.print("<BR>pk_str=" + pkStr + ", nav_dir=" + navDir);
   */


   InputStream binStrm = null;
   /*
    * Bolb and lvb type columns may contain image, video, audio or just some binary data.
    * Currently assume they contain GIF images!  
    */
   String blobType = "gif";
   String blobFile = "";


    java.sql.Connection connX;
    if (connNo == 0 && conn == null || connNo == 1 && conn1 == null || connNo == 2 && conn2 == null) {
       out.print("<BR><BR><BR>");
       out.print("<P ALIGN=CENTER>No active database connection exists.</P>");
       out.print("<P ALIGN=CENTER>Connect to a database first and try again.</P>");
       return;
    }
    connX = connNo == 0 ? conn : (connNo == 1 ? conn1 : conn2);

    String sqlStmtStr = request.getParameter("sqlstmt"); 
    if (sqlStmtStr != null) {
        sqlStmt = StringOps.convertUtf8ToUnicode(sqlStmtStr);
    }
    if (sqlStmt == null || sqlStmt.trim().equals("")) { 
        // out.print("<P>Null statement string. </P>");
		return;
    } 

    // out.print("<BR>Initial SQL stmt=" + sqlStmt);
    String stmtArr[] = sqlStmt.split(";");
    
    int nStmts = stmtArr.length;
    int stmtNo = 0;
    int index = 0;

    /* DEBUG: Print stmts split based on semicolon.
    for (int k = 0; k < nStmts; ++k) out.print("<BR>Stmt # " + k + ") [" + stmtArr[k] + "]");
    */
%>

<INPUT TYPE=HIDDEN NAME="sqlstmt" VALUE="<%=sqlStmt%>">

<TABLE WIDTH="100%" >
<TR  STYLE="BACKGROUND:LIGHTSTEELBLUE;">
<TD ALIGN=LEFT STYLE="FONT-SIZE:14pt;FONT-WEIGHT:BOLD">Result</TD>
</TR>

<TR STYLE="BACKGROUND:LIGHTGRAY;">
<TD>
Max row limit: <INPUT TYPE=TEXT NAME="max_row_limit" VALUE="<%=maxRowLimit%>" STYLE="BACKGROUND:LAVENDOR" 
        SIZE=10 ONCHANGE="validate_max_row_limit(this.form)">
        <!-- 2016-12-25: Disabled the following as it does not work due to usage of 
        tag SPAN for field values. TBF -->        
Max column size: <INPUT TYPE=TEXT NAME="max_col_size" VALUE="<%=maxColSize%>" 
		STYLE="BACKGROUND:LAVENDOR" 
        SIZE=10 ONCHANGE="validate_max_col_size(this.form)"
        DISABLED
        >
</TD>
</TR>

<%
    md = connX.getMetaData(); 
    dbmsName = md.getDatabaseProductName();

    // Execute each stmt.
    stmtNo = 0;
    boolean spfFound = false; // Found a stored procedure/function stmt.
	for (stmtNo = 0; stmtNo < nStmts; ++stmtNo) {

        isProcFunc = false;
        isCallStmt = false;
		execStatus = false;

        stmtStr = stmtArr[stmtNo].trim();
		if (stmtStr.equals("")) continue;

		/* 
		* Split the string based on 
		*      white space chars, (,  {  or =
		* to check if the stmt is a create procedure or function stmt.
		* If the current stmt is a procedure / function, join all
		* stmts starting from current stmt into one stmt because
		* there could be multiple stmts inside the body of
		* a procedure/function which were split before entering
		* the for loop. 
		*
		* '{' as token separator is required as procedure may 
		* be called with escape syntax: {call ....} or { call...}.
		*
		* '=' as token separate is needed to check if it is call
		* stmt in syntax: {?= call...} or {? = call...}
		*
		* With this logic, if one is executing  stmts, 
		* procedure/function should be the only stmt in the
		* text box or it should be the last stmt. 
		*
		* BUG: This logic does not work if tokens of create procedure/function
		* on different lines!
		*/
		String tmpArr[] = stmtStr.split("[\\s({=]+"); 
		/* DEBUG: Print tokens. 
	        out.print("<BR>stmt=[" + stmtStr);
		for (int k=0; k < tmpArr.length; ++k) out.print("<BR>"+ k + ")" + tmpArr[k]);
		*/
	
		if (!spfFound && 
		        ((tmpArr.length > 3 && tmpArr[0].equalsIgnoreCase("CREATE") &&
		                (tmpArr[1].equalsIgnoreCase("PROCEDURE") ||
			         tmpArr[1].equalsIgnoreCase("FUNCTION"))
	                 ) ||
		         (tmpArr.length > 5 && tmpArr[0].equalsIgnoreCase("CREATE") &&
	                        tmpArr[1].equalsIgnoreCase("OR") &&
	                        tmpArr[2].equalsIgnoreCase("REPLACE") &&
		                (tmpArr[3].equalsIgnoreCase("PROCEDURE") ||
			         tmpArr[3].equalsIgnoreCase("FUNCTION"))
	                 )
			)) {
             spfFound = true;
             
             if (tmpArr[1].equalsIgnoreCase("PROCEDURE") || tmpArr[1].equalsIgnoreCase("FUNCTION")) {
                 nameProcFunc = tmpArr[2];
             } else if (tmpArr[1].equalsIgnoreCase("OR") &&
                        tmpArr[2].equalsIgnoreCase("REPLACE") &&
	                (tmpArr[3].equalsIgnoreCase("PROCEDURE") ||
		         tmpArr[3].equalsIgnoreCase("FUNCTION"))) {
                 nameProcFunc = tmpArr[4];
             }
            /* Treat all stmts from stmtArr[stmtNo] .. stmtArr[nStmts-1]
             * as a single stmt of create procedure/function.
             */
             for (int k = stmtNo + 1; k < nStmts; ++k) {
	         /* Terminate each stmt in the body with with a semicolon. */
                 if (stmtArr[k].trim().equals("")) continue;
                 stmtArr[stmtNo] += "; " + stmtArr[k];
	     	}

	    	 // Add semicolon required by Oracle at the end of a procedure.
	     	if (dbmsName.equals(DBMS_ORACLE)) {
	         	stmtArr[stmtNo] += ";"; 
	    	 }

	     	nStmts = stmtNo + 1;

	     	/* DEBUG
	     	out.print("<BR>" + stmtArr[stmtNo]);
             */

             --stmtNo; // As for increments.
             continue;
        }	// if
		if (tmpArr[0].equalsIgnoreCase("CALL")) {
	            /* Case of : CALL proc... */
		    isCallStmt = true;
		    nameProcFunc = tmpArr[1];
		} else if (tmpArr.length >= 2 && tmpArr[0].equals("") && 
	                     tmpArr[1].equalsIgnoreCase("CALL")) {
	            /* Case of : {CALL proc...} */
		    isCallStmt = true;
		    nameProcFunc = tmpArr[2];
		} else if (tmpArr.length >= 4 && tmpArr[0].equals("") && 
	                     tmpArr[1].equals("?") && 
	                     tmpArr[2].equalsIgnoreCase("CALL")) {
	            /*
	             * For cases such as { ? = call proc ... }
	             * split removes { and = separators!
	             */
		    isCallStmt = true;
		    nameProcFunc = tmpArr[3];
	        }
	        /* DEBUG 
	           out.print("<BR>isCallStmt=" + isCallStmt);
	         */
	        try {
	            connX.setAutoCommit(true);
%>

<TR STYLE="BACKGROUND:LIGHTBLUE;">
<TD>
<B><%=(stmtNo+1)%>) SQL Statement: </B> 
<TEXTAREA NAME="sqlstmt<%=stmtNo%>" ROWS=2 COLS=65><%=stmtStr%></TEXTAREA>
<INPUT TYPE=BUTTON VALUE="Execute" STYLE="BACKGROUND:AQUA;"
   ONCLICK="select_rows(this.form, <%=stmtNo%>)">
</TD>
</TR>

<%

        
	        /* Get primary key columns if user clicked one of the tables
	         * in the list of tables on the left frame so that primary key
	         * columns can be shown in different color.
	         */
	        // out.print("table="+tableName);
			if (tableName == null) {
	             nPKCols = 0; // Otherwise pkCols of earlier invocation of the JSP is being used!
	        } else {        
	            rs = md.getPrimaryKeys(null, schemaName, tableName); 
	            nPKCols = 0; 
	            while (rs.next()) { 
	                pkCols[nPKCols++] = rs.getString(4);
	            } 
	            rs.close();
	        }

        	// Prepare the stmt 
			if (isCallStmt) {
	            /*
	             *  Get statement by replacing supplied IN and INOUT parameter
	             *  values with parameter markers "?".
	             */
	            param = null;
	            paramList = new ArrayList<MdParameter>();
	            MetaData.getParamList(connX, schemaName, nameProcFunc, paramList);
	            nParams = paramList.size();
	            /* DEBUG: 
	            out.print("<BR>schema=" + schemaName + ", proc=" + nameProcFunc);
	            out.print("<BR>Param#s: " + nParams);
	            for (int k = 0; k < nParams; ++k) {
	               param = paramList.get(k);
	               out.print("<BR>" + (k+1) + "name=" + param.getParamName() +
	                      ", inout=" + param.getParamInOutType() + 
	                      ", type=" + param.getParamDataType() +
	                      ", value=" + param.getParamVal()
	                    ); 
	                      
	            }
	            */
	            String callStmtStr = " { " + MetaData.getCallStmtWithParamMarkers(nameProcFunc, stmtStr, paramList) +
	                                 " } ";
	             
	            /* DEBUG:  
	            out.print("<BR>Call stmt: " + callStmtStr);
	            */
		    	callStmt = connX.prepareCall(callStmtStr); 
	            
	            // Find number of parameter markers and
	            // register parammeters. Assume that one should
	            // not specify parameter markers for IN put parameters.
	            for (int k = 1; k <= nParams; ++k) {
	                param = paramList.get(k-1);
	                switch (param.getParamInOutType()) {
	                     case DatabaseMetaData.procedureColumnIn: 
	                         // DEBUG: out.print("<BR>Param # " + k + ": IN ; Val=[" + param.getParamVal() + "]");
	                         callStmt.setString(k, param.getParamVal());
	                         break;
	                     case DatabaseMetaData.procedureColumnOut:
	                         // DEBUG: out.print("<BR>Param # " + k + ": OUT");
	                         callStmt.registerOutParameter(k, Types.VARCHAR);
	                         break;
	                     case DatabaseMetaData.procedureColumnReturn:
	                         // DEBUG: out.print("<BR>Param # " + k + ": RETURN");
	                         callStmt.registerOutParameter(k, Types.VARCHAR);
	                         break;
	                     case DatabaseMetaData.procedureColumnInOut:
	                         // DEBUG: out.print("<BR>Param # " + k + ": INOUT ; Val=" + param.getParamVal());
	                         callStmt.setString(k, param.getParamVal());
	                         callStmt.registerOutParameter(k, Types.VARCHAR);
	                         break;
	                }
	            }
	            
	     		execStatus = callStmt.execute();
			} else {
			    prepStmt = connX.prepareStatement(stmtStr); 
			    execStatus = prepStmt.execute();
			    // out.print("stmt=" + stmtStr + ", exec st=" + execStatus + ", isCallStmt=" + isCallStmt);
		
		            /* 
		             * CREATE Procedure/function stmt in Oracle gives
		             * warnings instead of error if the procedure/function
		             * fails to compile. Hence the following code examine
		             * warnings and catch it as en error!
		             */
		            if (dbmsName.equals(DBMS_ORACLE)) {
		                SQLWarning warning = prepStmt.getWarnings();
		                if (warning != null)
			        {
			            /*
			            out.print("<BR>Warning:");
			            while (warning != null) {
				        out.print("<BR>" + warning.getErrorCode() + ":" + 
				            warning.getSQLState() + ":" + warning.getMessage());
				        warning = warning.getNextWarning();
			            }
		                    */
		                    SQLException se = new SQLException(warning.getErrorCode() + ":" + 
				            warning.getSQLState() + ":" + warning.getMessage(), "WARNING");
		                    throw se;
		                }
			    	}
				}
		
			    // out.print("exec st=" + execStatus + ", isCallStmt=" + isCallStmt);
			        
			    if (execStatus == false) {
			            // No result set
				    int updCount;
			        if (isCallStmt) {
				        updCount = callStmt.getUpdateCount(); 
				    } else {
				        updCount = prepStmt.getUpdateCount(); 
				    }
%>	
<TR><TD><I>Number of rows inserted/updated/deleted = <%=updCount%></I></TD></TR> 
<%	    
			    } else { 
			            // Stmt has result set.
			     	if (isCallStmt) {
			                rs = callStmt.getResultSet(); 
				    } else {
			                rs = prepStmt.getResultSet(); 
				    }
			            rsmd = rs.getMetaData(); 
			
			            // Get column count.
			            nCols = rsmd.getColumnCount();
			            nRows = 0;
			
				    /*
			            out.print("<P>Result set for " +
			                     (tableName == null ?  " statement: " : " table: " )  +
			                     "<span style=\"font:bold;font-size:14pt;\">" + 
						     (tableName == null ?    stmtStr :  tableName) + "</span></P>");
			             */
			%>




<TR>
<TD>
<% 
				     /* 
				      * Display buttons only for the firstresult as field names for result set columsn are not
				      * distinct for each result set and in any case DML ops can be applied only on one table
				      * result/
				      */
				     if (stmtNo == 0) { 
%>
<%@include file="ss_results_buttons.jsp" %>
<% 
					} 
%>
</TD>
</TR>

</TABLE>
<!--  Do not add 'editable' in the list of classes. 
      Otherwise OK, Cancel will appear when a cell is clicked. 
 	-->
<TABLE  class="sortable resizable">
	<thead>     
    <TR STYLE="BACKGROUND:SEAGREEN;">
    <%-- Output row selection header. --%>
    <TH >
	    <INPUT TYPE=TEXT NAME="vr0c0" VALUE="*" SIZE=1 READONLY
			      STYLE="BACKGROUND:SEAGREEN;COLOR:WHITE;BORDER-STYLE:NONE;FONT:BOLD;FONT-SIZE:14pt;"
	    >
    </TH>
    
    <!-- W_B_20170728_76 2017-10-02 BEGIN: 
      -- Removed default sort class from the SNO column 
      -- as this results in sorting values of SNO which is an integer as strings 
      -- and hence value 10 comes after 1 instead of 9. Because of this, result 
      -- looks as if it does not correspond to order specified in SELECT statement.
      -->
    <!-- TH class="sortfirstasc" --> 
    <TH>
    <!-- W_B_20170728_76 END --> 
	    <!-- W_20151211_27: Display size is too big. -->
	    <INPUT TYPE="TEXT" NAME= "vsnor0c0" VALUE="SNO" SIZE=4 READONLY
	    STYLE="BACKGROUND:SEAGREEN;COLOR:WHITE;BORDER-STYLE:NONE;FONT:BOLD;FONT-SIZE:12pt;"> 
    </TH>
        
    <%-- Print column names. --%>
<% 
       for (int i = 1; i <= nCols; ++i) {
           colName = rsmd.getColumnName(i);
           colSize = getColumnSize(rsmd, i, maxColSize);
           // out.print("<BR>colsize=" + colSize);
%>
               <TH>
		<!-- W_20151211_27: Display size is too big. -->
               <INPUT TYPE=HIDDEN NAME=<%="vr0c" + Integer.toString(i)%>
		              VALUE="<%=colName%>" SIZE=<%=colSize%>
			      STYLE="BACKGROUND:SEAGREEN;COLOR:WHITE;BORDER-STYLE:NONE;FONT:BOLD;FONT-SIZE:12pt;"  
			      READONLY>
			      <%=colName%>
               </TH>
<% 
      } 
%>
    </TR>
	</thead>
    <tbody>
    <%-- Print row data --%>
       <%-- Put empty cells so that the user can insert data if required. --%>
<%
	if (oper.equals("insert")) {
        ++nRows; 
            /* 
             * SQLite crashes if we try to use methods such isNullable on resultset metadata
             * after all rows are retrieved. Hence closing current resultset, reexecute the stmt
             * and get meatadata.
             */
             /*
            if (dbmsName.equals(DBMS_SQLITE)) { 
                rs.close();
                prepStmt.execute();
                rs = prepStmt.getResultSet(); 
                rsmd = rs.getMetaData();
            }
        */
%>
        <TR>
	    <%-- Initialize CHECKBOX to CHECKED by default for insertion.--%>
        <TD BGCOLOR="#00FF00">
	        <INPUT TYPE="CHECKBOX" NAME=<%= "vr" + Integer.toString(nRows) +
		             "c0"%> VALUE="" CHECKED>
	    </TD>
        <TD BGCOLOR="#00FF00">
	        <INPUT TYPE="HIDDEN" NAME=<%= "vsnor" + Integer.toString(nRows) +
		"c0"%> VALUE="<%=nRows%>" SIZE=4 READONLY STYLE="BACKGROUND:LIGHTSTEELBLUE;BORDER-STYLE:NONE;">
	    <%=nRows%>
	    </TD>
	    <% for (int i = 1; i <= nCols; ++i) { 
	        /* The following stmt crashes jsp!
		// colSize = getColumnSize(rsmd, i, maxColSize);
		*/
		colSize = 10;
		%>
	        <TD BGCOLOR="#00FF00">
		    <INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) + "c" +
		              Integer.toString(i)%> SIZE=<%=colSize%>
		           VALUE="">
<%
                          if (rsmd.isNullable(i) == 1) {
%>
                               <INPUT TYPE=CHECKBOX NAME=<%= "vnullr" + Integer.toString(nRows) 
                               		+ "c" + Integer.toString(i)%>
                                        >
                              
<%
                          }
%>
		</TD>
<%
			} 	
%>
         </TR>     
<% 
	}

      int ct = -999999; // column type.
      String chkVal = null;
	
      while (rs.next() && nRows < maxRowLimit) { %>
        <TR STYLE="BACKGROUND:SEAGREEN;<%=(oper.equals("delete_all") ? DELETED_ROW_STYLE : " ")%>" >
	    <% ++nRows;
	       chkVal = request.getParameter("vr" + nRows + "c0");
	    %>
	    <%-- Initialize modify/delete selection column value. --%>
            <TD BGCOLOR="MOCCASIN">
	        <INPUT TYPE="CHECKBOX" NAME=<%= "vr" + Integer.toString(nRows) +
		             "c0"%> VALUE="" <%=(chkVal == null ? " " : " CHECKED ")%>
		             STYLE="<%=(chkVal != null && oper.equals("delete") ? DELETED_ROW_STYLE : " ")%>">
	    </TD>
        <TD BGCOLOR="LIGHTGRAY">
	        <INPUT TYPE="HIDDEN" NAME=<%= "vsnor" + Integer.toString(nRows) +
		"c0"%> VALUE="<%=nRows%>" SIZE=4 READONLY STYLE="BACKGROUND:LIGHTSTEELBLUE;BORDER-STYLE:NONE;">
	    <span STYLE="<%=(chkVal != null && oper.equals("delete") ? DELETED_ROW_STYLE : " ")%>"><%=nRows%></span>
	    </TD>
	    <%-- Display column values in a row. --%> 
	    <% 
	    // W_B_20161230_62 BEGIN: Update operation on a Result set row displays key columns instead of non-key fields 
	    // as input fields for modification.
		// W_20151211_28 BEGIN: Null indicator check boxes wrap in result set columns. Specified NOWRAP for table cells. 
		for (int i = 1; i <= nCols; ++i) { 
			colSize = getColumnSize(rsmd, i, maxColSize);
		   	colName = rsmd.getColumnName(i);

                   /*
                    * Display primary key columns in orange color and make them readonly.
                    */
		   	if (getPKColPos(colName) >= 0) {
		    	bgColorCell = BG_COLOR_CELL_KEY;
		    	// W_B_20161230_63 BEGIN: Delete operation on a Result set row  displays columns for updating 
		    	// as if user can modify them.
		    	if (oper.equals("delete") || oper.equals("delete_all")) {
		    		bgColorField = bgColorCell;
		    		readOnly = "READONLY";
		    	} else {
		    		bgColorField = BG_COLOR_FIELD_KEY;
	                /*
	                 * Do not set the following to READONLy to allow users to add a new record
	                 * with minor changes to primary key columns!
	                 */
			       	readOnly = "";
		    	}
		    	// W_B_20161230_63 END
		   } else {
		    	// W_B_20161230_63 BEGIN: Delete operation on a Result set row  displays columns for updating 
		    	// as if user can modify them.
		    	bgColorCell = BG_COLOR_CELL_NONKEY;
		    	if (oper.equals("delete") || oper.equals("delete_all")) {
		    		bgColorField = bgColorCell;
		    		readOnly = "READONLY";
		    	} else {
		    		bgColorField = BG_COLOR_FIELD_NONKEY;
					readOnly = "";
		    	}
		    	// W_B_20161230_63 END
		   }
%>
           <TD STYLE="BACKGROUND:<%=bgColorCell%>">
<%
           ct = rsmd.getColumnType(i);
			// out.print("<BR>" + ct + "(" + rsmd.getColumnTypeName(i) + ")" );
           switch (ct) {
           case Types.BLOB :
           case Types.LONGVARBINARY : {
	           if (connX.getMetaData().getDatabaseProductName().equalsIgnoreCase(DBMS_SQLITE) == true) {
	                byte[] byteArr = rs.getBytes(i);
		           if (rs.wasNull()) {
		              binStrm = null;
		           } else {
		              binStrm = new ByteArrayInputStream(byteArr);
		           }
               } else {
                   binStrm = rs.getBinaryStream(i); 
		           if (rs.wasNull()) {
		              binStrm = null;
		           }
	           }
               blobFile = nRows + "_bin." + blobType;
               try {
                  	// Writing to image file requires complete path.
                  	String blobFilePath =  request.getRealPath("/") + 
                         "wji_src/wji_tmp/" + blobFile  ;
                  	if (binStrm == null) {
						if (oper.equals("update")) {                       		
%>
	                  		<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) +
		                    	"c" + Integer.toString(i)%>
				      			VALUE="<%=NULL_STR%>" STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;<%=(chkVal != null ? UPDATED_ROW_STYLE : " ")%>" <%=readOnly%>
				      			>
<%				      			
						} else if (oper.equals("delete")) {                       		
%>
	                  		<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) +
		                    	"c" + Integer.toString(i)%>
				      			VALUE="<%=NULL_STR%>" STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;<%=(chkVal != null ? DELETED_ROW_STYLE : " ")%>" <%=readOnly%>
				      			>
<%
						} else {
%>
	                  		<SPAN STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;"><%=NULL_STR%></SPAN>				      	
<%
						}
%>				      
                         <INPUT TYPE=CHECKBOX NAME=<%= "vnullr" + Integer.toString(nRows) 
                         		+ "c" + Integer.toString(i)%>
                                         CHECKED <%=readOnly%> >
<%
					} else {
	                	int avlBytes = binStrm.available();
	                	FileOutputStream fos = new FileOutputStream (blobFilePath);
	                	BufferedOutputStream bos = new BufferedOutputStream (fos);
	
	                	byte[] byteArray = new byte [512]; 
						int bytesRead = binStrm.read(byteArray);

					     /* Commented this because blob col may reduced to 5 or less bytes
					     * if the column is updated and thus loosing big blob.
					     *
					     // Convert first 5 bytes to hex for display in addition to image.
		                             int len = bytesRead <= 5 ? bytesRead : 5;
					     byte[] ba = new byte[len];
					     for (int k = 0; k < len; ++k) ba[k] = byteArray[k];
					     String hexStr = StringOps.bytesToHex(ba);
					     // end
                         */

			     		StringBuffer hexStr = new StringBuffer("");
                        while (bytesRead > 0) {
                            bos.write(byteArray, 0, bytesRead);
			         		hexStr.append(StringOps.bytesToHex(byteArray));
	                        bytesRead = binStrm.read(byteArray);
                        }
                        bos.flush();
                        bos.close();
                        fos.flush();
                        fos.close();
                        
						if (oper.equals("update")) {                       		                        
%>
		                 	<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) 
		                 		+ "c" + Integer.toString(i)%>
				 				VALUE="<%=hexStr%>" STYLE="BACKGROUND:<%=bgColorField%>;<%=(chkVal != null ? UPDATED_ROW_STYLE : " ")%>" <%=readOnly%>>
                                 <IMG SRC="../wji_tmp/<%=blobFile%>"> 
<%
						} else if (oper.equals("delete")) {                       		                        
%>
		                 	<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) 
		                 		+ "c" + Integer.toString(i)%>
				 				VALUE="<%=hexStr%>" STYLE="BACKGROUND:<%=bgColorField%>;<%=(chkVal != null ? DELETED_ROW_STYLE : " ")%>" <%=readOnly%>>
                                 <IMG SRC="../wji_tmp/<%=blobFile%>"> 
<%
						} else {
%>
		                 	<SPAN STYLE="BACKGROUND:<%=bgColorField%>"><%=hexStr%></SPAN>
                                 <IMG SRC="../wji_tmp/<%=blobFile%>"> 
<%
						}
                        if (rsmd.isNullable(i) == 1) {
%>
                            <INPUT TYPE=CHECKBOX NAME=<%= "vnullr" + Integer.toString(nRows) 
                            	+ "c" + Integer.toString(i)%>
                                <%=(rs.wasNull() ? " CHECKED " : "")%> <%=readOnly%> >
                              
<%
                        }
                     }
                  } catch (IOException ioe) {
                    %>
                         <SCRIPT Language="JavaScript">
	                     displayMessage("Error", "", 
	                          "<%=StringOps.xForm4JS(ioe.toString())%>"); 
                         </SCRIPT>			 
<%
                       }
                   }
                   break;
               case Types.BINARY:
               case Types.VARBINARY:
		      			byte ba[] = rs.getBytes(i);
                       	if (rs.wasNull()) {
                       
							if (oper.equals("update")) {                       		
%>
		               			<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows)
		                      		+ "c" + Integer.toString(i)%>  SIZE=<%=colSize%>
		                   			VALUE="<%=NULL_STR%>" STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;<%=(chkVal != null ? UPDATED_ROW_STYLE : " ")%>">
<%
							} else if (oper.equals("delete")) {                       		
%>
		               			<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows)
		                      		+ "c" + Integer.toString(i)%>  SIZE=<%=colSize%>
		                   			VALUE="<%=NULL_STR%>" STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;	<%=(chkVal != null ? DELETED_ROW_STYLE : " ")%>">
<%
							} else {
%>
		               			<SPAN STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;"><%=NULL_STR%></SPAN>
<%		               			
							}
%>
                            <INPUT TYPE=CHECKBOX NAME=<%= "vnullr" + Integer.toString(nRows) 
                            	+ "c" + Integer.toString(i)%>
                                         CHECKED >
<%
                       } else {
                            strVal = StringOps.bytesToHex(ba);
                            	
							if (oper.equals("update")) {                       		
%>
		            			<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) 
		            				+ "c" + Integer.toString(i)%>  SIZE=<%=colSize%>
		                   			VALUE="<%=strVal%>" <%=readOnly%>
                                   	STYLE="BORDER-STYLE:NONE;BACKGROUND:<%=bgColorField%>;<%=(chkVal != null ? UPDATED_ROW_STYLE : " ")%>"
                            		>
<%
							} else if (oper.equals("delete")) {                       		
%>
		            			<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) 
		            				+ "c" + Integer.toString(i)%>  SIZE=<%=colSize%>
		                   			VALUE="<%=strVal%>" <%=readOnly%>
                                   	STYLE="BORDER-STYLE:NONE;BACKGROUND:<%=bgColorField%>;<%=(chkVal != null ? DELETED_ROW_STYLE : " ")%>"
                            		>
<%
							} else {
%>
		            			<SPAN STYLE="BORDER-STYLE:NONE;"><%=strVal%></SPAN>
<%
							}
                          	if (rsmd.isNullable(i) == 1) {
%>
                               <INPUT TYPE=CHECKBOX NAME=<%= "vnullr" + Integer.toString(nRows) 
                               	+ "c" + Integer.toString(i)%>
                                        <%=(rs.wasNull() ? " CHECKED " : "")%>  <%=readOnly%> >
                              
<%
                          	}
                       }
                       break;
                   case Types.CHAR:
                   case Types.VARCHAR:
                   case Types.LONGVARCHAR:
                   case Types.NCHAR:
                   case Types.NVARCHAR:
                   case Types.LONGNVARCHAR:
		       			strVal = rs.getString(i);
                       	if (rs.wasNull()) {
							if (oper.equals("update")) {                       		
%>
		               		<TEXTAREA  NAME=<%= "vr" + Integer.toString(nRows) + "c" +
		                      Integer.toString(i)%>  COLS=<%=colSize%> ROWS=1 <%=readOnly%>
		                    	STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;<%=(chkVal != null ? UPDATED_ROW_STYLE : " ")%>"><%=NULL_STR%></TEXTAREA>
<%
							} else if (oper.equals("delete")) {                       		
%>
		               		<TEXTAREA  NAME=<%= "vr" + Integer.toString(nRows) + "c" +
		                      Integer.toString(i)%>  COLS=<%=colSize%> ROWS=1 <%=readOnly%>
		                    	STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;<%=(chkVal != null ? DELETED_ROW_STYLE : " ")%>"><%=NULL_STR%></TEXTAREA>
<%
							} else {
%>
			               		<SPAN STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;"><%=NULL_STR%></SPAN>
<%
							}
%>							
                            <INPUT TYPE=CHECKBOX NAME=<%= "vnullr" + Integer.toString(nRows) 
                            	+ "c" + Integer.toString(i)%>
                            		CHECKED <%=readOnly%>>
<%                            
                       } else {      
			       			/*
			       			out.print("<BR>1:" + strVal);
			       			byte[] val = rs.getBytes(i);
			       			out.print("<BR>3:" + StringOps.bytesToHex(val));
			       			out.print("<BR>");
			       			*/
							if (oper.equals("update")) {                       		
%>
		           			 <TEXTAREA NAME=<%= "vr" + Integer.toString(nRows) 
		           			 	+ "c" + Integer.toString(i)%> COLS=<%=colSize%> 
                                  ROWS=1 <%=readOnly%> 
                              STYLE="BORDER-STYLE:NONE;BACKGROUND:<%=bgColorField%>;<%=(chkVal != null ? UPDATED_ROW_STYLE : " ")%>"><%=StringOps.getHTMLString(strVal).trim()%></TEXTAREA>
<%
							} else if (oper.equals("delete")) {                       		
%>
		           			 <TEXTAREA NAME=<%= "vr" + Integer.toString(nRows) 
		           			 	+ "c" + Integer.toString(i)%> COLS=<%=colSize%> 
                                  ROWS=1 <%=readOnly%> 
                              STYLE="BORDER-STYLE:NONE;BACKGROUND:<%=bgColorField%>;<%=(chkVal != null ? DELETED_ROW_STYLE : " ")%>"><%=StringOps.getHTMLString(strVal).trim()%></TEXTAREA>
<%
							} else {
%>
			           			 <SPAN STYLE="BORDER-STYLE:NONE;"><%=StringOps.getHTMLString(strVal).trim()%></SPAN>
<%
								
							}
                          	if (rsmd.isNullable(i) == 1) {
%>
                               <INPUT TYPE=CHECKBOX NAME=<%= "vnullr" + Integer.toString(nRows) 
                               	+ "c" + Integer.toString(i)%>
                                  <%=(rs.wasNull() ? " CHECKED " : "")%> >                              
<%
                          }
                       }
                       break;
                   default:
		       			strVal = rs.getString(i);
                       	if (rs.wasNull()) {
                       	
                    		if (oper.equals("update")) {
%>
				               <INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) + "c" + 
				                      Integer.toString(i)%>  SIZE=<%=colSize%>
				                   VALUE="<%=NULL_STR%>" STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;<%=(chkVal != null ? UPDATED_ROW_STYLE : " ")%>">
<%
                    		} else if (oper.equals("delete")) {
%>
				               <INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) + "c" + 
				                      Integer.toString(i)%>  SIZE=<%=colSize%>
				                   VALUE="<%=NULL_STR%>" STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;<%=(chkVal != null ? DELETED_ROW_STYLE : " ")%>">
<%
                    		} else {
%>
         		               <SPAN STYLE="BACKGROUND:<%=bgColorField%>;BORDER-STYLE:NONE;"><%=NULL_STR%></SPAN> 
<%
                    		}
                       } else {
                     
                   			if (oper.equals("update")) {                          
%>
		            			<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) + "c" +
		                     	Integer.toString(i)%>  SIZE=<%=colSize%>
		                   		VALUE="<%=StringOps.getHTMLString(strVal)%>" <%=readOnly%>
                                   STYLE="BORDER-STYLE:NONE;BACKGROUND:<%=bgColorField%>;<%=(chkVal != null ? UPDATED_ROW_STYLE : " ")%>"
                           		>
<%                            
                   			} else if (oper.equals("delete")) {                          
%>
		            			<INPUT TYPE=TEXT NAME=<%= "vr" + Integer.toString(nRows) + "c" +
		                     	Integer.toString(i)%>  SIZE=<%=colSize%>
		                   		VALUE="<%=StringOps.getHTMLString(strVal)%>" <%=readOnly%>
                                   STYLE="BORDER-STYLE:NONE;BACKGROUND:<%=bgColorField%>;<%=(chkVal != null ? DELETED_ROW_STYLE : " ")%>"
                           		>
<%                            
                   			} else {
%>
		            			<SPAN><%=StringOps.getHTMLString(strVal)%></SPAN>
<%
                          	}
                   			
                   		}
                        if (rsmd.isNullable(i) == 1) {
%>
                               <INPUT TYPE=CHECKBOX NAME=<%= "vnullr" + Integer.toString(nRows) 
                               		+ "c" + Integer.toString(i)%>
                                        <%=(rs.wasNull() ? " CHECKED " : "")%>  <%=readOnly%> 
                                >                                                  
<% 
              		} // default:switch
	          } 
        }
		// W_20151211_28 END: Null indicator check boxes wrap in result set columns. Specified NOWRAP for table cells. 
		// W_B_20161230_62 END

%>
		       </TD>
         </TR> 
    <% } %>

     </tbody>      
</TABLE>
<TABLE>
<TR>
<TD>
<% 
     // Display buttons only for the firstresult.
     if (stmtNo == 0) { 
%>
<%@include file="ss_results_buttons.jsp" %>
<% 
     } 
%>
</TD>
</TR>
<% 
               rs.close(); 

               if (nRows >= maxRowLimit) {
                    msg = "Warning: There are more rows than retrived in the resultset of the table/SQL statement. " +
                    "Increase maximum row limit if you want to retrive more rows. ";
%>
<TR><TD><P STYLE="COLOR:RED;"><%=msg%></P></TD></TR>
                    <SCRIPT LANGUAGE="JavaScript">
                        alert("<%=msg%>");
                    </SCRIPT>
<%
                }
            }  // end of else of if (prepStmt.execute()... 
           
            /* Get o/p parameters for callable stmts. */
            if (isCallStmt) {
                out.print("<TR><TD STYLE=\"FONT-SIZE:14pt;FONT-WEIGHT:BOLD;\">" +
                      "Output (OUT/INOUT/RETURN) Parameter Values</TD></TR>"); 
                out.print("<TR><TD><TABLE BORDER=1><TR><TH>Parameter #</TH><TH>Type</TH><TH>Value</TH></TR>");
                markerNo = 0;
                boolean outputArgsExist = false;
                for (int k = 1; k <= nParams; ++k) {
                     param = paramList.get(k-1);
                     switch (param.getParamInOutType()) {
                     case DatabaseMetaData.procedureColumnOut:
                         strVal = callStmt.getString(k);
                         if (callStmt.wasNull()) strVal = "NULL";
                         out.print("<TR><TD>" + (++markerNo) + "<TD>OUT</TD><TD>" + 
                                 strVal + "</TD></TR>");
                         outputArgsExist = true;
                         break;
                     case DatabaseMetaData.procedureColumnReturn:
                         strVal = callStmt.getString(k);
                         if (callStmt.wasNull()) strVal = "NULL";
                         out.print("<TR><TD>" + (++markerNo) +"<TD>RETURN</TD><TD>" + 
                                 strVal + "</TD></TR>");
                         outputArgsExist = true;
                         break;
                     case DatabaseMetaData.procedureColumnInOut:
                         strVal = callStmt.getString(k);
                         if (callStmt.wasNull()) strVal = "NULL";
                         out.print("<TR><TD>" + (++markerNo) +"<TD>INOUT</TD><TD>" + 
                                 strVal + "</TD></TR>");
                         outputArgsExist = true;
                         break;
                     }
                }
                if (outputArgsExist == false) {
                    out.print("<TR><TD COLSPAN=3 STYLE=\"COLOR:BLUE;FONT-STYLE:ITALIC;\">" +
                      "No OUT/INOUT/RETURN parameters exist for the procedure.</TD><TR>"); 
                }
                out.print("</TABLE></TR></TD>");
            }
%>
<TR><TD><HR><TD></TR> 
<%
        // connX.commit();
    } catch (java.sql.SQLException se) { 
%>
<TR><TD STYLE="COLOR:RED;">Error: Could not execute the statement.<TD></TR> 
<TR><TD STYLE="COLOR:BLUE;">[<%=se.toString()%>]<TD></TR> 
<%
        /*
         * Oracle gives warning if procedure can not be compiled.
         * But errors are stored in a table user_errors. 
         * Hence get the errors and display them.
         */
        String sqlstate = se.getSQLState();
        if (sqlstate != null && sqlstate.equals("WARNING") && dbmsName.equals(DBMS_ORACLE)) {
             stmtStr = "SELECT attribute, line, position, text " +
                       " FROM user_errors " +
                       " WHERE LOWER(name) LIKE '" + nameProcFunc.toLowerCase() + "%'" +
                       " ORDER BY sequence ";
             /* DEBUG:
               out.print("<BR>" + stmtStr);
              */

             try {
                 prepStmt =  connX.prepareStatement(stmtStr);
                 rs = prepStmt.executeQuery();
                 while (rs != null && rs.next()) {
                     out.print("<TR><TD STYLE=\"COLOR:BLUE;\">" + rs.getString(1) + 
                           "(Line " +  rs.getString(2) +
                           ", Position " + rs.getString(3) +
                           "): " + rs.getString(4) + "</TD></TR>");
                 } 
                 if (rs != null) rs.close();
                 if (prepStmt != null) prepStmt.close();
             } catch(SQLException se1) {
                 // Ignore error for the timebeing!
                 out.print("<BR>" + se1.toString());
             }
        }
%>
        <SCRIPT Language="JavaScript">
	    displayMessage("Error", "<%=se.getSQLState()%>", 
	         "<%=StringOps.xForm4JS(se.toString())%>"); 
	 </SCRIPT>

<%
    		} // catch	   
	} // For each stmt.
%>
</TABLE>



<%-- The following functions have to be below above selection code --%>
<%-- because the functions depend on Rows variable which will be set --%>
<%-- by above code. --%>

<SCRIPT LANGUAGE="JavaScript">

function select_rows(form, stmt_no)
{
    var max_rows = 0;
    var stmt = "";

    max_rows = parseInt(form.max_row_limit.value);
    stmt = form.elements["sqlstmt" + stmt_no].value;
       

    /* Strip brackted comments */
    stmt = stmt.replace(/(\/\*([\s\S]*?)\*\/)/gm, " ");
    
    // Strip // comments
    stmt = stmt.replace(/(\/\/.*$)/gm, " ");

    // Strip -- comments
    stmt = stmt.replace(/(--.*$)/gm, " ");

    
    // Replace new line chars with spaces.
    stmt = stmt.replace(/\n/gm, " ");

    if (max_rows > <%=DEF_MAX_ROW_LIMIT%>) {
        if (confirm("Maximum row limit [" + max_rows + "] is too high.\n\n" +
                     "Your browser may hang if too many rows are to be displayed.\n\n" +
                     "It is suggested you quit and choose a small number and reexecute the SQLstatement " +
                     "or choose required table.")) {
           return;
        }
    }
    form.sqlstmt.value = stmt;
    form.action = "../wji_sqlstmts/ss_results.jsp?conn_no=<%=connNo%>";
    form.target = "_self";
    form.submit();
}

function validate_max_row_limit(form)
{
   var rl_str = "";
   var rl = 0;

   rl_str = form.max_row_limit.value;
   if (is_num(rl_str) == false) {
       alert("Error: Entered number for maximum row limit is not a number; enter a valid number.");
       return;
   }
   rl = parseInt(rl_str);
   if (rl < 0) {
       alert("Error: Entered number for maximum row limit is not a positive number; please enter a positive number.");
       return;
   }
}


function validate_max_col_size(form)
{
   var str = "";
   var sz = 0;

   str = form.max_col_size.value;
   if (is_num(str) == false) {
       alert("Error: Entered maximum column size is not a number; enter a valid number.");
       return;
   }
   sz = parseInt(str);
   if (sz < 0) {
       alert("Error: Entered number of maximum columns size is not a positive number; please enter a positive number.");
       return;
   }
}


function insert_rows(form)
{
    var sch = "<%=(schemaName == null ? "" : schemaName)%>";
    var tbl = "<%=(tableName == null ? "" : tableName)%>";
    var sel_row_no = 0;


    sel_row_no = get_selected_row(form, "v", 0, <%=nRows%>);

    form.action = "../wji_sqlstmts/ss_results.jsp?oper=insert&schema_name=" + sch + "&table_name=" + tbl 
              + "&max_row_limit=<%=maxRowLimit%>&max_col_size=<%=maxColSize%>&sqlstmt=<%=sqlStmt%>"
              + "&sel_row_no=" + sel_row_no
		      + "&conn_no=<%=connNo%>"
              ;
    //  alert(form.action);
    form.target = "_self";
    form.submit();
}


function update_rows(form)
{
    var sch = "<%=(schemaName == null ? "" : schemaName)%>";
    var tbl = "<%=(tableName == null ? "" : tableName)%>";
    var sel_row_no = 0;


    sel_row_no = get_selected_row(form, "v", 0, <%=nRows%>);
    if (sel_row_no == 0) {
        alert("Error: You have not selected any row for update.");
        return;
    }

    form.action = "../wji_sqlstmts/ss_results.jsp?oper=update&schema_name=" + sch + "&table_name=" + tbl 
              + "&max_row_limit=<%=maxRowLimit%>&max_col_size=<%=maxColSize%>&sqlstmt=<%=sqlStmt%>"
              + "&sel_row_no=" + sel_row_no
		      + "&conn_no=<%=connNo%>"
              ;
    //  alert(form.action);
    form.target = "_self";
    form.submit();
}

function delete_rows(form)
{
    var sch = "<%=(schemaName == null ? "" : schemaName)%>";
    var tbl = "<%=(tableName == null ? "" : tableName)%>";
    var sel_row_no = 0;


    sel_row_no = get_selected_row(form, "v", 0, <%=nRows%>);
    if (sel_row_no == 0) {
        alert("Error: You have not selected any row for deletion.");
        return;
    }

    form.action = "../wji_sqlstmts/ss_results.jsp?oper=delete&schema_name=" + sch + "&table_name=" + tbl 
              + "&max_row_limit=<%=maxRowLimit%>&max_col_size=<%=maxColSize%>&sqlstmt=<%=sqlStmt%>"
              + "&sel_row_no=" + sel_row_no
		      + "&conn_no=<%=connNo%>"
              ;
    // alert(form.action);
    form.target = "_self";
    form.submit();
}

function delete_all_rows(form)
{
    var sch = "<%=(schemaName == null ? "" : schemaName)%>";
    var tbl = "<%=(tableName == null ? "" : tableName)%>";
    var sel_row_no = 0;

    form.action = "../wji_sqlstmts/ss_results.jsp?oper=delete_all&schema_name=" + sch + "&table_name=" + tbl 
              + "&max_row_limit=<%=maxRowLimit%>&max_col_size=<%=maxColSize%>&sqlstmt=<%=sqlStmt%>"
              + "&sel_row_no=" + sel_row_no
		      + "&conn_no=<%=connNo%>"
              ;
    // alert(form.action);
    form.target = "_self";
    form.submit();
}



function save_rows(form)
{
    var sch = "<%=(schemaName ==  null ? "" : schemaName)%>";
    var tbl = "<%=(tableName == null ? "" : tableName)%>";

    if ("<%=oper%>" == "insert") {
    	form.action = "../wji_tables/tbl_data_insert.jsp?schema_name=" + sch 
    					+ "&table_name=" + tbl 
    					+ "&noofrows=1&noofcolumns=<%=nCols%>&conn_no=<%=connNo%>&sqlstmt=<%=sqlStmt%>"
    			        + "&conn_no=<%=connNo%>"
    					;

    } else if ("<%=oper%>" == "update") {
        form.action = "../wji_tables/tbl_data_update.jsp?schema_name=" + sch 
        				+ "&table_name=" + tbl 
        				+ "&noofrows=<%=nRows%>&noofcolumns=<%=nCols%>&conn_no=<%=connNo%>"
    			        + "&conn_no=<%=connNo%>"
        				;
    } else if ("<%=oper%>" == "delete") {
        if (confirm("Confirm for deletion.")) { 
    		form.action = "../wji_tables/tbl_data_delete.jsp?schema_name=" + sch 
    					+ "&table_name=" + tbl 
    					+ "&noofrows=<%=nRows%>&noofcolumns=<%=nCols%>&conn_no=<%=connNo%>";
        } else {
            form.action = "../wji_sqlstmts/ss_results.jsp?oper=select&schema_name=" + sch + "&table_name=" + tbl 
            + "&max_row_limit=<%=maxRowLimit%>&max_col_size=<%=maxColSize%>&sqlstmt=<%=sqlStmt%>"
	        + "&conn_no=<%=connNo%>"            
            ;
        }
    } else if ("<%=oper%>" == "delete_all") {
        if (confirm("Action 'Delete All' will delete all rows from the table."
                + "\nDeleted data can not be retrieved once you confirm."
                + "\n\nConfirm or cancel the deletion.")) { 
    		form.action = "../wji_tables/tbl_data_delete_all.jsp?schema_name=" + sch 
    					+ "&table_name=" + tbl 
    					+ "&noofrows=<%=nRows%>&noofcolumns=<%=nCols%>&conn_no=<%=connNo%>";
        } else {
            form.action = "../wji_sqlstmts/ss_results.jsp?oper=select&schema_name=" + sch + "&table_name=" + tbl 
            + "&max_row_limit=<%=maxRowLimit%>&max_col_size=<%=maxColSize%>&sqlstmt=<%=sqlStmt%>"
	        + "&conn_no=<%=connNo%>"            
            ;
        }
    }
    // alert("save: " + form.action);
    form.target = "_self";
    form.submit();
}


function cancel_rows(form)
{
    var sch = "<%=(schemaName ==  null ? "" : schemaName)%>";
    var tbl = "<%=(tableName == null ? "" : tableName)%>";

    if ("<%=oper%>" != "select") {
        if (confirm("Warning: All your changes will be lost if you cancel.\n"  
                	+ "\nPlease confirm")) {
            form.action = "../wji_sqlstmts/ss_results.jsp?oper=select&schema_name=" + sch + "&table_name=" + tbl 
            			+ "&max_row_limit=<%=maxRowLimit%>&max_col_size=<%=maxColSize%>&sqlstmt=<%=sqlStmt%>"
            			;

            form.target = "_self";
            form.submit();
        } 
    } 
}

function clear_form(form)
{
    <% for (int i = 1; i <= nRows; ++i) { %>
        <% for (int j = 0; j <= nCols; ++j) { %>
            form.<%= "vr" + Integer.toString(i) + "c" + Integer.toString(j)%>.value="";
        <% } %>
    <% } %>
}

function clear_selection(form)
{
    <% for (int i = 1; i <= nRows; ++i) { %>
        if (form.<%= "vr" + Integer.toString(i) + "c0" %>.checked)
            form.<%= "vr" + Integer.toString(i) + "c0" %>.click();
    <% } %>
}
function go_back(form) {
    form.action = "../wji_browse/br_tblprop.jsp"
        + "?table_name=<%=tableName%>"
        + "&schema_name=<%=schemaName%>"
        + "&obj_type=<%=objType%>"
        + "&conn_no=<%=connNo%>"
        ;
    form.target = "_self";
    form.submit();
}

function display_help(form) {
    form.action = "../wji_help/he_results.jsp";
    form.target = "_blank";
    form.submit();
}

// Refresh left data frame for cases such as create or drop table. 
if (<%=connNo%> == 1) {
    ss_results_form.action = "../wji_transfer/tr_tbllist.jsp?conn_no=1";
    ss_results_form.target = "leftdatafr1";
} else if (<%=connNo%> == 2) {
    ss_results_form.action = "../wji_transfer/tr_tbllist.jsp?conn_no=2";
    ss_results_form.target = "leftdatafr2";
} else {
    if ("<%=nameProcFunc%>" == "") {
        ss_results_form.action = "../wji_browse/br_tbllist.jsp?conn_no=0";
    } else {
        ss_results_form.action = "../wji_browse/br_proclist.jsp?conn_no=0";
    }
    ss_results_form.target = "leftdatafr";
}
ss_results_form.submit();
</SCRIPT>
</FORM>
</BODY>
</HTML>



