import subprocess
import os
import pyspark
from pyspark.sql import SparkSession

print("Connecting to Spark")

spark = SparkSession.\
        builder.\
        appName("SAS_to_CSV").\
        config('spark.ui.enabled',False).\
        config('spark.sql.shuffle.partitions',1997).\
        config('spark.rpc.askTimeout',600).\
        config('spark.network.timeout',600).\
        config('spark.dynamicAllocation.maxExecutors',12).\
        config('spark.executor.memory','16g').\
        config('spark.driver.maxResultSize', '15G').\
        master("yarn").\
        enableHiveSupport().\
        getOrCreate()

cmd = "hdfs dfs -ls /raw/SIRA/PIR/Original | grep '/*.sas7bdat' | sed 's/  */ /g' | cut -d\  -f8"
files = subprocess.check_output(cmd, shell=True).strip().split('\n')
for path in files:
	file_path, file_extension = os.path.splitext(path)
	file_name = file_path[file_path.rfind('/')+1 : ]
	df = spark.read.format("com.github.saurfang.sas.spark").load(path, forceLowercaseNames=True, inferLong=True)
	df.write.csv('/raw/SIRA/PIR/CSV/' + file_name + '.csv')
        print("-----------------------------------------------------------------------")
        print(file_path + " converted to CSV")
        print("-----------------------------------------------------------------------")

