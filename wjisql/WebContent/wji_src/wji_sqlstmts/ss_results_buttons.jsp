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
 --- Function:		Displays buttons used in html frame used for result set. 
 -->
 
<TABLE>
<TR STYLE="BACKGROUND:LIGHTSEAGREEN;">
<TD>
<INPUT TYPE=BUTTON ID="btn-select-<%=stmtNo%>" VALUE="Select" STYLE="BACKGROUND:AQUA" 
       ONCLICK="select_rows(this.form, 0)">
</TD>

<% 
    if (tableName != null) { // Came from table list 
%>
<TD>
<INPUT TYPE=BUTTON ID="btn-insert-<%=stmtNo%>"  VALUE="Insert" STYLE="BACKGROUND:AQUA" 
    <%=(!oper.equals("select")  ? " DISABLED " : " " )%>
	ONCLICK="insert_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON ID="btn-update-<%=stmtNo%>" VALUE="Update" STYLE="BACKGROUND:AQUA" 
    <%=(!oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="update_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON ID="btn-delete-<%=stmtNo%>" VALUE="Delete" STYLE="BACKGROUND:ORANGERED;COLOR:WHITE;" 
    <%=(!oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="delete_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON ID="btn-deleteall-<%=stmtNo%>" VALUE="Delete All" STYLE="BACKGROUND:RED;COLOR:WHITE;" 
    <%=(!oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="delete_all_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON ID="btn-confirm-<%=stmtNo%>"  VALUE="Confirm" STYLE="BACKGROUND:AQUA" 
    <%=(oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="save_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON ID="btn-cancel-<%=stmtNo%>" VALUE="Cancel" STYLE="BACKGROUND:ORANGERED;COLOR:WHITE;" 
    <%=(oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="cancel_rows(this.form)">
</TD>
<!-- 
<TD>
<INPUT TYPE=BUTTON ID="btn-clear-<%=stmtNo%>"  VALUE="Clear rows" STYLE="BACKGROUND:WHITE" 
	ONCLICK="clear_form(this.form)">
</TD>
-->
<TD>
<INPUT TYPE=BUTTON ID="btn-clearrowsel-<%=stmtNo%>"  VALUE="Clear row selection" STYLE="BACKGROUND:WHITE" 
	ONCLICK="clear_selection(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON ID="btn-back-<%=stmtNo%>" VALUE="Back" STYLE="BACKGROUND:WHEAT" 
	ONCLICK="go_back(this.form)">
</TD>
<% } %>

<TD>
<INPUT TYPE=BUTTON ID="btn-help-<%=stmtNo%>"  VALUE="Help" STYLE="BACKGROUND:YELLOW" 
       ONCLICK="display_help(this.form)">
</TD>
</TR>
</TABLE>
