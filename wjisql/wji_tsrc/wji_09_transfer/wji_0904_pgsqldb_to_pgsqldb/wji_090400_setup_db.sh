#
echo "-------------------------- TC 09/4.1.1/1 ----------------------"
echo "Sets up pgsql destination db."
echo ""
javac ../wji_0900_common/wji_090000_setup_db.java
java -cp ../wji_0900_common:$CLASSPATH wji_090000_setup_db $WJI_URL pgsql 2> $TEST_DIR/wji_090400_setup_db.err
