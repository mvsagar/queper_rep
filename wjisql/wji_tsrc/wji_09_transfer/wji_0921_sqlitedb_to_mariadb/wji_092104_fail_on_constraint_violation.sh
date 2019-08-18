#
echo "-------------------------- TC 09/7.2.2/2 ----------------------"
echo "Tests failure of transfer on constraint violation"
echo ""
javac ../wji_0900_common/wji_090004_fail_on_constraint_violation.java
java -cp ../wji_0900_common:$CLASSPATH wji_090004_fail_on_constraint_violation $WJI_URL mariadb 2> $TEST_DIR/wji_092104_fail_on_constraint_violation.err
