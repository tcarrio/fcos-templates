#!/usr/bin/env sh

fcc_file="$1"
blk_file="$2"

tgt_file="$(dirname $0)/config.ign"
cmd_name="$(basename $0)"

function help() {
  echo """
========= ${cmd_name} =========

Utility shell script for installing a Fedora CoreOS provided
a given Fedora CoreOS Configuration file and block device

Usage: ${cmd_name} fcc_file_path block_device_path
"""
}

function exit_because() {
  code=1

  if [ -z "$1" ]
  then
    exit 0
    return
  fi

  echo "Error: $1"

  help
  exit 1
}

function which_silent() {
  which $@ 1>/dev/null 2>/dev/null
  return $?
}

if [ -z "${fcc_file}" ]
then
  exit_because "No argument provided for Fedora CoreOS Configuration file"
fi

if [ -z "${blk_file}" ]
then
  exit_because "No argument provided for block device file"
fi

if ! which_silent podman || ! which_silent fcct
then
  exit_because "!$ is not installed!"
fi

if [ ! -f "${fcc_file}" ]
then
  exit_because "Fedora CoreOS config file (${fcc_file}) was not found!"
fi

if [ ! -b "${blk_file}" ]
then
  exit_because "Block device (${blk_file}) was not a valid block device"
fi

fcct -o "${tgt_file}" "${fcc_file}"

sudo podman run --pull=always --privileged --rm \
    -v /dev:/dev \
    -v /run/udev:/run/udev \
    -v .:/data \
    -w /data \
    quay.io/coreos/coreos-installer:release \
    install "${blk_file}" -i "${tgt_file}"
