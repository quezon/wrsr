from pyexcel_ods3 import get_data, save_data
from collections import OrderedDict

def get_col_id_idx(head_row):
	for i in range(0,len(head_row)):
		if "_id" in head_row[i]:
			return i

data_old = get_data("denormalized tables.ods")

denormalized_tables = ['transportation_build_resource_requirements','transportation_cargo_capacity','construction_linear_costing']
normalized_tables = []
denormalized_tables_start_col_idx = [1,1,1]
denormalized_tables_row_count = []

for i in range(0,len(denormalized_tables)):
	denormalized_tables_row_count.insert(i,len(data_old[denormalized_tables[i]]))
	
for j in range(0,len(denormalized_tables)):
	row_count = denormalized_tables_row_count[j]
	head_row = data_old[denormalized_tables[j]][0]
	col_id_idx = get_col_id_idx(head_row)
	normalized_tables.insert(j,{denormalized_tables[j]:[]})
	normalized_tables[j][denormalized_tables[j]].append([head_row[col_id_idx],'resource','qty'])
	for k in range(1, row_count):
		row = data_old[denormalized_tables[j]][k]
		col_count = len(row)
		if( col_count > 0):
			for l in range(denormalized_tables_start_col_idx[j],col_count):
				if row[l] != "":
					normalized_tables[j][denormalized_tables[j]].append([row[col_id_idx],head_row[l],row[l]])

for m in normalized_tables:
	data_old.update(m)

data_old.pop("flats")
data_old.pop("resource_supply")

save_data("normalized tables.ods",data_old)		