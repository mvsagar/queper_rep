#
echo "-------------------------- TC 08/3.1 ----------------------"
echo "Sets up db."
echo ""
javac wji_080200_setup_db.java
java wji_080200_setup_db $WJI_URL 2> $TEST_DIR/wji_080200_setup_db.err
