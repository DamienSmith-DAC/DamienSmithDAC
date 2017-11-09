# Establish Spark Context
library(sparklyr)
Sys.setenv(SPARK_HOME="/usr/hdp/current/spark2-client/")
.libPaths(c(file.path(Sys.getenv("SPARK_HOME"),"R","lib"),.libPaths()))
sc <- spark_connect(master = "yarn-client", spark_home = Sys.getenv("SPARK_HOME"), method = c("shell"), app_name = "sparklyr", version = NULL, hadoop_version = NULL, config = spark_config(), extensions = sparklyr::registered_extensions())

# Connect to a table in Hive
library(dplyr)
library(DBI)
dbGetQuery(sc, "show databases")
dbGetQuery(sc, "show tables")
#table = tbl(sc, "table_name")
table = tbl(sc, "pkmn_stats")
table

# When you finish a session please disconnect with one of the two commands
spark_disconnect_all()
