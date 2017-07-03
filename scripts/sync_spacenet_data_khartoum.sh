#!/bin/bash

set -e

if [[ -n "${RV_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
"Usage: $(basename "$0") dest/s3/path

Syncs Khartoum data from s3://spacenet-data to s3://dest/s3/path (no s3:// or trailing slash).
"
}

DIR="$(dirname "$0")"

function download_khartoum() {
    echo "==> Recreating local Khartoum data directory"
    rm -rf AOI_5_Khartoum
    mkdir AOI_5_Khartoum
    echo "==> Getting Khartoum data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_5_Khartoum/AOI_5_Khartoum_Train.tar.gz --request-payer requester AOI_5_Khartoum/AOI_5_Khartoum_Train.tar.gz >/dev/null
    echo "==> Unzipping Khartoum data locally"
    tar -xzf AOI_5_Khartoum/AOI_5_Khartoum_Train.tar.gz --directory AOI_5_Khartoum/ >/dev/null
    echo "==> Deleting local zip files before copying local Khartoum data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Khartoum data to your s3 bucket"
    aws s3 cp AOI_5_Khartoum/ s3://$1/AOI_5_Khartoum/ --recursive --exclude ".*" >/dev/null
    echo "==> Removing Khartoum data locally"
    rm -rf AOI_5_Khartoum
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]
then
    if [ "${1:-}" = "--help" ]
    then
        usage
    else
        if [ -n "$1" ]
        then
            echo "Syncing data to s3://$1/"
            date
            download_khartoum $1
            date
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi