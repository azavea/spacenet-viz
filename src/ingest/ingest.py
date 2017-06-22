import sys
import argparse
from geopyspark.geopycontext import GeoPyContext
from geopyspark.geotrellis.constants import SPATIAL, ZOOM
from geopyspark.geotrellis.catalog import write
from geopyspark.geotrellis.geotiff_rdd import get

def ingest(args):
    geopysc = GeoPyContext(appName="spacenet-ingest")

    print(args.input)
    # Read the GeoTiff from S3
    rdd = get(geopysc, SPATIAL, args.input)
    # rdd = get(geopysc, SPATIAL, "/Users/rob/proj/az/spacenet-viz/data/paris.tif")

    metadata = rdd.collect_metadata()

    # tile the rdd to the layout defined in the metadata
    laid_out = rdd.tile_to_layout(metadata)

    # reproject the tiled rasters using a ZoomedLayoutScheme
    reprojected = laid_out.reproject("EPSG:3857", scheme=ZOOM)

    # pyramid the TiledRasterRDD to create 12 new TiledRasterRDDs
    # one for each zoom level
    pyramided = reprojected.pyramid(start_zoom=reprojected.zoom_level, end_zoom=1)

    # Save each TiledRasterRDDs locally
    for tiled in pyramided:
        write(args.catalog, args.name, tiled)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input', required=True, metavar='INPUT', help='Input path to files (s3 or local)')
    parser.add_argument('-c', '--catalog', required=True, metavar='CATALOG', help='Catalog path to ingest to (s3 or local)')
    parser.add_argument('-n', '--name', required=True, metavar='NAME', help='Layer name')
    parser.add_argument('-p', '--partitions', required=True, metavar='Partitions', help='Number of partitions')
    args = parser.parse_args()
    ingest(args)
