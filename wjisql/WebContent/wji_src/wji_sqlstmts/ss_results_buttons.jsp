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
<INPUT TYPE=BUTTON VALUE="Select" STYLE="BACKGROUND:AQUA" ONCLICK="select_rows(this.form, 0)">
</TD>

<% 
    if (tableName != null) { // Came from table list 
%>
<TD>
<INPUT TYPE=BUTTON VALUE="Insert" STYLE="BACKGROUND:AQUA" 
    <%=(!oper.equals("select")  ? " DISABLED " : " " )%>
	ONCLICK="insert_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON VALUE="Update" STYLE="BACKGROUND:AQUA" 
    <%=(!oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="update_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON VALUE="Delete" STYLE="BACKGROUND:ORANGERED;" 
    <%=(!oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="delete_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON VALUE="Delete All" STYLE="BACKGROUND:RED;" 
    <%=(!oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="delete_all_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON VALUE="Confirm" STYLE="BACKGROUND:AQUA" 
    <%=(oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="save_rows(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON VALUE="Cancel" STYLE="BACKGROUND:ORANGERED;" 
    <%=(oper.equals("select") ? " DISABLED " : " " )%>
	ONCLICK="cancel_rows(this.form)">
</TD>
<!-- 
<TD>
<INPUT TYPE=BUTTON VALUE="Clear rows" STYLE="BACKGROUND:WHITE" 
	ONCLICK="clear_form(this.form)">
</TD>
-->
<TD>
<INPUT TYPE=BUTTON VALUE="Clear row selection" STYLE="BACKGROUND:WHITE" 
	ONCLICK="clear_selection(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON VALUE="Back" STYLE="BACKGROUND:WHEAT" 
	ONCLICK="go_back(this.form)">
</TD>
<% } %>

<TD>
<INPUT TYPE=BUTTON VALUE="Help" STYLE="BACKGROUND:YELLOW" ONCLICK="display_help(this.form)">
</TD>
</TR>
</TABLE>
