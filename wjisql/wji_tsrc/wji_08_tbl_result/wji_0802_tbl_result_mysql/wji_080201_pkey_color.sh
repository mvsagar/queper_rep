#
echo "-------------------------- TC 08/3.2.1/1 ----------------------"
echo "Tests  primary key column color."
echo ""
javac wji_080201_pkey_color.java
java wji_080201_pkey_color $WJI_URL 2> $TEST_DIR/wji_080201_pkey_color.err
