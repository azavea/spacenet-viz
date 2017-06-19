#!/bin/bash

set -e

if [[ -n "${RV_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
"Usage: $(basename "$0")

Downloads tiff files from S3 for local ingest.
"
}

DIR="$(dirname "$0")"

function download_if_not_exits() {

    pushd "${DIR}/../data" > /dev/null
    if [ ! -f $2 ]
    then
        echo "Downloading ${1}"
        aws s3 cp ${1} ${2}
    else
        echo "${2} already exists"
    fi
    popd > /dev/null
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]
then
    if [ "${1:-}" = "--help" ]
    then
        usage
    else
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL/MUL_AOI_3_Paris_img10.tif" \
            "paris.tif"
    fi
    exit
fi
