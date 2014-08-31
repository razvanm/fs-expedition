#!/usr/bin/env python

import sys

line = sys.stdin.readline() # skip the header
line = sys.stdin.readline()
all = {}
while line:
    v = line.split()
    if v[0] not in all:
        all[v[0]] = set()
    all[v[0]].add(v[1])
    line = sys.stdin.readline()

s = [k for (_, k) in sorted([(len(v), k) for (k,v) in all.items()])]
print ' '.join(reversed(s))
for i in s:
    print i,
    for j in reversed(s):
        print len(all[i].intersection(all[j])),
    print
