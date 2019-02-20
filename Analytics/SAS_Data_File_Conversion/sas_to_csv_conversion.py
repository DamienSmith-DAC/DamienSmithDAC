import subprocess
import os
import pyspark
from pyspark.sql import SparkSession

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

source_dir = "/raw/SIRA/PIR/Original/"
target_dir = "/raw/SIRA/PIR/CSV/"
file_ext = "sas7bdat"

cmd = "hdfs dfs -ls " + source_dir + " | grep '/*." + file_ext + "' | sed 's/  */ /g' | cut -d\  -f8"

files = subprocess.check_output(cmd, shell=True).strip().split('\n')
for path in files:
	file_path, file_extension = os.path.splitext(path)
	file_name = file_path[file_path.rfind('/')+1 : ]
	df = spark.read.format("com.github.saurfang.sas.spark").load(path, forceLowercaseNames=True, inferLong=True)
	df.write.csv(target_dir + file_name + '.csv')
        print("File " + path + " copied to " + target_dir + file_name +'.csv')

