#!/usr/bin/env python

import sys

s = sys.argv[1].split()

line = sys.stdin.readline() # skip the header
line = sys.stdin.readline()
all = {}
while line:
    v = line.split()
    if v[0] not in all:
        all[v[0]] = set()
    all[v[0]].add(v[1])
    line = sys.stdin.readline()

empty = set()
print ' '.join(reversed(s))
for i in s:
    print i,
    for j in s:
        if (i in all) and (j in all):
            print len(all[i].union(all[j]))-len(all[i].intersection(all[j])),
        else:
            print -1,
    print
