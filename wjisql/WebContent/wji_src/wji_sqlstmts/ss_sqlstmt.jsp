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
 --- Function:		Displays SQL statement window and buttons used to specify and execute
 ---				an SQL statement. 
 -->
 
<HTML>
<HEAD>
<TITLE>SQL Statement(s)</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
<script language="javaScript" type="text/javascript">
<%@include file="../wji_common/cmn_js_funcs.jsp" %>
</script>
</HEAD>	
<BODY>
<%@page contentType="text/html; charset=UTF-8"%>
<%-- Connect to the database --%>
<%@include file="../wji_common/connvars.jsp" %>


<FORM METHOD=POST>
	
<%@include file="ss_sqlstmt_buttons.jsp" %>

<%
	String paramStr = null;
	String scriptFile = null;
	String userSqlStmt =  "";

	// W_20161213_42 BEGIN: SQL script file
	paramStr = request.getParameter("script_file");
	if (paramStr != null) {
		scriptFile = paramStr;
	}
	// W_20161213_42 END: SQL script file
	paramStr = request.getParameter("user_sqlstmt");
	if (paramStr != null) {
		userSqlStmt = paramStr;
	}
	
%>
	
<!--Hidden field for stripped sql stmt. 
  -- Defined this hidden field as passing stmts on
  -- URL path does not work due to probably huge size of some stmt. 
-->
<INPUT TYPE=HIDDEN NAME="sqlstmt" VALUE=""> 

<TABLE>
<TR>
<TD><TEXTAREA NAME="user_sqlstmt" ID="user_sqlstmt" COLS=70 ROWS=5><%=userSqlStmt%></TEXTAREA></TD>
</TR>
<!-- W_20161213_42 BEGIN: SQL script file -->
<TR>
<TD>Script file:
<!-- Commented the following to avoid using NAME which will cause error: POST is missing and hence
  -- file will not be submitted.
<INPUT TYPE=FILE NAME="script_files" ID="script_files"  ONCHANGE="read_script_file()">
-->   
<INPUT TYPE=FILE ID="script_files"  ONCHANGE="read_script_file()">
</TD>
</TR>
<!-- W_20161213_42 END: SQL script file -->
<TABLE>

<SCRIPT LANGUAGE="JavaScript">

function getSelection() {
	/*
	return (!!document.getSelection) ? document.getSelection() :
	       (!!window.getSelection)   ? window.getSelection() :
	       document.selection.createRange().text;
	       */
    // obtain the object reference for the <textarea>
    var txtarea = document.getElementById("user_sqlstmt");
    // obtain the index of the first selected character
    var start = txtarea.selectionStart;
    // obtain the index of the last selected character
    var finish = txtarea.selectionEnd;
    // obtain the selected text
    var sel = txtarea.value.substring(start, finish);
    return sel;	       
}

function exec_stmt(form)
{
    var stmt = form.user_sqlstmt.value;
    
    var selectedStmt = "";

    // Get user selected stmt from text area.
    selectedStmt = getSelection();
    
    if (selectedStmt == null || selectedStmt == "") {
        stmt = form.user_sqlstmt.value;
    } else { 
    	stmt = selectedStmt;
    }
    //alert("stmt=[" + stmt + "]");

    
    /* Strip brackted comments */
    stmt = stmt.replace(/(\/\*([\s\S]*?)\*\/)/gm, " ");
    
    // Strip // comments
    stmt = stmt.replace(/(\/\/.*$)/gm, " ");

    // Strip -- comments
    stmt = stmt.replace(/(--.*$)/gm, " ");

    // Replace new line chars with spaces.
    stmt = stmt.replace(/\n/gm, " ");

    // document.write(stmt);
    
    form.sqlstmt.value = stmt;

    form.action = "ss_results.jsp";

    // alert(form.sqlstmt.value);
    form.target = "rightdatafr";
    form.submit();
}

function cancel_stmt(form)
{
    alert("Sorry. Operation not yet implemented.");
}

function clear_stmt(form)
{
	
    form.sqlstmt.value = "";
    // W_20161216_47 BEGIN: Clear button causes browser unresponsive.
    document.getElementById("user_sqlstmt").value = "";
    // W_20161216_47 END
    form.target ="rightdatafr";
    form.action = "ss_clear_results.jsp";
    form.submit();
    
}

function display_help(form) {
    form.action = "../wji_help/he_sqlstmt.jsp";
    form.target = "_blank";
    form.submit();
}

// W_20161213_42 BEGIN: SQL script file
/*
 * Read SQL script file into SQL statement window (form field: user_sqlstmt)
 */
function read_script_file() {
    var files = document.getElementById("script_files").files;
    if (!files.length) {
      	return;
    }
    
    var reader = new FileReader();
    var stmts = "";
    reader.onload = function (event) {
    	stmts = event.target.result;
      	document.getElementById("user_sqlstmt").value = stmts;
    }
    reader.readAsText(files[0]);
}
//W_20161213_42 END: SQL script file

</SCRIPT>

</FORM>
</BODY>
</HTML>

