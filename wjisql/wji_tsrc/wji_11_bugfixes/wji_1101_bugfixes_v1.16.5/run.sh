#
# Tests to be done with source database as MariaDB.
#
curr_dir=`pwd`
. ../../setup.env
. ../../setup.mariadb
echo "1. Setting up mariadb database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0502_browse_mariadb
run_tests.sh mariausr maria123 mariadb test_list_dbsetup.txt
cd $curr_dir

# For tests to test transfer from mariadb to pgsqldb
# and other non-transfer related tests.
export WJI_DEST_SUPER_JDBC_DRIVER_NAME="PostgreSQL JDBC Driver"
export WJI_DEST_SUPER_JDBC_URL="jdbc:postgresql://localhost/pgsqldb"
export WJI_DEST_SUPER_USER_ID=pgsqlusr
export WJI_DEST_SUPER_USER_PASSWD=pgsql123
export WJI_DEST_JDBC_DRIVER_NAME="PostgreSQL JDBC Driver"
export WJI_DEST_JDBC_URL="jdbc:postgresql://localhost/destdb"
export WJI_DEST_USER_ID=destusr
export WJI_DEST_USER_PASSWD=dest123
run_tests.sh mariausr maria123 mariadb

#
# Tests to be done with PostgreSQL databases.
#
curr_dir=`pwd`
. ../../setup.env
. ../../setup.pgsql
echo "2. Setting up pgsql database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0503_browse_pgsql
run_tests.sh pgsqlusr pgsql123 pgsqldb test_list_dbsetup.txt
cd $curr_dir
run_tests.sh pgsqlusr pgsql123 pgsqldb test_list_pgsql.txt
