#
echo "-------------------------- TC 05-3.2 1 and 3 ----------------------"
echo ""
javac wji_050102_db_setup_procs.java
java wji_050102_db_setup_procs $WJI_URL 2> $TEST_DIR/wji_050102_db_setup_procs.err
