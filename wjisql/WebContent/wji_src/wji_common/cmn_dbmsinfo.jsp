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

<HTML>
<HEAD>
<TITLE>DBMS Info</TITLE>
<LINK REL="shortcut icon" HREF="../wji_images/wjilogo32.ico">
</HEAD>
<BODY>

<%@page import="com.queper.util.db.*"%>
<%@include file="../wji_login/dbconnect.jsp" %>


<%
  final int fld_size = 50;
  final String fld_style = "FONT:BOLD;";
  int sno = 0;
  int intVal = -1;

  java.sql.DatabaseMetaData dbmd; 

  try {
     dbmd = conn.getMetaData();
%>

<CENTER>
<P STYLE="<%=fld_style%>FONT-SIZE:14pt">Database Management System Information</P>

<B>Brief Information</B>
<TABLE BORDER="2" WIDTH="100%">

<TR>
<TD STYLE="<%=fld_style%>FONT-SIZE:14pt">Information type</TD>
<TD STYLE="<%=fld_style%>FONT-SIZE:14pt">Value</TD>
<TD STYLE="<%=fld_style%>FONT-SIZE:14pt">DatabaseMetaData method()</TD>
</TR>

<TR>
<TD>Database Product Name:</TD>
<TD><B><%=dbmd.getDatabaseProductName()%></B></TD>
<TD>getDatabaseProductName()</TD>
</TR>

<TR>
<TD>Database Product Version:</TD>
<TD><B><%=dbmd.getDatabaseProductVersion()%></B></TD>
<TD>getDatabaseProductVersion()</TD>
</TR>

<TR>
<TD>JDBC Driver Name:</TD>
<TD><B><%=dbmd.getDriverName()%></B></TD>
<TD>getDriverName()</TD>
</TR>

<TR>
<TD>JDBC Driver Version:</TD>
<TD><B><%=dbmd.getDriverVersion()%></B></TD>
<TD>getDriverVersion()</TD>
</TR>
</TABLE>

<BR>
<B>More Information</B>
<TABLE BORDER="2" WIDTH="100%">

<TR>
<TD STYLE="<%=fld_style%>FONT-SIZE:14pt">SNO</TD>
<TD STYLE="<%=fld_style%>FONT-SIZE:14pt">Information type</TD>
<TD STYLE="<%=fld_style%>FONT-SIZE:14pt;">Value</TD>
<TD STYLE="<%=fld_style%>FONT-SIZE:14pt">DatabaseMetaData method()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Are all procedures callable?:</TD>
<TD><B><%=dbmd.allProceduresAreCallable()%></B></TD>
<TD>allProceduresAreCallable()</TD>
</TR>



<TR>
<TD><%=++sno%></TD>
<TD>Are all tables selectable?:</TD>
<TD><B><%=dbmd.allTablesAreSelectable()%></B></TD>
<TD>allTablesAreSelectable()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Current URL used:</TD>
<TD STYLE="word-break:break-all;"><B><%=dbmd.getURL()%></B></TD>
<TD>getURL()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Current User:</TD>
<TD><B><%=dbmd.getUserName()%></B></TD>
<TD>getUserName()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Is current database READ ONLY?:</TD>
<TD><B><%=dbmd.isReadOnly()%></B></TD>
<TD>isReadOnly()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Are NULLs sorted HIGH?:</TD>
<TD><B><%=dbmd.nullsAreSortedHigh()%></B></TD>
<TD>nullsAreSortedHigh()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Are NULLs sorted LOW?:</TD>
<TD><B><%=dbmd.nullsAreSortedLow()%></B></TD>
<TD>nullsAreSortedLow()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Are NULLs sorted at START?:</TD>
<TD><B><%=dbmd.nullsAreSortedAtStart()%></B></TD>
<TD>nullsAreSortedAtStart()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Are NULLs sorted at END?:</TD>
<TD><B><%=dbmd.nullsAreSortedAtEnd()%></B></TD>
<TD>nullsAreSortedAtEnd()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Driver major version:</TD>
<TD><B><%=dbmd.getDriverMajorVersion()%></B></TD>
<TD>getDriverMajorVersion()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Driver minor version:</TD>
<TD><B><%=dbmd.getDriverMinorVersion()%></B></TD>
<TD>getDriverMinorVersion()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Does database stores tables in a local file?:</TD>
<TD><B><%=dbmd.usesLocalFiles()%></B></TD>
<TD>usesLocalFiles()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Does database uses a file for each table?:</TD>
<TD><B><%=dbmd.usesLocalFiles()%></B></TD>
<TD>usesLocalFiles()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Treats mixed case unquoted SQL identifiers as case SENSITIVE and as a result stores them in MIXED case?:</TD>
<TD><B><%=dbmd.supportsMixedCaseIdentifiers()%></B></TD>
<TD>supportsMixedCaseIdentifiers()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Treats mixed case unquoted SQL identifiers as case INSENSITIVE and stores them in UPPER case?:</TD>
<TD><B><%=dbmd.storesUpperCaseIdentifiers()%></B></TD>
<TD>storesUpperCaseIdentifiers()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Treats mixed case unquoted SQL identifiers as case INSENSITIVE and stores them in LOWER case?:</TD>
<TD><B><%=dbmd.storesLowerCaseIdentifiers()%></B></TD>
<TD>storesLowerCaseIdentifiers()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Treats mixed case unquoted SQL identifiers as case INSENSITIVE and stores them in MIXED case?:</TD>
<TD><B><%=dbmd.storesMixedCaseIdentifiers()%></B></TD>
<TD>storesMixedCaseIdentifiers()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Treats mixed case QUOTED SQL identifiers as case SENSITIVE and as a result stores them in MIXED case?:</TD>
<TD><B><%=dbmd.supportsMixedCaseQuotedIdentifiers()%></B></TD>
<TD>supportsMixedCaseQuotedIdentifiers()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Treats mixed case QUOTED SQL identifiers as case INSENSITIVE and stores them in UPPER case?:</TD>
<TD><B><%=dbmd.storesUpperCaseQuotedIdentifiers()%></B></TD>
<TD>storesUpperCaseQuotedIdentifiers()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Treats mixed case QUOTED SQL identifiers as case INSENSITIVE and stores them in LOWER case?:</TD>
<TD><B><%=dbmd.storesLowerCaseQuotedIdentifiers()%></B></TD>
<TD>storesLowerCaseQuotedIdentifiers()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Treats mixed case unquoted SQL identifiers as case INSENSITIVE and stores them in MIXED case?:</TD>
<TD><B><%=dbmd.storesMixedCaseIdentifiers()%></B></TD>
<TD>storesMixedCaseIdentifiers()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>String used to quoted SQL identifiers:</TD>
<TD><B><%=dbmd.getIdentifierQuoteString()%></B></TD>
<TD>getIdentifierQuoteString()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>List of database keywords Other than those in SQL92 standard:</TD>
<TD><B><%=dbmd.getSQLKeywords().replaceAll(",", ", ")%></B></TD>
<TD>getSQLKeywords()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>List of supported math functions:</TD>
<TD><B><%=dbmd.getNumericFunctions().replaceAll(",", ", ")%></B></TD>
<TD>getNumericFunctions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>List of supported string functions:</TD>
<TD><B><%=dbmd.getStringFunctions().replaceAll(",", ", ")%></B></TD>
<TD>getStringFunctions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>List of supported system functions:</TD>
<TD><B><%=dbmd.getSystemFunctions().replaceAll(",", ", ")%></B></TD>
<TD>getSystemFunctions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>List of supported time and date functions:</TD>
<TD><B><%=dbmd.getTimeDateFunctions().replaceAll(",", ", ")%></B></TD>
<TD>getTimeDateFunctions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>String that can be used to escape wildcard characters:</TD>
<TD><B><%=dbmd.getSearchStringEscape()%></B></TD>
<TD>getSearchStringEscape()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Extra characters that can be used in unquoted identifier names (those beyond a-z, A-Z, 0-9 and _):</TD>
<TD><B><%=dbmd.getExtraNameCharacters()%></B></TD>
<TD>getExtraNameCharacters()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports ALTER TABLE with ADD column?:</TD>
<TD><B><%=dbmd.supportsAlterTableWithAddColumn()%></B></TD>
<TD>supportsAlterTableWithAddColumn()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports ALTER TABLE with DROP column?:</TD>
<TD><B><%=dbmd.supportsAlterTableWithDropColumn()%></B></TD>
<TD>supportsAlterTableWithDropColumn()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports column aliasing?:</TD>
<TD><B><%=dbmd.supportsColumnAliasing()%></B></TD>
<TD>supportsColumnAliasing()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports concatenation between NULL and non-NULL to NULL?:</TD>
<TD><B><%=dbmd.nullPlusNonNullIsNull()%></B></TD>
<TD>nullPlusNonNullIsNull()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports the CONVERT function?:</TD>
<TD><B><%=dbmd.supportsConvert()%></B></TD>
<TD>supportsConvert()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports table correlation names?:</TD>
<TD><B><%=dbmd.supportsTableCorrelationNames()%></B></TD>
<TD>supportsTableCorrelationNames()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Should the table correlation names be different from the names of the tables?:</TD>
<TD><B><%=dbmd.supportsDifferentTableCorrelationNames()%></B></TD>
<TD>supportsDifferentTableCorrelationNames()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports expressions in ORDER BY?:</TD>
<TD><B><%=dbmd.supportsExpressionsInOrderBy()%></B></TD>
<TD>supportsExpressionsInOrderBy()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports using a column that is not in the SELECT statement in an ORDER BY clause?:</TD>
<TD><B><%=dbmd.supportsOrderByUnrelated()%></B></TD>
<TD>supportsOrderByUnrelated()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports expressions in GROUP BY?:</TD>
<TD><B><%=dbmd.supportsGroupBy()%></B></TD>
<TD>supportsGroupBy()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports using a column that is not in the SELECT statement in a GROUP BY clause?:</TD>
<TD><B><%=dbmd.supportsGroupByUnrelated()%></B></TD>
<TD>supportsGroupByUnrelated()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports using columns not included the SELECT statement in a GROUP BY clause provided that all of the columns in the SELECT statement are included in the GROUP BY clause?:</TD>
<TD><B><%=dbmd.supportsGroupByBeyondSelect()%></B></TD>
<TD>supportsGroupByBeyondSelect()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports LIKE escape clause?:</TD>
<TD><B><%=dbmd.supportsLikeEscapeClause()%></B></TD>
<TD>supportsLikeEscapeClause()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports getting multiple <CODE>ResultSet</CODE> objects from a single call to the method <CODE>execute</CODE>?:</TD>
<TD><B><%=dbmd.supportsLikeEscapeClause()%></B></TD>
<TD>supportsLikeEscapeClause()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports multiple transactions open at once (on different connections)?:</TD>
<TD><B><%=dbmd.supportsMultipleTransactions()%></B></TD>
<TD>supportsMultipleTransactions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports non-nullable columns?:</TD>
<TD><B><%=dbmd.supportsNonNullableColumns()%></B></TD>
<TD>supportsNonNullableColumns()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports the ODBC Minimum SQL grammar?:</TD>
<TD><B><%=dbmd.supportsMinimumSQLGrammar()%></B></TD>
<TD>supportsMinimumSQLGrammar()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports the ODBC Core SQL grammar?:</TD>
<TD><B><%=dbmd.supportsCoreSQLGrammar()%></B></TD>
<TD>supportsCoreSQLGrammar()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports the ODBC Extended SQL grammar?:</TD>
<TD><B><%=dbmd.supportsExtendedSQLGrammar()%></B></TD>
<TD>supportsExtendedSQLGrammar()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports the ANSI92 entry level SQL grammar?:</TD>
<TD><B><%=dbmd.supportsANSI92EntryLevelSQL()%></B></TD>
<TD>supportsANSI92EntryLevelSQL()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports the ANSI92 intermediate SQL grammar?:</TD>
<TD><B><%=dbmd.supportsANSI92IntermediateSQL()%></B></TD>
<TD>supportsANSI92IntermediateSQL()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports the ANSI92 full SQL grammar?:</TD>
<TD><B><%=dbmd.supportsANSI92FullSQL()%></B></TD>
<TD>supportsANSI92FullSQL()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports the SQL Integrity Enhancement Facility?:</TD>
<TD><B><%=dbmd.supportsIntegrityEnhancementFacility()%></B></TD>
<TD>supportsIntegrityEnhancementFacility()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports some form of outer join?:</TD>
<TD><B><%=dbmd.supportsOuterJoins()%></B></TD>
<TD>supportsOuterJoins()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports nested full outer joins?:</TD>
<TD><B><%=dbmd.supportsFullOuterJoins()%></B></TD>
<TD>supportsFullOuterJoins()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports limited outer joins?:</TD>
<TD><B><%=dbmd.supportsLimitedOuterJoins()%></B></TD>
<TD>supportsLimitedOuterJoins()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Vendor's preferred term for "schema":</TD>
<TD><B><%=dbmd.getSchemaTerm()%></B></TD>
<TD>getSchemaTerm()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Vendor's preferred term for "procedure":</TD>
<TD><B><%=dbmd.getProcedureTerm()%></B></TD>
<TD>getProcedureTerm()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Vendor's preferred term for "catalog":</TD>
<TD><B><%=dbmd.getCatalogTerm()%></B></TD>
<TD>getCatalogTerm()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Does catalog appears at the start of a fully qualified table name?:</TD>
<TD><B><%=dbmd.isCatalogAtStart()%></B></TD>
<TD>isCatalogAtStart()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Catalog separator:</TD>
<TD><B><%=dbmd.getCatalogSeparator()%></B></TD>
<TD>getCatalogSeparator()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports schema name in data manipulation statements?:</TD>
<TD><B><%=dbmd.supportsSchemasInDataManipulation()%></B></TD>
<TD>supportsSchemasInDataManipulation()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports schema name in procedure call statements?:</TD>
<TD><B><%=dbmd.supportsSchemasInProcedureCalls()%></B></TD>
<TD>supportsSchemasInProcedureCalls()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports schema name in table definition statements?:</TD>
<TD><B><%=dbmd.supportsSchemasInTableDefinitions()%></B></TD>
<TD>supportsSchemasInTableDefinitions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports schema name in index definition statements?:</TD>
<TD><B><%=dbmd.supportsSchemasInIndexDefinitions()%></B></TD>
<TD>supportsSchemasInIndexDefinitions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports schema name in privilege definition statements?:</TD>
<TD><B><%=dbmd.supportsSchemasInPrivilegeDefinitions()%></B></TD>
<TD>supportsSchemasInPrivilegeDefinitions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports catalog name in data manipulation statements?:</TD>
<TD><B><%=dbmd.supportsCatalogsInDataManipulation()%></B></TD>
<TD>supportsCatalogsInDataManipulation()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports catalog name in procedure call statements?:</TD>
<TD><B><%=dbmd.supportsCatalogsInProcedureCalls()%></B></TD>
<TD>supportsCatalogsInProcedureCalls()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports catalog name in table definition statements?:</TD>
<TD><B><%=dbmd.supportsCatalogsInTableDefinitions()%></B></TD>
<TD>supportsCatalogsInTableDefinitions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports catalog name in index definition statements?:</TD>
<TD><B><%=dbmd.supportsCatalogsInIndexDefinitions()%></B></TD>
<TD>supportsCatalogsInIndexDefinitions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports catalog name in privilege definition statements?:</TD>
<TD><B><%=dbmd.supportsCatalogsInPrivilegeDefinitions()%></B></TD>
<TD>supportsCatalogsInPrivilegeDefinitions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports positioned <CODE>DELETE<CODE> statements?:</TD>
<TD><B><%=dbmd.supportsPositionedDelete()%></B></TD>
<TD>supportsPositionedDelete()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports positioned <CODE>UPDATE<CODE> statements?:</TD>
<TD><B><%=dbmd.supportsPositionedUpdate()%></B></TD>
<TD>supportsPositionedUpdate()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports <CODE>SELECT FOR UPDATE<CODE> statements?:</TD>
<TD><B><%=dbmd.supportsSelectForUpdate()%></B></TD>
<TD>supportsSelectForUpdate()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports stored procedures?:</TD>
<TD><B><%=dbmd.supportsStoredProcedures()%></B></TD>
<TD>supportsStoredProcedures()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports subqueries in comparison expressions?:</TD>
<TD><B><%=dbmd.supportsSubqueriesInComparisons()%></B></TD>
<TD>supportsSubqueriesInComparisons()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports subqueries in <code>EXISTS</code> expressions?:</TD>
<TD><B><%=dbmd.supportsSubqueriesInExists()%></B></TD>
<TD>supportsSubqueriesInExists()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports subqueries in <code>IN</code> expressions?:</TD>
<TD><B><%=dbmd.supportsSubqueriesInIns()%></B></TD>
<TD>supportsSubqueriesInIns()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports subqueries in quantified expressions?:</TD>
<TD><B><%=dbmd.supportsSubqueriesInQuantifieds()%></B></TD>
<TD>supportsSubqueriesInQuantifieds()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports subqueries in correlated subqueries?:</TD>
<TD><B><%=dbmd.supportsCorrelatedSubqueries()%></B></TD>
<TD>supportsCorrelatedSubqueries()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports SQL <CODE>UNION</CODE>?:</TD>
<TD><B><%=dbmd.supportsUnion()%></B></TD>
<TD>supportsUnion()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports SQL <CODE>UNION ALL</CODE>?:</TD>
<TD><B><%=dbmd.supportsUnionAll()%></B></TD>
<TD>supportsUnionAll()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports keeping cursors open across commits?:</TD>
<TD><B><%=dbmd.supportsOpenCursorsAcrossCommit()%></B></TD>
<TD>supportsOpenCursorsAcrossCommit()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports keeping cursors open across rollbacks?:</TD>
<TD><B><%=dbmd.supportsOpenCursorsAcrossRollback()%></B></TD>
<TD>supportsOpenCursorsAcrossRollback()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports keeping statements open across commits?:</TD>
<TD><B><%=dbmd.supportsOpenStatementsAcrossCommit()%></B></TD>
<TD>supportsOpenStatementsAcrossCommit()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports keeping statements open across rollbacks?:</TD>
<TD><B><%=dbmd.supportsOpenStatementsAcrossRollback()%></B></TD>
<TD>supportsOpenStatementsAcrossRollback()</TD>
</TR>

<%------ Limits ---------%>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of hex characters allowed in an inline binary literal:</TD>
<TD><B><%=((intVal = dbmd.getMaxBinaryLiteralLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxBinaryLiteralLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of characters allowed for a character literal:</TD>
<TD><B><%=((intVal = dbmd.getMaxCharLiteralLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxCharLiteralLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of characters allowed for a column name:</TD>
<TD><B><%=((intVal = dbmd.getMaxColumnNameLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxColumnNameLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of columns allowed in <CODE>GROUP BY</CODE> clause:</TD>
<TD><B><%=((intVal = dbmd.getMaxColumnsInGroupBy()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxColumnsInGroupBy()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of columns allowed in an index:</TD>
<TD><B><%=((intVal = dbmd.getMaxColumnsInIndex()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxColumnsInIndex()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of columns allowed in an <CODE>ORDER BY</CODE> clause:</TD>
<TD><B><%=((intVal = dbmd.getMaxColumnsInOrderBy()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxColumnsInOrderBy()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of columns allowed in a <CODE>SELECT</CODE> list:</TD>
<TD><B><%=((intVal = dbmd.getMaxColumnsInSelect()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxColumnsInSelect()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of columns allowed in a table:</TD>
<TD><B><%=((intVal = dbmd.getMaxColumnsInTable()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxColumnsInTable()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of concurrant connections possible:</TD>
<TD><B><%=((intVal = dbmd.getMaxConnections()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxConnections()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum cursor name length:</TD>
<TD><B><%=((intVal = dbmd.getMaxCursorNameLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxCursorNameLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of bytes allowed in an index:</TD>
<TD><B><%=((intVal = dbmd.getMaxIndexLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxIndexLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of characters allowed in a schema name:</TD>
<TD><B><%=((intVal = dbmd.getMaxSchemaNameLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxSchemaNameLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of characters allowed in a procedure name:</TD>
<TD><B><%=((intVal = dbmd.getMaxProcedureNameLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxProcedureNameLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of characters allowed in a catalog name:</TD>
<TD><B><%=((intVal = dbmd.getMaxCatalogNameLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxCatalogNameLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of bytes allowed in a row:</TD>
<TD><B><%=((intVal = dbmd.getMaxRowSize()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxRowSize()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Do maximum number of bytes allowed in a row include SQL data types <CODE>LONGVARCHAR</CODE> and <CODE>LONGVARBINARY</CODE>:</TD>
<TD><B><%=dbmd.doesMaxRowSizeIncludeBlobs()%></B></TD>
<TD>doesMaxRowSizeIncludeBlobs()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of characters allowed in an SQL statement:</TD>
<TD><B><%=((intVal = dbmd.getMaxStatementLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxStatementLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of concurrent active open statements:</TD>
<TD><B><%=((intVal = dbmd.getMaxStatements()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxStatements()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of characters allowed in a table name:</TD>
<TD><B><%=((intVal = dbmd.getMaxTableNameLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxTableNameLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of tables allowed in a <code>SELECT</code> statement:</TD>
<TD><B><%=((intVal = dbmd.getMaxTablesInSelect()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxTablesInSelect()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The maximum number of characters allowed in a user name:</TD>
<TD><B><%=((intVal = dbmd.getMaxUserNameLength()) == 0 ? "0 (No limit or limit unknown)" : Integer.toString(intVal))%></B></TD>
<TD>getMaxUserNameLength()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Default transaction isolation level:</TD>
<TD><B><%=DbNames.getIsolationLevelName(dbmd.getDefaultTransactionIsolation())%></B></TD>
<TD>getDefaultTransactionIsolation()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports transactions?:</TD>
<TD><B><%=dbmd.supportsTransactions()%></B></TD>
<TD>supportsTransactions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports both data definition and data manipulation statements within a transaction?:</TD>
<TD><B><%=dbmd.supportsDataDefinitionAndDataManipulationTransactions()%></B></TD>
<TD>supportsDataDefinitionAndDataManipulationTransactions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports only data manipulation statements within a transaction?:</TD>
<TD><B><%=dbmd.supportsDataManipulationTransactionsOnly()%></B></TD>
<TD>supportsDataManipulationTransactionsOnly()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Does a data definition statement within a transaction forces the transaction to commit?:</TD>
<TD><B><%=dbmd.dataDefinitionCausesTransactionCommit()%></B></TD>
<TD>dataDefinitionCausesTransactionCommit()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Does a data definition statement ignored within a transaction?:</TD>
<TD><B><%=dbmd.dataDefinitionIgnoredInTransactions()%></B></TD>
<TD>dataDefinitionIgnoredInTransactions()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports save points?:</TD>
<TD><B><%=dbmd.supportsSavepoints()%></B></TD>
<TD>supportsSavepoints()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports named parameters?:</TD>
<TD><B><%=dbmd.supportsNamedParameters()%></B></TD>
<TD>supportsNamedParameters()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports multiple <CODE>ResultSet</CODE> objects returned from a <CODE>CallableStatement</CODE> object simultaneously?:</TD>
<TD><B><%=dbmd.supportsMultipleOpenResults()%></B></TD>
<TD>supportsMultipleOpenResults()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Can auto-generated keys be retrieved after a statement has been executed?:</TD>
<TD><B><%=dbmd.supportsGetGeneratedKeys()%></B></TD>
<TD>supportsGetGeneratedKeys()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>The default holdability of this <CODE>ResultSet</CODE> object:</TD>
<TD><B><%=dbmd.getResultSetHoldability()%></B></TD>
<TD>getResultSetHoldability()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Database major version</TD>
<TD><B><%=dbmd.getDatabaseMajorVersion()%></B></TD>
<TD>getDatabaseMajorVersion()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Database minor version</TD>
<TD><B><%=dbmd.getDatabaseMinorVersion()%></B></TD>
<TD>getDatabaseMinorVersion()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>JDBC major version</TD>
<TD><B><%=dbmd.getJDBCMajorVersion()%></B></TD>
<TD>getJDBCMajorVersion()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>JDBC minor version</TD>
<TD><B><%=dbmd.getJDBCMinorVersion()%></B></TD>
<TD>getJDBCMinorVersion()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>SQLSTATE returned by <CODE>SQLException.getSQLState</CODE> is X/Open (now known as Open Group) SQL CLI or SQL99:</TD>
<TD><B><%=((intVal = dbmd.getSQLStateType()) == 1 ? "1 (sqlStateXOpen)" : "2 (sqlStateSQL99)")%></B></TD>
<TD>getSQLStateType()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Do updates made to a LOB are made on a copy or directly  to the LOB?:</TD>
<TD><B><%=dbmd.locatorsUpdateCopy()%></B></TD>
<TD>locatorsUpdateCopy()</TD>
</TR>

<TR>
<TD><%=++sno%></TD>
<TD>Supports statement pooling?:</TD>
<TD><B><%=dbmd.supportsStatementPooling()%></B></TD>
<TD>supportsStatementPooling()</TD>
</TR>















<TABLE>

</CENTER>



<% 
  } catch (java.sql.SQLException se) { 
%>
<META http-equiv="refresh" content="0;url=../wji_error/er_display.jsp?sql_state=<%=se.getSQLState()%>&err_msg=<%=se.toString()%>"> 
<%
     return;
   }	   
%>

</BODY>
</HTML>

