<!-- 
     Copyright 2006-2019 Vidyasagar Mundroy

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
 --- Function: Displays chapter 2 of user's guide. 
 -->
 
<HTML>

<HEAD><TITLE>Chapter 2. Requirements</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>

<BODY bgcolor="#ffffff">

<%@include file="he_title.jsp"%>
<HR>

<A HREF="ug_toc.jsp">Table of Contents</A>

<BR>

<H2><U>Chapter 2. Requirements</U></H2>


<A NAME="oview"><H3>2.1 Overview</H3></A>

<P>This chapter tells you about required software that you should have on
your computer system (PC/laptop) to use <B>wjISQL</B>. 
</P>

<P>In addition to operating system, you need JRE or JDK, Tomcat web server, 
required database management systems you want to use and JDBC drivers for
the database management systems in order to use <B>wjISQL</B>.
</P>

<P>The next sub-sections list each piece of software required along with
version of the software. <B>wjISQL</B> may work with older or later versions
of the software but not tested with them.
</P>


<A NAME="swreq"><H3>2.2 Basic Software</H3></A>

<P>You need the software as mentioned in the following table installed
on your computer system before you can use <B>wjISQL</B>:
</P>

<%@include file="../wji_help/he_req_sw.html" %>


<A NAME="dbms"><H3>2.3 Database Management Systems</H3></A>

<%@include file="../wji_help/he_req_dbms.html" %>


<A NAME="jdbc"><H3>2.4 JDBC Drivers</H3></A>

<%@include file="../wji_help/he_req_jdbc.html" %>

<A NAME="setup"><H3>2.5 Setting Up JDBC Drivers</H3></A>

<P>It is easy to setup a JDBC driver to connect to a database using 
<B>wjISQL</B>. Here are the steps:
<OL>
<LI>First, you identify, locate and download the JDBC driver file for 
the database 
management system you want to use. Almost all JDBC driver files will have 
<B>.jar</B> 
as file name extension as shown in the table of previous section. 
<BR><BR>
If you do not have the database management system itself  available on 
your PC or on a computer in your LAN setup, then first you have to install 
the database management system itself and find out its JDBC driver file.
<BR><BR>

<LI>Make the JDBC driver file available to Tomcat web server by copying
the jar file into "webapps/wjisql/WEB-INF/lib" directory of Tomcat installation
directory.  

<BR><BR>

<LI> <B>Restart</B> Tomcat service using Windows Services program or 
using programs/shell scripts of Tomcat itself.
</OL>

<P>Once these steps are executed, the JDBC driver is ready to be used.</P>


<A HREF="ug_toc.jsp">Table of Contents</A>

<HR>

<%@include file="../wji_common/cmn_copyright.jsp"%>

</BODY>
</HTML>
