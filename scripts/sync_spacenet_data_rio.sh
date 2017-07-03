#!/bin/bash

set -e

if [[ -n "${RV_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
"Usage: $(basename "$0") dest/s3/path

Syncs Rio data from s3://spacenet-data to s3://dest/s3/path (no s3:// or trailing slash).
"
}

DIR="$(dirname "$0")"

function download_rio() {
    echo "==> Recreating local Rio data directory"
    rm -rf AOI_1_Rio
    mkdir -p AOI_1_Rio/processedData
    mkdir -p AOI_1_Rio/srcData/rasterData
    mkdir -p AOI_1_Rio/srcData/vectorData
    echo "==> Getting Rio data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/processedData/processedBuildingLabels.tar.gz --request-payer requester AOI_1_Rio/processedData/processedBuildingLabels.tar.gz >/dev/null
    aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/3-Band.tar.gz --request-payer requester AOI_1_Rio/srcData/rasterData/3-Band.tar.gz >/dev/null
    aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/8-Band.tar.gz --request-payer requester AOI_1_Rio/srcData/rasterData/8-Band.tar.gz >/dev/null
    aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz --request-payer requester AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz >/dev/null
    echo "==> Unzipping Paris data locally"
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels.tar.gz --directory AOI_1_Rio/processedData/ >/dev/null
    tar -xzf AOI_1_Rio/srcData/rasterData/3-Band.tar.gz --directory AOI_1_Rio/srcData/rasterData/ >/dev/null
    tar -xzf AOI_1_Rio/srcData/rasterData/8-Band.tar.gz --directory AOI_1_Rio/srcData/rasterData/ >/dev/null
    tar -xzf AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz --directory AOI_1_Rio/srcData/vectorData/ >/dev/null
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/3band.tar.gz --directory AOI_1_Rio/processedData/processedBuildingLabels/ >/dev/null
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/8band.tar.gz --directory AOI_1_Rio/processedData/processedBuildingLabels/ >/dev/null
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/vectordata/geojson.tar.gz --directory AOI_1_Rio/processedData/processedBuildingLabels/vectordata/ >/dev/null
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/vectordata/summarydata.tar.gz --directory AOI_1_Rio/processedData/processedBuildingLabels/vectordata/ >/dev/null
    echo "==> Deleting local zip files before copying local Rio data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Rio data to your s3 bucket"
    aws s3 cp AOI_1_Rio/ s3://$1/AOI_1_Rio/ --recursive --exclude ".*" >/dev/null
    echo "==> Removing Rio data locally"
    rm -rf AOI_1_Rio
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
            download_rio $1
            date
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi
