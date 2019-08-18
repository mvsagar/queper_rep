#
echo "-------------------------- TC 08/3.3.1/1 ----------------------"
echo "Tests successful insertion of data"
echo ""
javac wji_080203_insertion_success.java
java wji_080203_insertion_success $WJI_URL 2> $TEST_DIR/wji_080203_insertion_success.err
