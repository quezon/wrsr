#!/bin/sh

psql -h localhost -U postgres -d postgres -a -q -f init_pg.sql

python normalizer.py
python spreadsheet_data_save.py

psql -h localhost -U postgres -d wrsr -a -q -f ./pg/construction_resources.sql