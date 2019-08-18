#
echo "-------------------------- TC 08/3.10.1/3 ----------------------"
echo "Tests Cancellation of Update operation."
echo ""
javac wji_080317_cancel_update.java
java wji_080317_cancel_update $WJI_URL 2> $TEST_DIR/wji_080317_cancel_update.err