#
echo "-------------------------- TC 08/3.10.1/1 ----------------------"
echo "Tests Cancellation of Insert operation."
echo ""
javac wji_080215_cancel_insert.java
java wji_080215_cancel_insert $WJI_URL 2> $TEST_DIR/wji_080215_cancel_insert.err