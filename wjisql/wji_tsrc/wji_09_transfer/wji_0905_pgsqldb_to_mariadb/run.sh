curr_dir=`pwd`
. ../../setup.env
. ../../setup.pgsql
echo "1. Setting up database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0503_browse_pgsql
run_tests.sh pgsqlusr pgsql123 pgsqldb test_list_dbsetup.txt
cd $curr_dir

# For tests to test transfer from pgsql to pgsqldb
export WJI_DEST_SUPER_JDBC_DRIVER_NAME="MariaDB JDBC Driver"
export WJI_DEST_SUPER_JDBC_URL="jdbc:mariadb://localhost:3306/mysql"
export WJI_DEST_SUPER_USER_ID=root
export WJI_DEST_SUPER_USER_PASSWD=root123
export WJI_DEST_JDBC_DRIVER_NAME="MariaDB JDBC Driver"
export WJI_DEST_JDBC_URL="jdbc:mariadb://localhost:3306/destdb"
export WJI_DEST_USER_ID=destusr
export WJI_DEST_USER_PASSWD=dest123
run_tests.sh pgsqlusr pgsql123 pgsqldb 

