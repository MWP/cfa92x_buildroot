#!/bin/bash
# post-build fixups

echo "POST ------------------"

TARGET_DIR=$1
IMAGES_DIR=$1/boot
BOARD_DIR=$(dirname $0)

# Copy custom config files
#cp $BOARD_DIR/interfaces $TARGET_DIR/etc/network/interfaces
#cp $BOARD_DIR/udhcpd.conf $TARGET_DIR/etc/udhcpd.conf
#cp $BOARD_DIR/inittab $TARGET_DIR/etc/inittab
#cp $BOARD_DIR/fstab $TARGET_DIR/etc/fstab
#install -m 0755 -D $BOARD_DIR/S45udhcpd $TARGET_DIR/etc/init.d/S45udhcpd

cp -avf $BOARD_DIR/root/* $TARGET_DIR/

# Rename dtbs and kernel images according to what barebox expects
for dtb in $IMAGES_DIR/*.dtb; do
    dtbname=$(basename $dtb .dtb)
    dtbboard=${dtbname//imx28-/oftree-}
    mv $dtb $IMAGES_DIR/$dtbboard
done

if [ -f $IMAGES_DIR/zImage ]; then
       mv $IMAGES_DIR/zImage $IMAGES_DIR/zImage-cfa10036
fi

echo "POST FINISHED ------------------"

