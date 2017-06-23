#!/bin/bash

set -e

if [[ -n "${RV_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
"Usage: $(basename "$0") dest_s3_path

Syncs Rio data from s3://spacenet-data to dest_s3_path, for EMR ingest.
"
}

DIR="$(dirname "$0")"

function download_khartoum() {
    echo "==> Making local Khartoum data directory"
    mkdir AOI_5_Khartoum
    echo "==> Getting Khartoum data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_5_Khartoum/AOI_5_Khartoum_Train.tar.gz --request-payer requester AOI_5_Khartoum/AOI_5_Khartoum_Train.tar.gz
    echo "==> Unzipping Khartoum data locally"
    tar -xzf AOI_5_Khartoum/AOI_5_Khartoum_Train.tar.gz --directory AOI_5_Khartoum/
    echo "==> Deleting local zip files before copying local Khartoum data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Khartoum data to your s3 bucket"
    aws s3 cp AOI_5_Khartoum/ s3://$1 --recursive --exclude ".*"
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
            echo $1
            download_khartoum $1
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi
