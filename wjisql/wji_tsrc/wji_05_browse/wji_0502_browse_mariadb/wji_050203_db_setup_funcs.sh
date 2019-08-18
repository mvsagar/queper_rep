#
echo "-------------------------- TC 05/3.2/4 ----------------------"
echo ""
javac wji_050203_db_setup_funcs.java
java wji_050203_db_setup_funcs $WJI_URL 2> $TEST_DIR/wji_050203_db_setup_funcs.err
