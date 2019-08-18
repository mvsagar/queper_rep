#
echo "-------------------------- TC 09/7.1.2/2 ----------------------"
echo "Tests transfer of all tables."
echo ""
javac ../wji_0900_common/wji_090001_all_tbls.java
java -cp ../wji_0900_common:$CLASSPATH wji_090001_all_tbls $WJI_URL mariadb 2> $TEST_DIR/wji_092101_all_tbls.err
