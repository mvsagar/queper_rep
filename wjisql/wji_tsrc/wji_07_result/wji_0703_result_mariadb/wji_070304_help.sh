#
echo "-------------------------- TC 07/3.2.1/4 ----------------------"
echo "Tests Help button of result frame."
echo ""
javac wji_070304_help.java
java wji_070304_help $WJI_URL 2> $TEST_DIR/wji_070304_help.err
