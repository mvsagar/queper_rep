#
echo "-------------------------- TC 07/3.2.1/2 ----------------------"
echo "Tests limiting of rows to be displayed."
echo ""
javac wji_070302_row_limit.java
java wji_070302_row_limit $WJI_URL 2> $TEST_DIR/wji_070302_row_limit.err
