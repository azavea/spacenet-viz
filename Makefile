include config-aws.mk # Vars related to AWS credentials and services used
include config-emr.mk # Vars related to type and size of EMR cluster
include config-run.mk # Vars related to ingest step and spark parameters

ifeq ($(USE_SPOT),true)
MASTER_BID_PRICE:=BidPrice=${MASTER_PRICE},
WORKER_BID_PRICE:=BidPrice=${WORKER_PRICE},
BACKEND=accumulo
endif

ifdef COLOR
COLOR_TAG=--tags Color=${COLOR}
endif

ifndef CLUSTER_ID
CLUSTER_ID=$(shell if [ -e "cluster-id-${EMR_TAG}.txt" ]; then cat cluster-id-${EMR_TAG}.txt; fi)
endif

rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

upload-code: deployment/emr/bootstrap-geopyspark.sh
	@aws s3 cp deployment/emr/bootstrap-geopyspark.sh ${S3_URI}/
	@aws s3 cp src/ingest/ingest.py ${S3_URI}/

load-local:
	scripts/load_development_data.sh

create-cluster:
	aws emr create-cluster --name "${NAME}" ${COLOR_TAG} \
--release-label emr-5.6.0 \
--output text \
--use-default-roles \
--configurations "file://$(CURDIR)/deployment/emr/configurations.json" \
--log-uri ${S3_URI}/logs \
--ec2-attributes KeyName=${EC2_KEY},SubnetId=${SUBNET_ID} \
--applications Name=Ganglia Name=Hadoop Name=Hue Name=Spark Name=Zeppelin \
--instance-groups \
'Name=Master,${MASTER_BID_PRICE}InstanceCount=1,InstanceGroupType=MASTER,InstanceType=${MASTER_INSTANCE}' \
'Name=Workers,${WORKER_BID_PRICE}InstanceCount=${WORKER_COUNT},InstanceGroupType=CORE,InstanceType=${WORKER_INSTANCE}' \
--bootstrap-actions Name=install-geopyspark,Path=${S3_URI}/bootstrap-geopyspark.sh \
| tee cluster-id-${EMR_TAG}.txt

ingest-paris:
	aws emr add-steps --output text --cluster-id ${CLUSTER_ID} \
--steps Type=CUSTOM_JAR,Name="SpaceNet Ingest: Paris ${NAME}",Jar=command-runner.jar,Args=[\
spark-submit,--master,yarn-cluster,\
--class,rastervision.viz.ingest.Ingest,\
--driver-memory,${EXECUTOR_MEMORY},\
--driver-cores,${EXECUTOR_CORES},\
--executor-memory,${EXECUTOR_MEMORY},\
--executor-cores,${EXECUTOR_CORES},\
--conf,spark.driver.maxResultSize=4g,\
--conf,spark.dynamicAllocation.enabled=true,\
--jars,"/usr/local/lib/python3.4/site-packages/geopyspark/jars/geotrellis-backend-assembly-0.1.0.jar",\
${S3_URI}/ingest.py,\
--input,${INPUT_PARIS},\
--catalog,${S3_CATALOG},\
--name,"spacenet-paris-imagery",\
--partitions,5000\
] | cut -f2 | tee last-step-id.txt

ingest-dsm:
	aws emr add-steps --output text --cluster-id ${CLUSTER_ID} \
--steps Type=CUSTOM_JAR,Name="IngestDEM",Jar=command-runner.jar,Args=[\
spark-submit,--master,yarn-cluster,\
--class,rastervision.viz.ingest.Ingest,\
--driver-memory,${DRIVER_MEMORY},\
--driver-cores,${DRIVER_CORES},\
--executor-memory,${EXECUTOR_MEMORY},\
--executor-cores,${EXECUTOR_CORES},\
--conf,spark.driver.maxResultSize=3g,\
--conf,spark.dynamicAllocation.enabled=true,\
--conf,spark.yarn.executor.memoryOverhead=${YARN_OVERHEAD},\
--conf,spark.yarn.driver.memoryOverhead=${YARN_OVERHEAD},\
${S3_URI}/${RVVIZ_INGEST_ASSEMBLY_NAME},\
--inputPath,${INPUT_DSM},\
--catalogPath,${S3_CATALOG},\
--layerPrefix,"isprs-potsdam-dsm",\
--type,"DSM",\
--numPartitions,2000\
] | cut -f2 | tee last-step-id.txt


wait: INTERVAL:=60
wait: STEP_ID=$(shell cat last-step-id.txt)
wait:
	@while (true); do \
	OUT=$$(aws emr describe-step --cluster-id ${CLUSTER_ID} --step-id ${STEP_ID}); \
	[[ $$OUT =~ (\"State\": \"([A-Z]+)\") ]]; \
	echo $${BASH_REMATCH[2]}; \
	case $${BASH_REMATCH[2]} in \
			PENDING | RUNNING) sleep ${INTERVAL};; \
			COMPLETED) exit 0;; \
			*) exit 1;; \
	esac; \
	done

terminate-cluster:
	aws emr terminate-clusters --cluster-ids ${CLUSTER_ID}
	rm -f cluster-id.txt
	rm -f last-step-id.txt

clean:
	./sbt clean -no-colors

proxy:
	aws emr socks --cluster-id ${CLUSTER_ID} --key-pair-file "${HOME}/${EC2_KEY}.pem"

ssh:
	aws emr ssh --cluster-id ${CLUSTER_ID} --key-pair-file "${HOME}/${EC2_KEY}.pem"

local-ingest-all: local-ingest-paris
	@echo ${LOCAL_CATALOG}

local-ingest-paris:
	spark-submit --name "SpaceNet Ingest: Paris ${NAME}" \
		--master "local[4]" --driver-memory 4G --class rastervision.viz.ingest.Ingest \
		--conf spark.driver.extraJavaOptions="-Djava.library.path=/usr/local/lib" \
		--conf spark.executor.extraJavaOptions="-Djava.library.path=/usr/local/lib" \
		--jars $(shell geopyspark jar-path -a) \
		${LOCAL_INGEST_SCRIPT_PATH} \
		--input ${LOCAL_PARIS_PATH} \
		--catalog ${LOCAL_CATALOG} \
		--name "spacenet-paris-imagery" \
		--partitions 50

get-logs:
	@aws emr ssh --cluster-id $(CLUSTER_ID) --key-pair-file "${HOME}/${EC2_KEY}.pem" \
		--command "rm -rf /tmp/spark-logs && hdfs dfs -copyToLocal /var/log/spark/apps /tmp/spark-logs"
	@mkdir -p  logs/$(CLUSTER_ID)
	@aws emr get --cluster-id $(CLUSTER_ID) --key-pair-file "${HOME}/${EC2_KEY}.pem" --src "/tmp/spark-logs/" --dest logs/$(CLUSTER_ID)

.PHONY: local-ingest ingest get-logs
