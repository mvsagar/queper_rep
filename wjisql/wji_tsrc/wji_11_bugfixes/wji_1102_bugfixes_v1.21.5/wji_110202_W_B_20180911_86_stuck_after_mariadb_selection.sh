#
echo "-------------------------- TC 11/2.6/2 ----------------------"
echo "Tests fix for the bug W_B_20180911_86: wjISQL gets stuck after_mariadb selection in the login screen."
echo ""
javac wji_110202_W_B_20180911_86_stuck_after_mariadb_selection.java
java wji_110202_W_B_20180911_86_stuck_after_mariadb_selection $WJI_URL 2> $TEST_DIR/wji_110202_W_B_20180911_86_stuck_after_mariadb_selection.err
