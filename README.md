# Overview of Development of wjISQL

## Requirements

You need the following software:

1. JDK 1.7.x
2. Eclipse Juno or a later version.
3. Tomcat 7.6.x

## Get source

1. Click on the wjISQL repository queper_rep
2. Fork a copy of the repository
3. Start Eclipse
4. Import the repository through git. Use default actions.

## Build QuePer utility library

This library which is a jar file is needed for wjISQL.

1.  Select java packages of Eclipse project QuePerUtilLib as following:

	com.queper.util.common
	com.queper.util.db
	com.queper.util.tomcat

2.  Export them as jar file into lib directory with the following name

	queper_util.jar


## Build wjISQL

This step generates wjisql.war file for deploying in webserver such as 
Tomcat or any other webserver that supports JSP files.

1. Go to folder WebContent/WEB-INF/lib of Eclipse project wjisql.

2. Copy the following QuePer utility library that was built earlier 
   into the  lib directory.

   queper_util.jar

3. Copy JDBC driver jar files of database management systems you want to work 
   with into the same lib folder.

4. Export the project as wjisql.jar file and make it available to webserver  
   such as Tomcat that supports JSP files.

5. Enter the URL `http://localhost:8080/wjisql/index.html` to start using 
   wjISQL. Replace host “localhost” and port number “8080” as per your 
   webserver requirements.

