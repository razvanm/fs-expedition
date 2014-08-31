#!/usr/bin/env python

import sys

line = sys.stdin.readline() # skip the header
line = sys.stdin.readline()
all = {}
symbols = set()
while line:
    v = line.split()
    if v[0] not in all:
        all[v[0]] = set()
    all[v[0]].add(v[1])
    symbols.add(v[1])
    line = sys.stdin.readline()

s = [k for (_, k) in sorted([(len(v), k) for (k,v) in all.items()])]
for i in s:
    fs = i.strip('.o')
    print 'chr - %s %s 0 %d' % (fs, fs, len(symbols))

symbols = dict(zip(sorted(symbols), range(len(symbols))))
for i in s:
    fs = i.strip('.o')
    for j in all[i]:
        k = symbols[j]
        print 'band %s %s.%d %s.%d %d %d' % (fs, fs, k, fs, k, k, k+1)


