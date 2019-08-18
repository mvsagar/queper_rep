#
echo "-------------------------- TC 09/3.2.3/1 ----------------------"
echo "Tests control going back to home screen from transfer screen."
echo ""
javac ../wji_0900_common/wji_090005_back_to_home_screen.java
java  -cp ../wji_0900_common:$CLASSPATH wji_090005_back_to_home_screen $WJI_URL mariadb 2> $TEST_DIR/wji_090105_back_to_home_screen.err
