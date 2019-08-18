How to run tests.

1. Create wjisql.jar and place it in wji_dist

2. Start tomcat.

3. Create following databases and users before running the tests:
3.1 MySQL
    Database: mysqldb
    User:     mysqlusr
    Password: mysql123
3.2 MariaDB
    Database: mariadb
    User:     mariausr
    Password: maria123
3.2 PostgreSQL
    Database: pgsqldb
    User:     pgsqlusr
    Password: pgsql123
    
    Make sure you give super user privileges to the user.

4. Do source ./setup.env in wji_tsrc

5. Run tests as following:

5.1 Go to individual test source directory

5.2 Run tests as following:

    ./run.sh

