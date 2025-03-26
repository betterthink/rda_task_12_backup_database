#! /bin/bash
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB --result-file=ShopDB_full_backup.sql
if [ $? -ne 0 ]; then
  echo "Backup failed!"
  exit 1
fi

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDB_full_backup.sql
if [ $? -ne 0 ]; then
  echo "Restore failed"
  exit 1
fi


mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB --result-file=data_backup.sql
if [ $? -ne 0 ]; then
  echo "Backup failed!"
  exit 1
fi
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < data_backup.sql
if [ $? -ne 0 ]; then
  echo "Restore failed!"
  exit 1
fi