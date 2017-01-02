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
 --- Function: Closes/disconnects database by invoking actual disconnection jsp in another frame. 
 -->
 
<HTML>
<HEAD>
<TITLE>wjISQL Disconnect</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>	
<FRAMESET ROWS="15%, *">
    <FRAME SRC="../wji_common/cmn_navi.jsp" NAME="navifr">
    <FRAMESET COLS="20%, *">
        <FRAME SRC="../wji_help/he_main.jsp" NAME="leftdatafr"> <!-- W_20161219_49 BEGIN -->
    	<FRAME SRC="../wji_login/dbdisconnect.jsp" NAME="rightdatafr">
    </FRAMESET>
</FRAMESET>

</HTML>
