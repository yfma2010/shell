#!/bin/sh
############### seting  ###################
disk="/dev/sdb"
os_file_dir=`pwd`
tar_file_name="lfs6.8_2.6.32_1.4.5_2.6.16_27.tar"
grub_name="grub"
###########################################
tar_file="${os_file_dir}/${tar_file_name}"
fdiskfuc()
{

dd if=/dev/zero of=${disk} bs=1 count=512  &&
fdisk ${disk} &>/dev/null <<EOF
n
p
1


a
1
w
EOF
echo  "fdisk Done"

sync &&
echo  "mkswap and "${disk}2"  and mke2fs" ${disk}1 
sleep 1
mkswap ${disk}2 &&
swapon ${disk}2 &&
mke2fs -I 128 -jv ${disk}1 &&
#chmn ${disk}1  &&
sync 
}

tarfuc()
{
echo "tar system"
mkdir -p /mnt/lfs
mount  ${disk}1  /mnt/lfs &&
cd /mnt/lfs && 
tar   -xpf  ${tar_file}  && 
mknod -m 600 /mnt/lfs/dev/console c 5 1
mknod -m 666 /mnt/lfs/dev/null c 1 3
sync &&
umount -l /mnt/lfs

}

grubfuc()
{
echo -e "\\033[1;34mpassed:\\033[0;39m grub and made the systme bootable."
sec_disk="/dev/sdb"
if [ ${disk} == ${sec_disk} ];then
${grub_name} <<EOF
root (hd1,0)
setup (hd1)
quit
EOF
else
${grub_name} <<EOF
root (hd0,0)
setup (hd0)
quit
EOF
fi
sync
}

fdiskfuc 
tarfuc 
grubfuc 

echo  "if there is no error, Congratulion, installation finished!"

