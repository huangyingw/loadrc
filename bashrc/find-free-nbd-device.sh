#!/bin/zsh
#===============================================================================
#
#          FILE: find-free-nbd-device.sh
#
#         USAGE: ./find-free-nbd-device.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 05/07/2016 12:52
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

set -e
set -o pipefail

function nbd_used?() {
    local devpath=${1}

    local find=0 line=
    while read line
    do
        [[ ${line} == "" ]] && continue

        set ${line}
        [[ "${1}" == "43" ]] || continue

        if [[ ${devpath} == /dev/${4} ]]
        then
            find=1
        fi
    done < /proc/partitions

    [[ "${find}" == "1" ]]
}

function find_free_nbd_device() {
    local nbd=
    for nbd in /dev/nbd*; do
        case "${nbd}" in
            *p[0-9]) continue ;;
        esac

        nbd_used? ${nbd} && continue

        echo ${nbd}
        break
    done

    # free nbd device not found
    return 1
}

find_free_nbd_device
