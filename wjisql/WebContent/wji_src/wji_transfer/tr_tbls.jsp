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
 --- Function:		Displays table list in separate frames for source (frame "leftdatafr1") and 
 ---				destination database (frame "leftdatafr2") 
 -->

<HTML>
<FRAMESET COLS="*, 50%">
    <FRAME SRC="../wji_transfer/tr_tbllist.jsp?conn_no=1" NAME="leftdatafr1">
    <FRAME SRC="../wji_transfer/tr_tbllist.jsp?conn_no=2" NAME="leftdatafr2">
</FRAMESET>

</HTML>
