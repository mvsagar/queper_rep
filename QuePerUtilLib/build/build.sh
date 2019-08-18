export QUEPER_UTIL_LIB_HOME=$HOME/projects/git/repos/queper_rep/QuePerUtilLib
export QUEPER_EXTERNAL_LIB_HOME=$HOME/projects/git/report/queper_rep/QuePerUtilLib/lib_ext
export CLASSPATH=$JAVA_HOME/jre/lib/rt.jar:$QUEPER_EXTERNAL_LIB_HOME/servlet-api.jar:$QUEPER_EXTERNAL_LIB_HOME/commons-fileupload-1.3.jar:$QUEPER_EXTERNAL_LIB_HOME/commons-io-2.4.jar:$CLASSPATH:$QUEPER_UTIL_LIB_HOME/bin

find $QUEPER_UTIL_LIB_HOME/bin -name "*.class" | xargs rm -vf

javac -d $QUEPER_UTIL_LIB_HOME/bin \
    $QUEPER_UTIL_LIB_HOME/src/com/queper/util/db/*.java \
    $QUEPER_UTIL_LIB_HOME/src/com/queper/util/common/*.java \
    $QUEPER_UTIL_LIB_HOME/src/com/queper/util/tomcat/*.java 


cd $QUEPER_UTIL_LIB_HOME/bin
jar cvf $QUEPER_UTIL_LIB_HOME/lib/queper_util.jar \
	./com/queper/util/common/*.class \
	./com/queper/util/db/*.class \
	./com/queper/util/tomcat/*.class

#cd  $QUEPER_UTIL_LIB_HOME
#cp -v lib/queper*.jar ../QuePer/WebContent/WEB-INF/lib
#cp -v lib/queper*.jar ../QuePerLib/lib
#cp -v lib/queper*.jar ../wjisql/WebContent/WEB-INF/lib
#cd  $QUEPER_UTIL_LIB_HOME/build
