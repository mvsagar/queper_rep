# Using and Contributing to wjISQL

## What is wjISQL ?

wjISQL is an Internet browser based interactive SQL webapp tool that can be used to execute SQL statements and browse data in tables of databases managed by relational database management systems. The tool  can be used with any database management system that has a JDBC driver. It can work with any web server that supports Java Server Page(JSP)s and any browser that supports JavaScript.

## Getting wjISQL webapp

Either you can download ready to use webapp from website http://www.queper.in or build from the source of this repository. Read this README for further instructions on how to build and contribute to wjISQL.

## Requirements for building

1. JDK 1.7.x
2. Eclipse Juno or a later version with Git support
3. Tomcat 7.0.x
4. JDBC drivers of database management systems you want to work with

## Getting source

1. Click on the wjISQL repository queper_rep
2. Fork a copy of the repository
3. Start Eclipse
4. Import the repository through git (Use default actions)

## Building QuePer utility library

This library is a jar file needed for wjISQL.

1.  Select the following java packages of Eclipse project QuePerUtilLib:

	com.queper.util.common
	com.queper.util.db
	com.queper.util.tomcat

2.  Export them as jar file into lib directory with the following name

	queper_util.jar


## Build wjISQL

This step generates wjisql.war file for deploying in webserver such as 
Tomcat or any other webserver that supports JSP files.

1. Copy the QuePer utility library "queper_util.jar" that was built earlier 
   into the following directory of the Eclipse project wjISQL:

       WebContent/WEB-INF/lib 

2. Copy JDBC driver jar files of database management systems you want to work 
   with into the same lib folder.

3. Export the project as wjisql.jar file and make it available to webserver  
   such as Tomcat that supports JSP files.

4. Enter the URL `http://localhost:8080/wjisql/index.html` to start using 
   wjISQL. Replace host “localhost” and port number “8080” as per your 
   webserver requirements.

## Contributing

   You are welcome to contribute to wjISQL. You can add features, fix bugs,
   test with untested database management systems and write automated tests.
