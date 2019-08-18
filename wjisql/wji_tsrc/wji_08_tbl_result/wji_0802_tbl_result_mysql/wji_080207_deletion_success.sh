#
echo "-------------------------- TC 08/3.5.1/1 ----------------------"
echo "Tests successful deletion of data"
echo ""
javac wji_080207_deletion_success.java
java wji_080207_deletion_success $WJI_URL 2> $TEST_DIR/wji_080207_deletion_success.err
