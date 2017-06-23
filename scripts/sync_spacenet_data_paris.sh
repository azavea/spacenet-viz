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

function download_paris() {
    echo "==> Making local Paris data directory"
    mkdir AOI_3_Paris
    echo "==> Getting Paris data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_3_Paris/AOI_3_Paris_Train.tar.gz --request-payer requester AOI_3_Paris/AOI_3_Paris_Train.tar.gz
    echo "==> Unzipping Paris data locally"
    tar -xzf AOI_3_Paris/AOI_3_Paris_Train.tar.gz --directory AOI_3_Paris/
    echo "==> Deleting local zip files before copying local Paris data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Paris data to your s3 bucket"
    aws s3 cp AOI_3_Paris/ s3://$1 --recursive --exclude ".*"
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
            echo $1
            download_paris $1
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi
