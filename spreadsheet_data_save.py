from sqlalchemy import create_engine
import numpy as np
import pandas as pd
import ezodf
import re
import os

header=0
engine = create_engine('postgresql://wrsr:wrsr3423@localhost:5432/wrsr')
file = ezodf.opendoc(filename="normalized tables.ods")

os.makedirs('csv', exist_ok=True)

num = 0
while (True):
	try:
		num = int(input("Enter 1 for csv, 2 for sql, 3 for both: "))
		if num >= 1 and num <= 3:
			break
	except:
		print("Please enter 1,2 or 3 only")


for sheet in file.sheets:
	tab = file.sheets[sheet.name]

	df = pd.DataFrame({col[header].value:[x.value for x in col[header+1:]] for col in tab.columns()})

	curr_idx=0
	for cell in tab.row(0):
		if curr_idx == 0:
			df = df[df[cell.value].notna()]
		if "is_" in cell.value:
			df[cell.value] = df[cell.value].replace({1: True, 0: False})
		if "_id" in cell.value:
			df[cell.value] = pd.to_numeric(df[cell.value])
			df[cell.value] = df[cell.value].astype("Int32")
		curr_idx += 1	

	if num == 1 or num == 3:
		df.to_csv('csv/' + sheet.name + '.csv',index=False)
		df.to_sql(sheet.name, engine, if_exists='replace', index=False)
	if num == 2:
		df.to_sql(sheet.name, engine, if_exists='replace', index=False)
	if num == 1:
		df.to_csv('csv/' + sheet.name + '.csv',index=False)