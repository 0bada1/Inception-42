#!/usr/bin/env bash

echo >> /etc/mysql/my.cnf
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "bind-address=0.0.0.0" >> /etc/mysql/my.cnf # configures the MDB server to listen on all
# network interfaces (0.0.0.0)

mysql_install_db --datadir=/var/lib/mysql
#sets up the database structure and files.

mysqld_safe & # starts the MDB server in the background
mysql_pid=$! # stores the PID

until mysqladmin ping >/dev/null 2>&1; do
  echo -n "."; sleep 0.2
done
# checks if the MDB server is running and accpecting connections.
#it repeatedly tries to ping the server until it succeeds.

mysql -u root -e "CREATE DATABASE $DB_NAME;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
    GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
    FLUSH PRIVILEGES;"


wait $mysql_pid # waits for the MDB server process to finish. this insures that the script does not exit before the server has fully initialized 
0
