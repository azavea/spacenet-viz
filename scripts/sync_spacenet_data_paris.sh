#!/bin/bash

set -e

if [[ -n "${RV_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
"Usage: $(basename "$0") dest/s3/path

Syncs Paris data from s3://spacenet-data to s3://dest/s3/path (no s3:// or trailing slash).
"
}

DIR="$(dirname "$0")"

function download_paris() {
    echo "==> Recreating local Paris data directory"
    rm -rf AOI_3_Paris
    mkdir AOI_3_Paris
    echo "==> Getting Paris data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_3_Paris/AOI_3_Paris_Train.tar.gz --request-payer requester AOI_3_Paris/AOI_3_Paris_Train.tar.gz >/dev/null
    echo "==> Unzipping Paris data locally"
    tar -xzf AOI_3_Paris/AOI_3_Paris_Train.tar.gz --directory AOI_3_Paris/ >/dev/null
    echo "==> Deleting local zip files before copying local Paris data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Paris data to your s3 bucket"
    aws s3 cp AOI_3_Paris/ s3://$1/AOI_3_Paris/ --recursive --exclude ".*" >/dev/null
    echo "==> Removing Paris data locally"
    rm -rf AOI_3_Paris
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
            download_paris $1
            date
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi