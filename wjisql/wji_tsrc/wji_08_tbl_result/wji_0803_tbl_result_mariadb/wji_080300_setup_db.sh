#
echo "-------------------------- TC 08/3.1 ----------------------"
echo "Sets up db."
echo ""
javac wji_080300_setup_db.java
java wji_080300_setup_db $WJI_URL 2> $TEST_DIR/wji_080300_setup_db.err
