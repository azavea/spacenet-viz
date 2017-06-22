#!/bin/bash

# This scripts bootstraps each node in the the EMR cluster to install GeoPySpark
sudo yum install geos-devel -y
sudo pip-3.4 install geopyspark
sudo touch /usr/local/lib/python3.4/site-packages/geopyspark/command/geopyspark.conf
sudo chmod 777 /usr/local/lib/python3.4/site-packages/geopyspark/command/geopyspark.conf
sudo touch /usr/local/lib/python3.4/site-packages/geopyspark/jars/geotrellis-backend-assembly-0.1.0.jar
sudo chmod 777 /usr/local/lib/python3.4/site-packages/geopyspark/jars/geotrellis-backend-assembly-0.1.0.jar
geopyspark install-jar
