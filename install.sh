#!/sbin/sh

mknod /dev/loop1 b 7 8
losetup /dev/loop1 /data/rootfs.img
mkdir /rootfs && mount /dev/loop1 /rootfs
cp ./etc/systemd/system/apt-fix.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/audio-hidl.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/epoch.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/altresolv.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/bluetoothalt.service /rootfs/etc/systemd/system/
cp ./etc/apt/sources.list.d/* /rootfs/etc/apt/sources.list.d/
cp ./etc/udev/rules.d/70-exynos9810.rules /rootfs/etc/udev/rules.d/
cp ./usr/share/keyrings/exynos9810.gpg /rootfs/usr/share/keyrings/exynos9810.gpg
cp -r ./usr/lib/droid-system-overlay/ /rootfs/usr/lib/
cp -r ./usr/bin/* /rootfs/usr/bin/
rm -f /rootfs/etc/resolv.conf
cp ./etc/resolv.conf /rootfs/etc/
cp -r ./etc/phosh/ /rootfs/etc/
cp -r ./etc/systemd/system/android-mount.service.d /rootfs/etc/systemd/system/
cp -r ./var/lib/bluetooth/* /rootfs/var/lib/bluetooth/
cp -r ./lib/systemd/system/bluebinder.service.d/ /rootfs/lib/systemd/system/
cp ./usr/lib/systemd/system/android-service@hwcomposer.service.d/40-exynos.conf /rootfs/usr/lib/systemd/system/android-service@hwcomposer.service.d/40-exynos.conf
chroot /rootfs/ /bin/bash -c 'export PATH="$PATH:/usr/bin:/usr/sbin:/bin:/sbin" && rm -f /etc/systemd/system/dbus-org.bluez.service'
chroot /rootfs/ /bin/bash -c 'export PATH="$PATH:/usr/bin:/usr/sbin:/bin:/sbin" && systemctl mask systemd-resolved systemd-timesyncd bluetooth && systemctl enable apt-fix audio-hidl altresolv bluetoothalt'
echo "Installation completed, reboot"
