This directory contains test plans.



PostgreSQL setup
=================

After installation of postgresql
1. Login to postgresql user linux account postgres as following
	sudo su -l postgres
	
2. Run command psql at linux user login prompt.

3. Create database as following:
CREATE DATABASE pgsqldb;

4. Create user as following:
CREATE USER pgsqlusr.

5. Set password
ALTER ROLE pgsqlusr password 'pgsql123';

6. Grant permission on the database to the user.

GRANT ALL ON DATABASE pgsqldb TO pgsqlusr;

7. Exit psql using ctrl-D.
