# Script used to capture existing users in v1.1 for 'migration'
# v2_users.txt generated using ldapsearch 

import pandas as pd
import numpy as np

with open('/Users/byronallen/Desktop/v2_users.txt', 'r') as users:
    users = users.read()

tokenized = users.split('\n')
tokenized

def ExtractUsers(tokenized_document=None):
    
    sAMAccountName_list=[]
    first_names=[]
    last_names=[]
    
    for x in tokenized_document:
        
        if x.startswith('sAMAccountName:') == True:
            sAMAccountName = x.replace('sAMAccountName:', '').strip()
            sAMAccountName_list.append(sAMAccountName)
        
        if x.startswith('name:') == True:
            name = x.replace('name:', '').split(' ')
            try:
                first_name = name[1]
            except:
                first_name = 'none'
            try:
                last_name = name[2]
            except:
                last_name = 'none'
                
            first_names.append(first_name)
            last_names.append(last_name)
            
    result = zip(sAMAccountName_list, first_names, last_names)
    return result

pd.DataFrame(ExtractUsers(tokenized_document=tokenized), columns=['username','firstname','lastname']).to_csv('filename.csv')
