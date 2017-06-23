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

function download_shanghai() {
    echo "==> Making local Shanghai data directory"
    mkdir AOI_4_Shanghai
    echo "==> Getting Shanghai data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_4_Shanghai/AOI_4_Shanghai_Train.tar.gz --request-payer requester AOI_4_Shanghai/AOI_4_Shanghai_Train.tar.gz
    echo "==> Unzipping Shanghai data locally"
    tar -xzf AOI_4_Shanghai/AOI_4_Shanghai_Train.tar.gz
    echo "==> Deleting local zip files before copying local Shanghai data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Shanghai data to your s3 bucket"
    aws s3 cp AOI_4_Shanghai/ s3://raster-vision/datasets/spacenet/AOI_4_Shanghai/ --recursive --exclude ".*"
    echo "==> Removing Shanghai data locally"
    rm -rf AOI_4_Shanghai
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
            download_shanghai $1
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi
