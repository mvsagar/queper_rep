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
#
# Now run bug fix test cases.
run_tests.sh mariausr maria123 mariadb

