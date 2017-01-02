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
 --- Function: Displays buttons to display details (properties) of  procedures/functions.  
 -->
<TABLE WIDTH="100%">

<TR STYLE="BACKGROUND:LIGHTSTEELBLUE;">

<TD ALIGN=LEFT STYLE="FONT-SIZE:14pt;FONT-WEIGHT:BOLD;">Procedure/Function: <SPAN STYLE="FONT-SIZE:14pt;FONT-WEIGHT:BOLD;COLOR:BLUE;"><%=procName%></SPAN></TD>

<TD ALIGN=RIGHT>
<TABLE>
<TR>
<TD>
<INPUT TYPE=BUTTON VALUE="Drop" ONCLICK="drop_proc(this.form)">
</TD>
<TD>
<INPUT TYPE=BUTTON VALUE="Help" 
	STYLE="BACKGROUND:WHITE; BORDER-STYLE:NONE" 
	ONCLICK="display_help(this.form)">
</TD>

</TR>
</TABLE>

</TD>
</TR>
</TABLE>
