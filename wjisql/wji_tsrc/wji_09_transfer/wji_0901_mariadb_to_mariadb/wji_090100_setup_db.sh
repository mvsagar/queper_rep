#
echo "-------------------------- TC 09/3.2.1/1 ----------------------"
echo "Sets up db."
echo ""
javac ../wji_0900_common/wji_090000_setup_db.java
java -cp ../wji_0900_common:$CLASSPATH wji_090000_setup_db $WJI_URL mariadb 2> $TEST_DIR/wji_090100_setup_db.err
