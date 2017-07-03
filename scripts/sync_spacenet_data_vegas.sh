#!/bin/bash

set -e

if [[ -n "${RV_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
"Usage: $(basename "$0") dest/s3/path

Syncs Vegas data from s3://spacenet-data to s3://dest/s3/path (no s3:// or trailing slash).
"
}

DIR="$(dirname "$0")"

function download_vegas() {
    echo "==> Recreating local Vegas data directory"
    rm -rf AOI_2_Vegas
    mkdir AOI_2_Vegas
    echo "==> Getting Vegas data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz --request-payer requester AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz >/dev/null
    echo "==> Unzipping Vegas data locally"
    tar -xzf AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz --directory AOI_2_Vegas/ >/dev/null
    echo "==> Deleting local zip files before copying local Vegas data data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Vegas data to your s3 bucket"
    aws s3 cp AOI_2_Vegas/ s3://$1/AOI_2_Vegas/ --recursive --exclude ".*" >/dev/null
    echo "==> Removing Vegas data locally"
    rm -rf AOI_2_Vegas
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
            download_vegas $1
            date
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi
