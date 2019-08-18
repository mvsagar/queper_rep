#
echo "-------------------------- TC 08/3.10.1/4 ----------------------"
echo "Tests Cancellation of Cancellation of Update operation."
echo ""
javac wji_080218_cancel_update_cancel.java
java wji_080218_cancel_update_cancel $WJI_URL 2> $TEST_DIR/wji_080218_cancel_update_cancel.err