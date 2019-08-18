curr_dir=`pwd`
. $WJI_TSRC_HOME/setup.env
. $WJI_TSRC_HOME/setup.mariadb
echo "1. Setting up database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0502_browse_mariadb
run_tests.sh mariausr maria123 mariadb test_list_dbsetup.txt
cd $curr_dir

# Test transfer of data from  mariadb to another mariadb database.
export WJI_DEST_SUPER_JDBC_DRIVER_NAME="MariaDB JDBC Driver"
export WJI_DEST_SUPER_JDBC_URL="jdbc:mariadb://localhost:3306/mysql"
export WJI_DEST_SUPER_USER_ID=root
export WJI_DEST_SUPER_USER_PASSWD=root123
export WJI_DEST_JDBC_DRIVER_NAME="MariaDB JDBC Driver"
export WJI_DEST_JDBC_URL="jdbc:mariadb://localhost:3306/destdb"
export WJI_DEST_USER_ID=destusr
export WJI_DEST_USER_PASSWD=dest123
run_tests.sh mariausr maria123 mariadb
