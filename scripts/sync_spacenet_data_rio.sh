#!/bin/bash

set -e

if [[ -n "${RV_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
"Usage: $(basename "$0") s3://dest_s3_path

Syncs Rio data from s3://spacenet-data to dest_s3_path, for EMR ingest.
"
}

DIR="$(dirname "$0")"

function download_rio() {
    echo "==> Making local Rio data directory"
    mkdir -p AOI_1_Rio/srcData/rasterData
    mkdir -p AOI_1_Rio/srcData/vectorData
    echo "==> Getting Rio data from s3://spacenet-dataset locally"
    aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/processedData/processedBuildingLabels.tar.gz --request-payer requester AOI_1_Rio/processedData/processedBuildingLabels.tar.gz
    aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/3-Band.tar.gz --request-payer requester AOI_1_Rio/srcData/rasterData/3-Band.tar.gz
    aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/8-Band.tar.gz --request-payer requester AOI_1_Rio/srcData/rasterData/8-Band.tar.gz
    aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz --request-payer requester AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz
    echo "==> Unzipping Paris data locally"
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels.tar.gz --directory AOI_1_Rio/processedData/
    tar -xzf AOI_1_Rio/srcData/rasterData/3-Band.tar.gz --directory AOI_1_Rio/srcData/rasterData/
    tar -xzf AOI_1_Rio/srcData/rasterData/8-Band.tar.gz --directory AOI_1_Rio/srcData/rasterData/
    tar -xzf AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz --directory AOI_1_Rio/srcData/vectorData/
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/3band.tar.gz --directory AOI_1_Rio/processedData/processedBuildingLabels/
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/8band.tar.gz --directory AOI_1_Rio/processedData/processedBuildingLabels/
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/vectordata/geojson.tar.gz --directory AOI_1_Rio/processedData/processedBuildingLabels/vectordata/
    tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/vectordata/summarydata.tar.gz --directory AOI_1_Rio/processedData/processedBuildingLabels/vectordata/
    echo "==> Deleting local zip files before copying local Rio data to s3"
    find . -name "*.tar.gz" -type f -delete
    echo "==> Copying Rio data to your s3 bucket"
    aws s3 cp AOI_1_Rio/ s3://raster-vision/datasets/spacenet/AOI_1_Rio/ --recursive --exclude ".*"
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
            echo $1
            download_rio $1
        else
            echo "ERROR: Destination S3 path required."
            echo
            usage
            exit 64
        fi
    fi
fi
