#
echo "-------------------------- TC 05/4.12 ----------------------"
echo "Tests procedure properties button 'Help'"
echo ""
javac wji_050314_proc_help.java
java wji_050314_proc_help $WJI_URL 2> $TEST_DIR/wji_050314_proc_help.err
