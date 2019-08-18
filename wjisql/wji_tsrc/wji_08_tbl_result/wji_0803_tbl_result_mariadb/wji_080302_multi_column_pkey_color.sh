#
echo "-------------------------- TC 08/3.2.1/2 ----------------------"
echo "Tests  multi-column primary key  color."
echo ""
javac wji_080302_multi_column_pkey_color.java
java wji_080302_multi_column_pkey_color $WJI_URL 2> $TEST_DIR/wji_080302_multi_column_pkey_color.err
