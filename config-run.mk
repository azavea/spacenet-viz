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
export INPUT_DSM := s3://otid-data/input/1_DSM_normalisation_geotiff-with-geo/
export INPUT_DSMGT := s3://otid-data/input/geotrellis_generated_dsm/
export INPUT_DSMGTN := s3://otid-data/input/geotrellis_generated_dsm_normalized/
export INPUT_RGBIR := s3://otid-data/input/4_Ortho_RGBIR_geotiff/
export INPUT_LABEL := s3://otid-data/input/5_Labels_for_participants_geotiff/
export INPUT_RESULT_FCN := s3://otid-data/input/viz/fcn_results_4_7_17/
export INPUT_RESULT_UNET := s3://otid-data/input/viz/unet_results_4_7_17/
export INPUT_RESULT_FCNDSM := s3://otid-data/input/viz/fcn_results_irrgdsm_5_20_17-geo/
