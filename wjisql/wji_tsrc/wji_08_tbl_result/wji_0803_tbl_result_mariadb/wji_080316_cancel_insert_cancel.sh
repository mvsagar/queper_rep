#
echo "-------------------------- TC 08/3.10.1/2 ----------------------"
echo "Tests Cancellation of Cancellation of Insert operation."
echo ""
javac wji_080316_cancel_insert_cancel.java
java wji_080316_cancel_insert_cancel $WJI_URL 2> $TEST_DIR/wji_080316_cancel_insert_cancel.err