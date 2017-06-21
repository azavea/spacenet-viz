# Query parameters
export DRIVER_MEMORY := 20000M
export DRIVER_CORES := 8
export EXECUTOR_MEMORY := 8400M
export EXECUTOR_CORES := 2
export YARN_OVERHEAD := 300
export EXECUTOR_COUNT := 80
export PARTITION_COUNT := 20000

# export LOCAL_CATALOG := file://${PWD}/data/catalog-hadoop/
export LOCAL_INGEST_SCRIPT_PATH := ${PWD}/src/ingest/ingest.py
export LOCAL_CATALOG := file://${PWD}/data/catalog/
export LOCAL_PARIS_PATH := file://${PWD}/data/

export S3_CATALOG := s3://otid-data/viz/catalog
export INPUT_PARIS := s3://raster-vision/datasets/spacenet/AOI_3_Paris/AOI_3_Paris_Train/MUL-PanSharpen/
