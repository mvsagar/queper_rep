#
echo "-------------------------- TC 05/3.3.1/1 ----------------------"
echo "Tests Browse menu item"
echo ""
javac wji_050204_browse_menu.java
java wji_050204_browse_menu $WJI_URL 2> $TEST_DIR/wji_050204_browse_menu.err
