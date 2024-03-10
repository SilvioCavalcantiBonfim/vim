#!/bin/bash

SHA256SUM_ISVALID(){
    chmod +x ./download/$1
    chmod +x ./download/$2

    IFS=' '

    read -ra FILE_SHA256SUM <<< "$(sha256sum ./download/$1)"
    read -ra DOWNLOAD_FILE_SHA256SUM <<< "$(cat ./download/$2)"

    if [ "${FILE_SHA256SUM[0]}" = "${DOWNLOAD_FILE_SHA256SUM[0]}" ]; then
        return 0
    else
        return 1
    fi
}