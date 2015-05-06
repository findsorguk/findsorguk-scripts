""" Generate SQL to insert columns in Table from CSV File

(csv file) -> (sql file)

Returns a SQL file with 1 SQL statement per line in the form:
UPDATE table SET column1=value1,column=value2,... WHERE idcolumn=value;

Input CSV rows must have the following attributes:
value1|value2|value3|...
separated by a vertical bar (|),
in the same order as the columns in the SQL statement,
and with the WHERE clause value in the last position.

Other preconditions:
- CSV file must be UTF-8 encoded.
- The first line should hold the names of the columns.
- Strings must be single quoted, except in column names in the first line.
- Integers must not be quoted.
- Any 'NULL' strings must be converted to NULL values.

Version 2
Since 30 July 2014
Copyright Mary Chester-Kadwell 2014
Written in Python 3.4 for the Portable Antiquities Scheme database

"""
## Specify your parameters here
table = 'objects'
fileIn = 'amaraImport/objects.csv'
fileOut = 'amaraImport/objects.sql'

import csv

insert = 'INSERT '
intoclause = 'INTO '
values = ' VALUES '
openPar = '('
closePar = ')'
delimiter = ','
end = ';\n'

with open(fileOut, 'w', newline='', encoding='utf-8') as sqlFileOut:
    with open(fileIn, newline='', encoding='utf-8') as csvFileIn:
        myReader = csv.reader(csvFileIn, delimiter=',')
        firstLine = True
        columnNames = []
        for row in myReader:
            if firstLine == True:
                for item in row:
                    columnNames.append(item)
                firstLine = False;
            else:
                data = []
                for item in row:
                    data.append(item)
                sql = insert + intoclause + table + openPar + ',' .join(columnNames) + closePar + values + openPar + delimiter .join(data) + closePar + end
                sqlFileOut.write( sql )