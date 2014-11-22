#!/usr/bin/env python

import argparse, datetime, os, csv

def is_valid_file(path, argparser):
    if not os.path.exists(path):
        raise argparse.ArgumentError("{0} does not exist".format(x))
    return path;

# Argument parsing
parser = argparse.ArgumentParser(description="Chase CSV parser")
parser.add_argument("-f", "--file", dest="filename", required=True,
                    type=lambda x:is_valid_file(x, parser),
                    help="CSV file to parse", metavar="FILENAME")
args = parser.parse_args()

# CSV reader
# Each transaction is a 5-tuple of:
# ('Type', 'Trans Date', 'Post Date', 'Description', 'Amount')
f = open(args.filename, 'r')
transactions = [row for row in csv.reader(f)][1:]

# Sort the transactios by transaction date
strptime = datetime.datetime.strptime
transactions = sorted(transactions, key=lambda row: strptime(row[1], "%m/%d/%Y"))

totalSpending = 0.0
totalPayment = 0.0
for trans in transactions:
    type, transDate, postDate, desc, amount = trans
    type = type.upper()
    amount = float(amount)

    if type == 'SALE':
        totalSpending += amount
    elif type == 'RETURN':
        totalSpending -= amount
    elif type == 'PAYMENT':
        totalPayment += amount

print("Total credit card spending is: %s" % totalSpending)
print("Total credit card payment is: %s" % totalPayment)

f.close()
