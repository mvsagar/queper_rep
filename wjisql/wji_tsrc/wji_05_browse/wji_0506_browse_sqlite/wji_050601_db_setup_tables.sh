#
echo "-------------------------- TC 05-7.2 1 and 2 ----------------------"
echo "Database setup"
echo ""
javac wji_050601_db_setup_tables.java
java wji_050601_db_setup_tables $WJI_URL 2> $TEST_DIR/wji_050601_db_setup_tables.err
