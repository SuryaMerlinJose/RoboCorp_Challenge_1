# import pandas as pd 
import csv

import re
 
def fetch_login_data(data):
    username_match = re.search(r'(?:Sales App Username:\s)([^\s]+)', data)
    password_match = re.search(r'Sales App Password:\s([^\n]+)', data)
 
    if username_match:
        username = username_match.group(1)
        print(f'Username: {username}')
      
    if password_match:
        password = password_match.group(1)
        print(f'Password: {password}')
    return    username, password

# fetch_login_data('''Sales App Login
# Sales App Username: douglasmcgee@catchycomponents.com
# Sales App Password: i7D32S&37K*W''')








def shipment_csv(shipment_excel):
    # data={'track_no': 'TR-10157-100', 'ship_date': '03/11/2022', 'ship_status': 'Delivered'}
    # data=[{'track_no': 'TR-10157-100', 'ship_date': '03/11/2022', 'ship_status': 'Delivered'}, {'track_no': 'TR-10157-100', 'ship_date': '03/11/2022', 'ship_status': 'Delivered'}]
    data=   shipment_excel
    with open('ship1.csv', 'a', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=data[0].keys())
        if f.tell()==   0:
            writer.writeheader()

        for d in data:    
            writer.writerow(d)
# shipment_csv([{'track_no': 'TR-10157-100', 'ship_date': '03/11/2022', 'ship_status': 'In Transmit'}, {'track_no': 'TR-10157-100', 'ship_date': '03/11/2022', 'ship_status': 'Returned'}])


