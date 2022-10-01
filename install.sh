#!/sbin/sh
mknod /dev/loop1 b 7 8
losetup /dev/loop1 /data/rootfs.img
mkdir /rootfs && mount /dev/loop1 /rootfs
cp ./etc/systemd/system/apt-fix.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/samsung-hwc.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/epoch.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/altresolv.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/upoweralt.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/bluetoothalt.service /rootfs/etc/systemd/system/
cp ./etc/apt/sources.list.d/* /rootfs/etc/apt/sources.list.d/
cp ./etc/udev/rules.d/70-exynos9810.rules /rootfs/etc/udev/rules.d/
cp ./usr/share/keyrings/exynos9810.gpg /rootfs/usr/share/keyrings/exynos9810.gpg
cp -r ./usr/lib/droid-vendor-overlay/ /rootfs/usr/lib/
cp -r ./usr/bin/* /rootfs/usr/bin/
rm -f /rootfs/etc/resolv.conf
cp ./etc/resolv.conf /rootfs/etc/
cp -r ./var/lib/bluetooth/ /rootfs/var/lib/bluetooth/
cp -r ./deb/ /rootfs/
chroot /rootfs/ /bin/bash -c 'export PATH="$PATH:/usr/bin:/usr/sbin:/bin:/sbin" && systemctl enable apt-fix samsung-hwc epoch altresolv upoweralt bluetoothalt && systemctl mask systemd-resolved systemd-timesyncd upower bluetooth'
chroot /rootfs/ /bin/bash -c 'export PATH="$PATH:/usr/bin:/usr/sbin:/bin:/sbin" && dpkg -i /deb/*.deb'
echo "Now just reboot"
