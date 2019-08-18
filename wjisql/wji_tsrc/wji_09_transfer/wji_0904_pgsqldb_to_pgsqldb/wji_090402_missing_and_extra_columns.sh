#
echo "-------------------------- TC 09/4.1.1/3 ----------------------"
echo "Tests transfer of data to table with some missing and some extra columns"
echo ""
javac ../wji_0900_common/wji_090002_missing_and_extra_columns.java
java -cp ../wji_0900_common:$CLASSPATH wji_090002_missing_and_extra_columns $WJI_URL pgsql 2> $TEST_DIR/wji_090402_missing_and_extra_columns.err
