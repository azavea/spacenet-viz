#!/bin/bash

# Reference: https://spacenetchallenge.github.io/
"""
SpaceNet Simple Storage Service (S3) Directory Structure (AOI 1)
-- AOI_1_Rio
    |-- processedData
    |   -- processedBuildingLabels.tar.gz  # Compressed 3band and 8band 200m x 200m tiles with associated building foot print labels                                 # This dataset is the Training Dataset for the first Top Coder Competition
     -- srcData
        |-- rasterData
        |   |-- 3-Band.tar.gz # 3band (RGB) Raster Mosaic for Rio De Jenairo area (2784 sq KM) collected by WorldView-2
        |    -- 8-Band.tar.gz # 8band Raster Mosaic for Rio De Jenairo area (2784 sq KM) collected by WorldView-2
         -- vectorData
            |-- Rio_BuildingLabels.tar.gz # Source Dataset that contains Building the building foot prints traced from the Mosaic
            |-- Rio_HGIS_Metro.gdb.tar.gz  # Source Point of Interest Dataset in GeoDatabase Format.  Best if Used with ESRI
             -- Rio_HGIS_Metro_extract.tar # Source Point of Interest Dataset in GeoJSON with associated .jpg.  Easy to Use without ESRI toolset

SpaceNet Simple Storage Service (S3) Directory Structure (AOI 2-5)
├── AOI_[Num]_[City]_Train
│   ├── geojson
│   │   └── buildings  # Contains GeoJson labels of buildings for each tile
│   ├── MUL            # Contains Tiles of 8-Band Multi-Spectral raster data from WorldView-3
│   ├── MUL-PanSharpen # Contains Tiles of 8-Band Multi-Spectral raster data pansharpened to 0.3m
│   ├── PAN            # Contains Tiles of Panchromatic raster data from Worldview-3
│   ├── RGB-PanSharpen # Contains Tiles of RGB raster data from Worldview-3
│   └── summaryData    # Contains CSV with pixel based labels for each building in the Tile Set.
"""


# For each dataset:
# 1. Recreate directory structure from SpaceNet sie
# 2. For download step on SpaceNet site:
  # a. Run AWS command to download
  # b. Move .tar.gz to right location
  # b. Unzip .tar.gz files, sometimes recursively (.tar.g)
# 3. Remove .tar.gz files
# 4. Upload to bucket
# 5. Delete files

# # AOI 1 - Rio de Janeiro
# # 1.
# mkdir AOI_1_Rio
# mkdir AOI_1_Rio/processedData
# mkdir AOI_1_Rio/srcData
# mkdir AOI_1_Rio/srcData/rasterData
# mkdir AOI_1_Rio/srcData/vectorData
#
# # 2.
# # a.
# # To download processed 200mx200m tiles of AOI 1 (3.4 GB) with associated building footprints do the following:
# aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/processedData/processedBuildingLabels.tar.gz --request-payer requester processedBuildingLabels.tar.gz
#
# # b.
# mv processedBuildingLabels.tar.gz ~/AOI_1_Rio/processedData/
# cd  ~/AOI_1_Rio/processedData/
#
# # c.
# tar -xzf processedBuildingLabels.tar.gz
# cd ~/AOI_1_Rio/processedData/processedBuildingLabels
# tar -xzf 3band.tar.gz
# tar -xzf 8band.tar.gz
#
# cd ~/AOI_1_Rio/processedData/processedBuildingLabels/vectordata
# tar -xzf geojson.tar.gz
# tar -xzf summarydata.tar.gz
#
# cd
#
# # To download the Source Imagery Mosaic (3-band = 2.3 GB and 8-band = 6.5 GB):
# aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/3-Band.tar.gz --request-payer requester 3-Band.tar.gz
# aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/8-Band.tar.gz --request-payer requester 8-Band.tar.gz
#
# mv 3-Band.tar.gz ~/AOI_1_Rio/srcData/rasterData
# mv 8-Band.tar.gz ~/AOI_1_Rio/srcData/rasterData
# cd ~/AOI_1_Rio/srcData/rasterData
#
# mv 3-Band.tar.gz ~/AOI_1_Rio/srcData/
# mv 8-Band.tar.gz ~/AOI_1_Rio/srcData/
# cd  ~/AOI_1_Rio/processedData/
#
# tar -xzf 3-Band.tar.gz
# tar -xzf 8-Band.tar.gz
#
# cd
#
# # To download the Source Vector Data (0.18 GB):
# aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz --request-payer requester Rio_BuildingLabels.tar.gz
#
# mv Rio_BuildingLabels.tar.gz ~/AOI_1_Rio/srcData/vectorData
# cd ~/AOI_1_Rio/srcData/vectorData
#
# tar -xzf Rio_BuildingLabels.tar.gz
#
# cd
#
# find . -name "*.tar.gz" -type f -delete
#
# aws s3 cp AOI_1_Rio/ s3://raster-vision/datasets/spacenet/AOI_1_Rio/ --recursive --exclude ".*"



