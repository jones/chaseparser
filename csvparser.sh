#!/usr/bin/env python

import argparse, os, csv

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
f = open(args.filename, 'r')
reader = csv.reader(f)

reader = reader[1::]


f.close()
