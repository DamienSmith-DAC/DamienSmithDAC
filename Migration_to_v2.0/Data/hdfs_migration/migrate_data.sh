
#!/bin/bash

# Script to migrate data from v1.1 to v2.0 production (DACE2)

kinit hdfs-dace2@DAC.LOCAL -kt /etc/security/keytabs/hdfs.headless.keytab
hadoop distcp -D ipc.client.fallback-to-simple-auth-allowed=true -pugp hdfs://10.20.13.178:8020/user hdfs://10.74.12.120:8020/user
hadoop distcp -D ipc.client.fallback-to-simple-auth-allowed=true -pugp hdfs://10.20.13.178:8020/raw hdfs://10.74.12.120:8020/raw
hadoop distcp -D ipc.client.fallback-to-simple-auth-allowed=true -pugp hdfs://10.20.13.178:8020/staging hdfs://10.74.12.120:8020/staging
hadoop distcp -D ipc.client.fallback-to-simple-auth-allowed=true -pugp hdfs://10.20.13.178:8020/projects hdfs://10.74.12.120:8020/projects
hadoop distcp -D ipc.client.fallback-to-simple-auth-allowed=true -pugp hdfs://10.20.13.178:8020/apps/hive/warehouse hdfs://10.74.12.120:8020/apps/hive/warehouse