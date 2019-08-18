curr_dir=`pwd`
. $WJI_TSRC_HOME/setup.env
. $WJI_TSRC_HOME/setup.sqlite
cd ../wji_0803_tbl_result_mariadb
# Need to compare with .sqlite save files if exist.
run_tests.sh dummy dummy sqlitedb test_list.txt sqlite
cd $WJI_TEST_HOME
cp trr_wji_0803_tbl_result_mariadb.rpt trr_wji_0807_tbl_result_sqlite.rpt
cd $curr_dir
