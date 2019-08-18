#
echo "-------------------------- TC 08/3.4.1/1 ----------------------"
echo "Tests successful update of data"
echo ""
javac wji_080305_update_success.java
java wji_080305_update_success $WJI_URL 2> $TEST_DIR/wji_080305_update_success.err
