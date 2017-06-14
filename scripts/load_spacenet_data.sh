#!/bin/bash

set -e

if [[ -n "${RV_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
"Usage: $(basename "$0") dest_s3_path [-rio -vegas -paris -shanghai -khartoum]

Syncs tiff (and geojson/csv) data from s3://spacenet-dataset to dest_s3_path,
for EMR ingest. Optionally pass in city names to download only their AOI data.
"
}

animals=( ["moo"]="cow" ["woof"]="dog")

# echo "Sync started at…"
# date "+%H:%M:%S"

if [ "${BASH_SOURCE[0]}" = "${0}" ]
then
    if [ "${1:-}" = "--help" ]
    then
        usage
    else
        if [ -n "$1" ]
        then
            
            usage
        else
            echo "ERROR: Destination S3 path required."
            exit 1
        fi
    fi
fi
#
# if [ -n "$1" ]; then
#   # use first argument as an environment name. Use this to decide how to connect
#   # to the appropriate console.
#   if [ "$1" = "production" ]; then
#     heroku run rails console --app heroku-app-name
#   elif [ "$1" = "staging" ]; then
#     heroku run rails console --app heroku-app-name-staging
#   else
#     echo "Sorry, I don't know how to connect to the '$1' environment."
#     exit 1
#   fi
# else
#   # no argument provided, so just run the local console in the development
#   # environment. Ensure the application is up to date first.
#   script/update
#   bin/rails console
#   # or exit 1 bc bucket necessary?
# fi
#
# # dirs_needed["Rio"] = ["AOI_1_Rio/srcData/rasterData", "AOI_1_Rio/srcData/vectorData"]
# # dirs_needed["X"] =
#
#
# # Reference: https://spacenetchallenge.github.io/
# # dirs_needed: ["AOI_1_Rio/srcData/rasterData", "AOI_1_Rio/srcData/vectorData"]
# mkdir -p AOI_1_Rio/srcData/rasterData
# mkdir -p AOI_1_Rio/srcData/vectorData
# # keys to download
# # keys
# aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/processedData/processedBuildingLabels.tar.gz --request-payer requester AOI_1_Rio/processedData/processedBuildingLabels.tar.gz
# aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/3-Band.tar.gz --request-payer requester AOI_1_Rio/srcData/rasterData/3-Band.tar.gz
# aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/8-Band.tar.gz --request-payer requester AOI_1_Rio/srcData/rasterData/8-Band.tar.gz
# aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz --request-payer requester AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz
#
# # keys to unzip
# tar -xzf AOI_1_Rio/processedData/processedBuildingLabels.tar.gz
# tar -xzf AOI_1_Rio/srcData/rasterData/3-Band.tar.gz
# tar -xzf AOI_1_Rio/srcData/rasterData/8-Band.tar.gz
# tar -xzf AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz
#
# # nested keys to unzip
# tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/3band.tar.gz
# tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/8band.tar.gz
# tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/vectordata/geojson.tar.gz
# tar -xzf AOI_1_Rio/processedData/processedBuildingLabels/vectordata/summarydata.tar.gz
#
# find . -name "*.tar.gz" -type f -delete
# #
# aws s3 cp AOI_1_Rio/ s3://raster-vision/datasets/spacenet/AOI_1_Rio/ --recursive --exclude ".*"
#
# # dirs needed
# mkdir AOI_2_Vegas
# echo "==> Getting Vegas data from s3://spacenet-dataset"
# aws s3api get-object --bucket spacenet-dataset --key AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz --request-payer requester AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz
# echo "==> Unzipping Vegas data locally"
# tar -xzf AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz
# find . -name "*.tar.gz" -type f -delete
# echo "==> Copying Vegas data to your bucket"
# aws s3 cp AOI_2_Vegas/ s3://raster-vision/datasets/spacenet/AOI_2_Vegas/ --recursive --exclude ".*"
# # delete vegas data locally
#
# mkdir AOI_3_Paris
# aws s3api get-object --bucket spacenet-dataset --key AOI_3_Paris/AOI_3_Paris_Train.tar.gz --request-payer requester AOI_3_Paris/AOI_3_Paris_Train.tar.gz
# tar -xzf AOI_3_Paris/AOI_3_Paris_Train.tar.gz
# find . -name "*.tar.gz" -type f -delete
# aws s3 cp AOI_3_Paris/ s3://raster-vision/datasets/spacenet/AOI_3_Paris/ --recursive --exclude ".*"
#
#
mkdir AOI_4_Shanghai
aws s3api get-object --bucket spacenet-dataset --key AOI_4_Shanghai/AOI_4_Shanghai_Train.tar.gz --request-payer requester AOI_4_Shanghai/AOI_4_Shanghai_Train.tar.gz
tar -xzf AOI_4_Shanghai/AOI_4_Shanghai_Train.tar.gz
find . -name "*.tar.gz" -type f -delete
aws s3 cp AOI_4_Shanghai/ s3://raster-vision/datasets/spacenet/AOI_4_Shanghai/ --recursive --exclude ".*"

#
#
mkdir AOI_5_Khartoum
aws s3api get-object --bucket spacenet-dataset --key AOI_5_Khartoum/AOI_5_Khartoum_Train.tar.gz --request-payer requester AOI_5_Khartoum/AOI_5_Khartoum.tar.gz
tar -xzf AOI_5_Khartoum/AOI_5_Khartoum_Train.tar.gz
find . -name "*.tar.gz" -type f -delete
aws s3 cp AOI_5_Khartoum/ s3://raster-vision/datasets/spacenet/AOI_5_Khartoum/ --recursive --exclude ".*"
#
# echo "==> Data is synced with your bucket!"