# AOI 2 - Vegas
# 1.
"""
Simple Storage Service (S3) Directory Structure (AOI 2-5)
├── AOI_[Num]_[City]_Train
│   ├── geojson
│   │   └── buildings  # Contains GeoJson labels of buildings for each tile
│   ├── MUL            # Contains Tiles of 8-Band Multi-Spectral raster data from WorldView-3
│   ├── MUL-PanSharpen # Contains Tiles of 8-Band Multi-Spectral raster data pansharpened to 0.3m
│   ├── PAN            # Contains Tiles of Panchromatic raster data from Worldview-3
│   ├── RGB-PanSharpen # Contains Tiles of RGB raster data from Worldview-3
│   └── summaryData    # Contains CSV with pixel based labels for each building in the Tile Set.
"""
mkdir AOI_2_Vegas


# 2.
# a.
# To download processed 200mx200m tiles of AOI 2 (23 GB) with associated building footprints do the following:
aws s3api get-object --bucket spacenet-dataset --key AOI_2_Vegas/AOI_2_Vegas_Train.tar.gz --request-payer requester AOI_2_Vegas_Train.tar.gz


# b.
mv processedBuildingLabels.tar.gz ~/AOI_1_Rio/processedData/
cd  ~/AOI_1_Rio/processedData/

# c.
tar -xzf processedBuildingLabels.tar.gz
cd ~/AOI_1_Rio/processedData/processedBuildingLabels
tar -xzf 3band.tar.gz
tar -xzf 8band.tar.gz

cd ~/AOI_1_Rio/processedData/processedBuildingLabels/vectordata
tar -xzf geojson.tar.gz
tar -xzf summarydata.tar.gz

cd

# To download the Source Imagery Mosaic (3-band = 2.3 GB and 8-band = 6.5 GB):
aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/3-Band.tar.gz --request-payer requester 3-Band.tar.gz
aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/rasterData/8-Band.tar.gz --request-payer requester 8-Band.tar.gz

mv 3-Band.tar.gz ~/AOI_1_Rio/srcData/rasterData
mv 8-Band.tar.gz ~/AOI_1_Rio/srcData/rasterData
cd ~/AOI_1_Rio/srcData/rasterData

mv 3-Band.tar.gz ~/AOI_1_Rio/srcData/
mv 8-Band.tar.gz ~/AOI_1_Rio/srcData/
cd  ~/AOI_1_Rio/processedData/

tar -xzf 3-Band.tar.gz
tar -xzf 8-Band.tar.gz

cd

# To download the Source Vector Data (0.18 GB):
aws s3api get-object --bucket spacenet-dataset --key AOI_1_Rio/srcData/vectorData/Rio_BuildingLabels.tar.gz --request-payer requester Rio_BuildingLabels.tar.gz

mv Rio_BuildingLabels.tar.gz ~/AOI_1_Rio/srcData/vectorData
cd ~/AOI_1_Rio/srcData/vectorData

tar -xzf Rio_BuildingLabels.tar.gz

cd

find . -name "*.tar.gz" -type f -delete

aws s3 cp AOI_1_Rio/ s3://raster-vi
