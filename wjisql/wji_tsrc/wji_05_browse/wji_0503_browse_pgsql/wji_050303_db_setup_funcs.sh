#
echo "-------------------------- TC 05/4.2/3 ----------------------"
echo ""
javac wji_050303_db_setup_funcs.java
java wji_050303_db_setup_funcs $WJI_URL 2> $TEST_DIR/wji_050303_db_setup_funcs.err
