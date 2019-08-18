#
echo "-------------------------- TC 07/3.1 ----------------------"
echo "Sets up db."
echo ""
javac wji_070300_setup_db.java
java wji_070300_setup_db $WJI_URL 2> $TEST_DIR/wji_070300_setup_db.err
