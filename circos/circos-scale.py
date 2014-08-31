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
l = [len(all[i]) for i in s]
scale = 1/float(max(l))
l = [i*scale for i in l]
print ';'.join(['%s:%.4f' % (fs.strip('.o'), scale) for (fs, scale) in zip(s, l)])
# for i in s:
#     fs = i.strip('.o')
#     print fs, float(len(all[i]))/(symbols)


