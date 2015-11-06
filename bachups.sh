mkdir /backups
date_str=`date +"%Y-%m-%d"`
tar -zcpf /backups/tar_backup_${date_str}_img.tar.gz \
 --directory=/ --exclude=proc --exclude=sys\
 --exclude=dev/pts --exclude=/lost+found\
 --exclude=backups .  2>>/backups/tar_backup_${date_str}_img.tar.gz.log
