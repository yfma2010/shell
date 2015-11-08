#!/bin/sh
############### seting  ###################
disk="/dev/sdb"
os_file_dir=`pwd`
tar_file_name="xorg_gtk_dev_backup_2015-11-08_img.tar.gz"
grub_name="grub"
###########################################
tar_file="${os_file_dir}/${tar_file_name}"
fdiskfuc()
{

dd if=/dev/zero of=${disk} bs=1 count=512  &&
fdisk ${disk} <<EOF
n
p
1


a
1
p
w
EOF

echo  "mkfs.ext3" ${disk}1 
mkfs.ext3 ${disk}1 &&
echo  "fdisk Done"
sync 
}

tarfuc()
{
echo "tar " ${tar_file} 

mount  ${disk}1  /mnt/ &&
cd /mnt/ && 
tar   -xpf  ${tar_file}  &&
echo "end tar " ${tar_file}  
mkdir -p /mnt/proc 
mkdir -p /mnt/dev/pts
mknod -m 600 /mnt/dev/console c 5 1
mknod -m 666 /mnt/dev/null c 1 3
mkdir -p /mnt/sys
grub-install $disk --root-directory=/mnt
sync  
cd /
umount /mnt
}


fdiskfuc 
tarfuc 
sync
echo  "if there is no error, Congratulion, installation finished!"

