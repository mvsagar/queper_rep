curr_dir=`pwd`
. $WJI_TSRC_HOME/setup.env
. $WJI_TSRC_HOME/setup.mariadb
echo "1. Setting up database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0502_browse_mariadb
#run_tests.sh mariausr maria123 mariadb test_list_dbsetup.txt
cd $curr_dir

# For tests to test transfer from mariadb to sqlitedb
export WJI_DEST_SUPER_JDBC_DRIVER_NAME="SQLite JDBC Driver"
export WJI_DEST_SUPER_JDBC_URL="jdbc:sqlite:/tmp/sqlitedb"
export WJI_DEST_JDBC_DRIVER_NAME="SQLite JDBC Driver"
export WJI_DEST_JDBC_URL="jdbc:sqlite:/tmp/destdb"
run_tests.sh mariausr maria123 mariadb
