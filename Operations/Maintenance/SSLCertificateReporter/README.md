# How to run? #

To run the report generator:

ansible-playbook -i conf/cluster_hosts.prod.ini src/create_cluster_certificates_report.yml


# Outputs #

./combined_report.csv: Contains the details for .crt files on all hosts in the file passed to the -i argument. The columns are hostname, crt_file, expiry_date

