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
symbols = dict(zip(sorted(symbols), range(len(symbols))))
counter = 0
for i in s:
    fs1 = i.strip('.o')
    for j in all[i]:
        symj = symbols[j]
        for k in s:
            fs2 = k.strip('.o')
            if fs1 != fs2 and j in all[k]:
                print 'seg%06d %s %d %d' % (counter, fs1, symj, symj+1)
                print 'seg%06d %s %d %d' % (counter, fs2, symj, symj+1)
                counter += 1
    break

