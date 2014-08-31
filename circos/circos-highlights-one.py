#!/usr/bin/env python

import sys

if len(sys.argv) < 2:
    print "Usage: %s msdos.o < summary.tux3" % (sys.argv[0])
    sys.exit()

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
scale = float(len(symbols))
i = sys.argv[1]
fs1 = i.strip('.o')
for j in s:
    fs2 = j.strip('.o')
    if fs1 != fs2:
        inter = len(all[i].intersection(all[j]))*scale/len(all[i])
        print '%s %d %d' % (fs2, (scale-inter)/2, (scale+inter)/2)


