# anyhadoop

### Description

anyhadoop aims to become a go-to-source for any hadoop related deployment scripts. It was written off the back of the development of a POC Cloudera cluster. It can be used to create a cluster of any size within the limits of the below assumptions. 

After building required infrastructure on Azure, anyhadoop will provision nodes with appropriate software and settings. However, the user will need to run Cloudera Manager or Ambari Wizard on the master node in order to fully install their choice.

anyhadoop uses a mix of Azure's CLI for Mac, bash, expect and python. 

### Assumptions
- Using Azure 
- CentOS 7.3 VMs by default 
- Choice between Hortonworks and Cloudera vendors
- User has a basic understanding of big data infrastructure 

### Instructions 
- Edit 'env' file
- Execute '~/anyhadoop/run'
- Cluster details stored in 'clusters'

### Author
Byron Allen (byron.allen@servian.com)
