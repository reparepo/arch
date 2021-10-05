## ArchLinux Installation Guide 

1. Boot from install media  

2. Check internet connection  

3. Update system clock:  
```  
$ timedatectl set-ntp true  
```  

4. Make disk partitions:  
	Check if UEFI is enabled:  
```  
$ ls /sys/firmware/efi/efivars  
```  
	IF the above directory doesn't exist you are either on old hardware or you have UEFI disabled  

	List all existing disks and partitions:  
```  
$ fdisk -l  
```  

	Create partitions:  
```
$ fdisk /dev/sda  
```  

	For UEFI:		For non-UEFI:  
	/mnt/efi 512MB	vfat	/mnt		
	/mnt	 	ext4	/home  
	/home	 	ext4	/swap  
	/swap	   

	Format partitions:  
```
$ mkfs.vfat /dev/sda1  
$ mkfs.ext4 /dev/sda2  
$ mkfs.ext4 /dev/sda3  
$ mkswap /dev/sda4  
$ swapon /dev/sda4  
```  

5. Mount partitions:  
	Root:  
	$ mount /dev/sda2 /mnt  
	
	Boot:  
	$ mkdir /mnt/boot  
	$ mount /dev/sda1 /mnt/boot  

	Home:  
	$ mkdir /mnt/home  
	$ mount /dev/sda3 /mnt/home  

	Check mounted partitions:  
	$ df  

6. Perform the Base Installation:  
	$ pacstrap /mnt base linux linux-firmware vim  

7. Generate UUIDs:  
	$ genfstab -U /mnt >> /mnt/etc/fstab  

	Check:  
	$ cat /mnt/etc/fstab  

8. Change Root:  
	$ arch-chroot /mnt  

9. Set the Timezone:  
	$ timedatectl list-timezones  
	$ ln -sf /usr/share/zoneinfo/Europe/Helsinki /etc/localtime  
	$ hwclock --systohc  

10. Setup Locale:  
	$ vim /etc/locale.gen  
		en_US.UTF-8 UTF-8  
		ru_RU.UTF-8 UTF-8  

	$ locale-gen  

	$ echo LANG=en_US.UTF-8 > /etc/locale.conf  
	$ export LANG=en_US.UTF-8  

11. Configure network:  
	$ vim /etc/hostname  
		ArchLinuxPC  

	$ vim /etc/hosts  
		127.0.0.1 localhost  
		::1 localhost  
		127.0.0.1 ArchLinuxPC  

12. Set Root password:  
	$ passwd  

13. Install GRUB:  
	For non-UEFI:  
		$ pacman -S grub  
		$ grub-install /dev/sda  
		$ grub-mkconfig -o /boot/grub/grub.cfg  

	For UEFI:  
		$ pacman -S grub efibootmgr  
		$ mkdir /boot/efi  
		$ mount /dev/sda1 /boot/efi  
		$ grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi  
		$ grub-mkconfig -o /boot/grub/grub.cfg  

14. Create user account and Home directory:  
	$ useradd -m aj  
	$ passwd aj  

15. Install sudo:  
	$ pacman -S sudo  

16. Grant user with sudo privileges:  
	$ EDITOR=vim visudo  
		aj ALL=(ALL) ALL  

17. Install Desktop environment:  
	GNOME:  
		$ pacman -S xorg  
		$ pacman -S gnome  
		$ pacman -S gnome-tweaks  
		$ pacman -S networkmanager  
		$ systemctl enable gdm.service  
		$ systemctl enable NetworkManager.service  

18. Exit and shutdown:  
	$ exit  
	$ shutdown now  

