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
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img3.tif" \
            "paris3.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img4.tif" \
            "paris4.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img5.tif" \
            "paris5.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img6.tif" \
            "paris6.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img8.tif" \
            "paris8.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img10.tif" \
            "paris10.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img12.tif" \
            "paris12.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img14.tif" \
            "paris14.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img17.tif" \
            "paris17.tif"
        download_if_not_exits \
            "s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/MUL-PanSharpen_AOI_3_Paris_img19.tif" \
            "paris19.tif"

    fi
    exit
fi
