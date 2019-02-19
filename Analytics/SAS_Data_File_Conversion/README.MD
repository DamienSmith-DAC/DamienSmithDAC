# Purpose
Convert SAS data files in .sas7bdat format to CSV files

# Python Packages used
Two Python packages are used for this purpose which can be downloaded from the following URLs
http://central.maven.org/maven2/com/epam/parso/2.0.10/parso-2.0.10.jar
http://dl.bintray.com/spark-packages/maven/saurfang/spark-sas7bdat/2.1.0-s_2.11/spark-sas7bdat-2.1.0-s_2.11.jar

More information about the spark-sas7bdat package can be found here https://github.com/saurfang/spark-sas7bdat

# How to run the code
The code creates a spark session, iterates over files on the platform, convert them to CSV using the above mentioned packages and finally saves them as CSV on the platform. 

To execute the code, run the following command 

```Python
spark-submit --jars spark-sas7bdat-2.1.0-s_2.11.jar,parso-2.0.10.jar sas  sas_to_csv_conversion.py | tee /tmp/sas_to_csv_conversion.log
```
