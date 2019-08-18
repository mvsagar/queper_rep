#
echo "-------------------------- TC 05/4.2/1,2 ----------------------"
echo "Database table setup"
echo ""
javac wji_050301_db_setup_tables.java
java wji_050301_db_setup_tables $WJI_URL 2> $TEST_DIR/wji_050301_db_setup_tables.err
