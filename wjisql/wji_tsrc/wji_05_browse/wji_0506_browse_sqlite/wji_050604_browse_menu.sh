#
echo "-------------------------- TC 05/7.3.1/1 ----------------------"
echo "Tests Browse menu item"
echo ""
javac wji_050604_browse_menu.java
java wji_050604_browse_menu $WJI_URL 2> $TEST_DIR/wji_050604_browse_menu.err
