#! /bin/bash
if grep -q "#GRUB_CMDLINE_LINUX_DEFAULT" /etc/default/grub
then
	sed -i s/"#GRUB_CMDLINE_LINUX_DEFAULT"/GRUB_CMDLINE_LINUX_DEFAULT/g /etc/default/grub
	sed -i s/GRUB_CMDLINE_LINUX="text"/"#GRUB_CMDLINE_LINUX=\"text\""/g /etc/default/grub
	sed -i s/GRUB_TERMINAL=console/"#GRUB_TERMINAL=console"/g /etc/default/grub
	update-grub
	systemctl set-default graphical.target
else
	sed -i s/GRUB_CMDLINE_LINUX_DEFAULT/#GRUB_CMDLINE_LINUX_DEFAULT/g /etc/default/grub
	if grep -q "GRUB_CMDLINE_LINUX=\"\"" /etc/default/grub
	then
		sed -i s/"GRUB_CMDLINE_LINUX=\"\""/GRUB_CMDLINE_LINUX="text"/g /etc/default/grub
	else
		sed -i s/"#GRUB_CMDLINE_LINUX=\"text\""/GRUB_CMDLINE_LINUX="text"/g /etc/default/grub
	fi
	sed -i s/"#GRUB_TERMINAL=console"/GRUB_TERMINAL=console/g /etc/default/grub
	update-grub
	systemctl set-default multi-user.target		
fi
reboot
