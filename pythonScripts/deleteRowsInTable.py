""" Generate SQL to Delete Rows in Table from CSV File

(csv file) -> (sql file)

Returns a SQL file with 1 SQL statement per line in the form:
DELETE FROM table WHERE column1=value1;

Input CSV rows must have the following attributes:
value1
where
value1 = column1.

Other preconditions:
- CSV file must be UTF-8 encoded.
- Text values must be single quoted.

Version 1
Since 19 August 2014
Copyright Mary Chester-Kadwell 2014
Written in Python 3.4 for the Portable Antiquities Scheme database

"""

## Specify your parameters here
table = 'publications'
column = 'id'
fileIn = 'inputs/csvfilename.csv'
fileOut = 'outputs/sqlfilename.sql'

import csv

delete = "DELETE FROM "
where = " WHERE "
equals = '='
end = ";\n"

with open(fileOut, 'w', newline='', encoding='utf-8') as sqlFileOut:
    with open(fileIn, newline='', encoding='utf-8') as csvFileIn:
        myReader = csv.reader(csvFileIn, delimiter=',')
        for row in myReader:
            sqlFileOut.write(delete + table + where + column + equals + row[0] + end)
