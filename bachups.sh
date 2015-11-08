mkdir -p /backups
date_str=`date +"%Y-%m-%d"`
cd /
tar -zcpf ./backups/$1_backup_${date_str}_img.tar.gz \
 ./ --exclude=./proc --exclude=./sys\
 --exclude=./dev --exclude=./lost+found\
 --exclude=./backups   2>/backups/$1_backup_${date_str}_img.tar.gz.log
