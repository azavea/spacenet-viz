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

function download_vegas() {
    echo "==> Making local Vegas data directory"
    mkdir AOI_2_Vegas
    echo "==> Getting Vegas data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz --request-payer requester AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz
    echo "==> Unzipping Vegas data locally"
    tar -xzf AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz
    echo "==> Deleting local zip files before copying local Vegas data data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Vegas data to your s3 bucket"
    aws s3 cp AOI_2_Vegas/ s3://raster-vision/datasets/spacenet/AOI_2_Vegas/ --recursive --exclude ".*"
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
            echo $1
            download_vegas $1
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi
