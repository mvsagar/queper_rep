#
echo "-------------------------- TC 09/3.3.2/1 ----------------------"
echo "Tests failure of transfer on no destination table"
echo ""
javac ../wji_0900_common/wji_090003_fail_on_no_dest_tbl.java
java -cp ../wji_0900_common:$CLASSPATH wji_090003_fail_on_no_dest_tbl $WJI_URL pgsql 2> $TEST_DIR/wji_090203_fail_on_no_dest_tbl.err
