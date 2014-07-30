""" Generate SQL to Transfer Duplicate Bibliography Entries to Single Entry

(csv file) -> (csv file)

Returns a CSV file with 1 SQL statement per line in the form:
UPDATE bibliography SET pubID='1' WHERE pubID='2';

Input CSV rows must have the following attributes:
value1,value2,value3
where
value1 = duplicate group number
value2 = 1 for preferred entry, empty string for duplicates to transfer
value3 = secuid of publication.

CSV file must be sorted by value1 ascending and then by value2 descending, e.g.
1,1,0011A000010012C1
1,,0011A000010012C3
2,1,0011A0000100112C
2,,0011A00001001257

Version 1
Since 28 July 2014
Copyright Mary Chester-Kadwell 2014
Written in Python 3.4 for the Portable Antiquities Scheme database

"""

import csv

update = "UPDATE bibliography "
setclause = "SET pubID='"
where = "' WHERE pubID='"
end = "';"

with open('test-out.csv', 'w', newline='') as csvFileOut:
    myWriter = csv.writer(csvFileOut, delimiter=',')
    with open('test-bibliographyDuplicates.csv', newline='') as csvFileIn:
        myReader = csv.reader(csvFileIn, delimiter=',')
        changeTo = ''
        changeFrom = ''
        for row in myReader:
            if row[1] == '1':
                changeTo = row[2]
            else:
                changeFrom = row[2]
                myWriter.writerow([update + setclause + changeTo + where + changeFrom + end])
