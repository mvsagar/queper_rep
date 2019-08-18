#
# ------------------------------ TC 01-2.1/3 ----------------------------------
echo ""
echo " Test invoking wjISQL in Firefox browser"
echo ""
javac wji_0103_invoke_in_firefox.java
java wji_0103_invoke_in_firefox $WJI_URL 2> $TEST_DIR/wji_0103_invoke_in_firefox.err
