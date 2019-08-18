#
echo "-------------------------- TC 10/3.2.2/1 ----------------------"
echo "Tests failure of  menu item DBMS Info."
javac ../wji_1000_common/wji_100002_dbmsinfo_failure.java
java -cp ../wji_1000_common:$CLASSPATH wji_100002_dbmsinfo_failure $WJI_URL 2> $TEST_DIR/wji_100302_dbmsinfo_failure.err
