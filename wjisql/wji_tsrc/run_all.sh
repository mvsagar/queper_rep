test_no=0
for test_list in `find . -type f -name "test_list.txt" | sort`
do
    ((++test_no))
    file_dir=$(dirname "$test_list") 
    echo ${test_no}")Test directory: " $file_dir
    cd $WJI_TSRC_HOME/$file_dir
    if [[ "$file_dir" == *mariadb ]]
    then
	source $WJI_TSRC_HOME/setup.mariadb
    elif [[ "$file_dir" == *pgsql ]]
    then
	source $WJI_TSRC_HOME/setup.pgsql
    elif [[ "$file_dir" == *sqlite ]]
    then
	source $WJI_TSRC_HOME/setup.sqlite
	# Copy bad database file for testing to /tmp
	cp $WJI_TSRC_HOME/wji_init_data/baddb.png /tmp
    fi
    # Arguments are dummy
    run_tests.sh x_user y_passwd z_db
done


