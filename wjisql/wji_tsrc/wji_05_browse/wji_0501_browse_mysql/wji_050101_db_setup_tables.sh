#
echo "-------------------------- TC 05-3.2 1 and 2 ----------------------"
echo "Logs into database for db setup"
echo ""
javac wji_050101_db_setup_tables.java
java wji_050101_db_setup_tables $WJI_URL 2> $TEST_DIR/wji_050101_db_setup_tables.err
