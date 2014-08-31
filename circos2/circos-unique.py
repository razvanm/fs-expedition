#!/usr/bin/env python

import sys

f = sys.stdin
line = f.readline() # skip the header
line = f.readline()
modules = {}
symbols = set()
while line:
    v = line.split()
    if v[1] != '__this_module':
        if v[0] not in modules:
            modules[v[0]] = set()
        modules[v[0]].add(v[1])
        symbols.add(v[1])
    line = f.readline()

s = modules.keys()
for i in s:
    fs = i.rstrip('.o')
    all = set(modules[i])
    for j in s:
        if i != j:
            all.difference_update(modules[j])
    if len(all):
        print fs, 0, 0, len(all)
        print fs, 0, len(modules[i]), 1000.0*len(all)/len(modules[i])
        print fs, len(modules[i]), len(modules[i]), len(all)
