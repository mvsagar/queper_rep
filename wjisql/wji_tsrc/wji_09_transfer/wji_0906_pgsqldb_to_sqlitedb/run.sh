curr_dir=`pwd`
. ../../setup.env
. ../../setup.pgsql
echo "1. Setting up database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0503_browse_pgsql
run_tests.sh pgsqlusr pgsql123 pgsqldb test_list_dbsetup.txt
cd $curr_dir

# For tests to test transfer from mariadb to sqlitedb
export WJI_DEST_SUPER_JDBC_DRIVER_NAME="SQLite JDBC Driver"
export WJI_DEST_SUPER_JDBC_URL="jdbc:sqlite:/tmp/sqlitedb"
export WJI_DEST_JDBC_DRIVER_NAME="SQLite JDBC Driver"
export WJI_DEST_JDBC_URL="jdbc:sqlite:/tmp/destdb"
run_tests.sh pgsqlusr pgsql123 pgsqldb

