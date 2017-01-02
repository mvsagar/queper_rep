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
 --- Function:		Displays login windows(frames) for source and destination databases. 
 -->
 
<HTML>
<FRAMESET ROWS="*, 50%">
<!-- W_B_20161226_57 BEGIN: Login failure of source or destination database in transfer screen takes 
  -- control to a new tab instead of right data frame 1.
  -- Added correct target frame names.
  -->
    <FRAME SRC="../wji_login/dblogin.jsp?conn_no=1&targetfr_name=rightdatafr1" NAME="rightdatafr1">
    <FRAME SRC="../wji_login/dblogin.jsp?conn_no=2&targetfr_name=rightdatafr2" NAME="rightdatafr2">
<!-- W_B_20161226_57 END -->    
</FRAMESET>

</HTML>
