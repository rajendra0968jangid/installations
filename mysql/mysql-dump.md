# Proper Professional Backup Command (Recommended)#

mysqldump -u root -p \
--single-transaction \
--set-gtid-purged=OFF \
school > /tmp/backup.sql

# If You Want Full Server Backup#

mysqldump -u root -p \
--all-databases \
--single-transaction \
--routines \
--triggers \
--events \
--set-gtid-purged=OFF > /tmp/full_backup.sql

# Now Copy Backup to Host#

docker cp mysql-container:/tmp/backup.sql .

**Then check:**

ls -lh backup.sql

# Best DevOps Practice#

**For production:**

mysqldump -u root -p \
--single-transaction \
--set-gtid-purged=OFF \
school | gzip > backup_$(date +%F).sql.gz
