#!/bin/bash

# This scripts bootstraps each node in the the EMR cluster to install GeoPySpark

sudo pip-3.4 install geopyspark
sudo geopyspark install-jar
