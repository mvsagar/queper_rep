#
echo "-------------------------- TC 10/4.2.1/1 ----------------------"
echo "Tests menu item DBMS Info."
javac ../wji_1000_common/wji_100001_dbmsinfo.java
java -cp ../wji_1000_common:$CLASSPATH wji_100001_dbmsinfo $WJI_URL 2> $TEST_DIR/wji_100401_dbmsinfo.err
