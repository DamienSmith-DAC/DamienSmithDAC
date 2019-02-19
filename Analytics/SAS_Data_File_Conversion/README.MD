## Purpose
Convert SAS data files in .sas7bdat format to CSV files

## Python Packages used
Two Python packages are used for this purpose which can be downloaded from the following URLs

http://central.maven.org/maven2/com/epam/parso/2.0.10/parso-2.0.10.jar

http://dl.bintray.com/spark-packages/maven/saurfang/spark-sas7bdat/2.1.0-s_2.11/spark-sas7bdat-2.1.0-s_2.11.jar

More information about the spark-sas7bdat package can be found here https://github.com/saurfang/spark-sas7bdat

## How to run the code
The code creates a spark session, iterates over files on the platform, convert them to CSV using the above mentioned packages and finally saves them as CSV on the platform. 

To execute the code, run the following command 

```Python
spark-submit --jars spark-sas7bdat-2.1.0-s_2.11.jar,parso-2.0.10.jar sas  sas_to_csv_conversion.py | tee /tmp/sas_to_csv_conversion.log
```
## Making changes in Code
To change the code for your purpose, you might need to change just a few variables, primarily the ones mentioned below 
```python
# Directory where SAS data files reside
source_dir 
# Direcotry where the converted files (CSV) files will reside
target_dir = "/user/baiga/sas_data/converted_files/"
# The extension of the files that are to be read by the program from the source directory
file_ext = "sas7bdat"
```

## Caveats
spark-csv writes out null as "null" in csv text output. This means if you read it back for a string type, you might actually read "null" instead of null. The safest option is to export in parquet format where null is properly recorded. See https://github.com/databricks/spark-csv/pull/147 for alternative solution.

## Reference

[Convert SAS data file to CSV](https://nswdac.atlassian.net/wiki/spaces/TEC/pages/edit-v2/876314971)

[Iterate over HDFS files in Python and Pyspark](https://nswdac.atlassian.net/wiki/spaces/TEC/pages/876282290/Iterate+over+HDFS+files+in+Python+and+Pyspark)
