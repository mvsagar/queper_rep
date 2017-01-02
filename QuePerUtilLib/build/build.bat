call setup_path.bat
cd ..\src\com\queper\util\common
del *.class
javac *.java 
cd ..\db
del *.class
javac *.java
cd ..\tomcat
del *.class
javac *.java

cd ..\..\qpps\auth
del *.class
javac *.java 
cd ..\names
del *.class
javac *.java 
cd ..\schema
del *.class
javac *.java 

cd ..\..\..\..\

jar cvf ..\lib\queper_util.jar com\queper\util\common\*.class com\queper\util\db\*.class com\queper\util\tomcat\*.class

jar cvf ..\lib\queper_qpps.jar com\queper\qpps\auth\*.class com\queper\qpps\names\*.class com\queper\qpps\schema\*.class 

cd com\queper\tools
del *.class
javac LicManager.java
cd ..\..\..\
jar cvf ..\lib\queper_licmgr.jar com\queper\tools\*.class
cd %QueperLib%
copy lib\queper*.jar ..\QuePer\WebContent\WEB-INF\lib
cd %QueperLib%\build
