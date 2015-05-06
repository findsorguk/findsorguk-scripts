""" Generate SQL to Update Columns in Table from CSV File

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
table = 'publications'
fileIn = 'inputs/csvfilename.csv'
fileOut = 'outputs/sqlfilename.sql'

import csv

update = 'UPDATE '
setclause = ' SET '
where = ' WHERE '
equals = '='
comma = ', '
end = ';\n'

with open(fileOut, 'w', newline='', encoding='utf-8') as sqlFileOut:
    with open(fileIn, newline='', encoding='utf-8') as csvFileIn:
        myReader = csv.reader(csvFileIn, delimiter='|')
        firstLine = True
        columnNames = []
        for row in myReader:
            if firstLine == True:
                for item in row:
                    columnNames.append(item)
                firstLine = False;
            else:
                columns = ''
                idcolumn = columnNames[-1] + equals + row[-1]
                for item in range(0,len(columnNames)-2):
                    columns = columns + columnNames[item] + equals + row[item] + comma
                columns = columns + columnNames[-2] + equals + row[-2]
                sqlFileOut.write(update + table + setclause + columns + where + idcolumn + end)
