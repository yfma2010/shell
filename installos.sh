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

echo  "mkfs.ext3" ${disk}1 
mkfs.ext3 ${disk}1 &&
echo  "fdisk Done"
sync 
}

tarfuc()
{
echo "tar system"

mount  ${disk}1  /mnt/ &&
cd /mnt/ && 
tar   -xpf  ${tar_file}  && 
mkdir -p /mnt/proc 
mkdir -p /mnt/dev/pts
mkdir -p /mnt/sys
mount -t proc none /mnt/proc 
mount -o bind /dev /mnt/dev
mount -o bind /sys /mnt/sys 
mount -t devpts devpts /mnt/dev/pts
chroot /mnt
grub-install /dev/sdb --root-directory=/mnt
sync &&
umount -l /mnt

}


fdiskfuc 
tarfuc 
sync
echo  "if there is no error, Congratulion, installation finished!"

