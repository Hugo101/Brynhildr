#/bin/sh

mysql -u root -proot < sqls.txt
mysql -u root -proot < procedures.sql
mysql -u root -proot < schedule.sql
mysql -u root -proot < triggers.sql
mysql -u root -proot < dump.sql
