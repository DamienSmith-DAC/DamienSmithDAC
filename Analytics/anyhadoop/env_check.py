target = open('anyhadoop/env', 'r')
vars = [x.replace('\n', '') for x in target]
for var in vars:
    if var.startswith('cdsw=') == True:
        cdsw=var.split('=')[1]
    if var.startswith('vendor=') == True:
        vendor=var.split('=')[1]

if vendor.lower() != 'cloudera':
	if cdsw == 'true':
		raise Exception('Cloudera is the only platform that supports cdsw. Please change your env file accordingly.')
	else:
		pass
else:
	print 'Creating %s cluster...' % vendor



	
#Large enough size for cdsw
