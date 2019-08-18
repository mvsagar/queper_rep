#
echo "-------------------------- TC 09/4.3.3/1 ----------------------"
echo "Tests control going back to home screen from transfer screen."
echo ""
javac ../wji_0900_common/wji_090005_back_to_home_screen.java
java -cp ../wji_0900_common:$CLASSPATH wji_090005_back_to_home_screen $WJI_URL sqlite 2> $TEST_DIR/wji_090605_back_to_home_screen.err
