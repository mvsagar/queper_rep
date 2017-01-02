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
 --- Function:		Displays buttons to do various data operations on a database table. 
 -->
 
<%-- Buttons in a form that contains rows selected from a table. --%>
<INPUT TYPE=BUTTON VALUE="Select" STYLE="BACKGROUND:AQUA" ONCLICK="select_rows(this.form)">
<INPUT TYPE=BUTTON VALUE="Insert" STYLE="BACKGROUND:AQUA" ONCLICK="insert_rows(this.form)">
<INPUT TYPE=BUTTON VALUE="Update" STYLE="BACKGROUND:AQUA" ONCLICK="update_rows(this.form)">
<INPUT TYPE=BUTTON VALUE="Delete" STYLE="BACKGROUND:AQUA" ONCLICK="delete_rows(this.form)">
<INPUT TYPE=BUTTON VALUE="Clear Form" STYLE="BACKGROUND:ORANGERED" ONCLICK="clear_form(this.form)">
<INPUT TYPE=BUTTON VALUE="Clear row selection" STYLE="BACKGROUND:YELLOW" ONCLICK="clear_selection(this.form)">
