#
echo "-------------------------- TC 09/4.2.1/2 ----------------------"
echo "Tests transfer of all tables of a pgsql db to mariadb db."
echo ""
javac ../wji_0900_common/wji_090001_all_tbls.java
java -cp ../wji_0900_common:$CLASSPATH wji_090001_all_tbls $WJI_URL mariadb 2> $TEST_DIR/wji_090501_all_tbls.err
