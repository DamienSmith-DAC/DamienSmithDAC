"""
Python Version: 2.7
"""
import subprocess, shlex, re, socket, csv, datetime

#### CONSTANTS ####

REPORT_FILE = '/tmp/__cert_report__.csv'

#### HELPER FUNCTIONS ####

def get_expiry_date(crt_path):
	cmd_spec = shlex.split('openssl x509 -enddate -noout -in ' + crt_path)
	process = subprocess.Popen(cmd_spec, stdout = subprocess.PIPE,
			stderr = subprocess.PIPE)
	process_output = process.communicate()[0]
	# Remove 'notAfter=' that preceeds the date in openssl output.
	# Using rstrip to remove new line at the end of the string
	expiry_date = re.sub('notAfter=', '', process_output.rstrip())
	
	try:
		expiry_datetime = datetime.datetime.strptime(expiry_date, '%b %d %H:%M:%S %Y %Z')
		expiry_date = expiry_datetime.strftime('%Y-%m-%d %H:%M:%S %z')
	except ValueError:
		pass
		# do nothing

	return expiry_date
	

def write_csv(records, path):
	with open(path, 'wb') as dest_file:
		writer = csv.writer(dest_file, delimiter = ',')
		writer.writerows(records)

#### MAIN ####

cmd_spec = shlex.split("find / -name *.crt")
process = subprocess.Popen(cmd_spec, stdout = subprocess.PIPE, 
		stderr = subprocess.PIPE)

crt_list = process.communicate()[0].splitlines()
expiry_dates = [get_expiry_date(crt_file) for crt_file in crt_list]

hostname = socket.gethostname()

report_rows = zip([hostname] * len(crt_list), crt_list, expiry_dates)

write_csv(report_rows, REPORT_FILE)

