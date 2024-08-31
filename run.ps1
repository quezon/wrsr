psql -h localhost -U postgres -d postgres -a -q -f init.sql
python normalizer.py
python spreadsheet_data_save.py