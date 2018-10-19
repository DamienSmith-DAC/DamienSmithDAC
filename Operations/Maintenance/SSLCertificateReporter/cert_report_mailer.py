import sys, subprocess, shlex, datetime
import pandas as pd

report_path = sys.argv[1]
dest_path = sys.argv[2]

report = pd.read_csv(report_path, parse_dates = ['expiry_date'])
report.sort_values('expiry_date', inplace = True)

# Only include Approx. 3 months from current date
cutoff_date = datetime.datetime.now() + datetime.timedelta(days = 96)
report = report.loc[report.expiry_date <= cutoff_date , :]

# Exclude files in user home directoris
report = report.loc[~(report.crt_file.str.startswith('/home')), :]

report.to_csv(dest_path, index = False)



#print(report.to_html())

#mail_cmd = 'mail -s "$(echo -e "SSL Certificate Report\nContent-Type: text/html")" -r jordan.finch@treasury.nsw.gov.au jordan.finch@treasury.nsw.gov.au'
#mail_proc = subprocess.Popen(mail_cmd, shell = True, stdin = subprocess.PIPE)
#mail_proc.communicate(report.to_html())


