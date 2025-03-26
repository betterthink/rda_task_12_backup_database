#! /bin/bash
set -e

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=ShopDB_full_backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDB_full_backup.sql


DATA=$(mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDB -e "SHOW TABLES;" --skip-column-names)

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB $DATA > ShopDB_data_backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDB_data_backup.sql