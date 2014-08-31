#!/usr/bin/env python

import sys

if len(sys.argv) != 3:
    print "Usage: %s summary.tux System.map" % sys.argv[0]
    sys.exit()

system = {}
for line in file(sys.argv[2]):
    v = line.split()
    if v[1] in ['D', 'R', 'T', 'B']:
        if v[1] not in system:
            system[v[1]] = set()
        system[v[1]].add(v[2])

f = file(sys.argv[1])
line = f.readline() # skip the header
line = f.readline()
symbols = {}
while line:
    v = line.split()
    if v[1] != '__this_module':
        symbols[v[1]] = symbols.get(v[1], 0) + 1
    line = f.readline()

counter = 0
for t in ['D', 'R', 'T', 'B']:
    for i in system[t]:
        if i in symbols:
            print 'vmlinux %d %d %d' % (counter, counter+1, symbols[i])
        counter += 1
