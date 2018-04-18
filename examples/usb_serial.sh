#!/bin/bash

# Regexp for matching device id
regexp="^.+([0-9]{4}):([0-9]{4}).+Serial.+$"
usb_devices_list="$(lsusb)"

if [[ $usb_devices_list =~ $regexp ]]
then
    vendor_id="0x${BASH_REMATCH[1]}"
    product_id="0x${BASH_REMATCH[2]}"
    echo "Vendor found: $vendor_id"
    echo "Product found: $product_id"
else
    echo "Device could not be found... make sure it is connected" >&2
fi

modprobe usbserial vendor=$vendor_id product=$product_id

regexp_tty="ttyUSB[0-9]"

if [[ "$(dmesg)" =~ $regexp_tty ]]
then
    usb_device="/dev/${BASH_REMATCH[-1]}"
    chmod 777 $usb_device
    echo "Added proper permission to $usb_device"
else
    echo "ttyUSB device could not be found..." >&2
fi

