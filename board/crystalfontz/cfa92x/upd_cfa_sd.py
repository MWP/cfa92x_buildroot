#!/usr/bin/env python2

import os
import shutil
import struct
import subprocess
import sys
import tarfile
import tempfile


def check_mounted(device_path):
    mount_str = subprocess.check_output("mount")
    if device_path in mount_str:
        print "SD Card already mounted... aborting."
        exit(1)


def generate_partition_name(device, number):
    if "sd" in device:
        return "%s%d" % (device, number)
    elif "mmcblk" in device:
        return "%sp%d" % (device, number)


def format_device(device_path):
    subprocess.call(["mkfs.ext4", "-Lrootfs -O ^has_journal -E stride=2,stripe-width=1024 -b 4096",
                     generate_partition_name(device_path, 3)],
                    stdout=subprocess.PIPE)


def generate_bootstream_headers(num_bootstream, start_sector):
    return struct.pack("<I"    # Magic
                       "4x"    # Primary Tag (unused)
                       "4x"    # Secondary Tag (unused)
                       "I"     # Number of Boot Stream blocks
                       "8x"    # Padding
                       "4x"    # Primary Tag (unused)
                       "I"     # Base offset of the first bootstream block
                       "4x",   # Padding
                       0x00112233,
                       num_bootstream,
                       start_sector + 1)


def write_bootstream_partition(device_file, partition, bootstream):
    path = generate_partition_name(device_file, partition)
    with open(path, 'w') as partition:
        sector_str = subprocess.check_output(
            "fdisk -lu %s | awk '$5==53 {print $2}'" % device_file, shell=True)
        partition.write(generate_bootstream_headers(1, int(sector_str)))

        # Fill the rest of the first 512 bytes with 0
        current = partition.tell()
        partition.write(struct.pack("%dx" % (512 - current)))

        # Copy the bootstream image
        with open(bootstream, 'r') as image:
            partition.write(image.read())

def write_barebox_env(device_file, partition, env):
    path = generate_partition_name(device_file, partition)
    with open(path, 'w') as partition:
        with open(env, 'r') as image:
            partition.write(image.read())

def install_rootfs_tarball(device_file, partition, archive):
    path = generate_partition_name(device_file, partition)
    mountpoint = tempfile.mkdtemp()
    subprocess.call(["mount", path, mountpoint])
    tar = tarfile.open(archive, 'r:*')
    tar.extractall(mountpoint)
    subprocess.call("sync")
    subprocess.call(["umount", mountpoint])
    os.rmdir(mountpoint)


def main():
    import argparse

    parser = argparse.ArgumentParser(
        description='Flash a SD Card at format expected by iMX28 SoCs')
    parser.add_argument("device", help="Path to the SD Card's device file")
    parser.add_argument("--bootstream", "-b",
                        help="Path to the boostream image", required=True)
    parser.add_argument("--rootfs", "-r",
                        help="Path to the tarball containing the rootfs")
    parser.add_argument("--environment", "-e",
                        help="Path to the barebox environment image")

    args = parser.parse_args()

    check_mounted(args.device)

    format_device(args.device)

    write_bootstream_partition(args.device, 1, args.bootstream)

    if args.environment:
        write_barebox_env(args.device, 2, args.environment)

    if args.rootfs:
        install_rootfs_tarball(args.device, 3, args.rootfs)

    print "Flashing done, you can now remove the SD Card"


if __name__ == "__main__":
    main()
