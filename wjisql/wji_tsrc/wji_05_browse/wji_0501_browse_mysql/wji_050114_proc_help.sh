#
echo "-------------------------- TC 05/3.12.1/1 ----------------------"
echo "Tests procedure properties button 'Help'"
echo ""
javac wji_050114_proc_help.java
java wji_050114_proc_help $WJI_URL 2> $TEST_DIR/wji_050114_proc_help.err
