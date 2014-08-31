#!/usr/bin/env python

import sys

if len(sys.argv) != 3:
    print "Usage: %s summary.tux3 System.map" % sys.argv[0]
    sys.exit()

system = {}
for line in file(sys.argv[2]):
    v = line.split()
    if v[1] in ['D', 'R', 'T', 'B']:
        if v[1] not in system:
            system[v[1]] = set()
        system[v[1]].add(v[2])

for i in system.keys():
    f = file('data/vmlinux/%s' % i, 'w')
    f.write(' ' * 4 * 1024 * len(system[i]))
    f.close()

f = file(sys.argv[1])
line = f.readline() # skip the header
line = f.readline()
modules = {}
while line:
    v = line.split()
    if v[1] != '__this_module':
        if v[0] not in modules:
            modules[v[0]] = set()
        modules[v[0]].add(v[1])
    line = f.readline()

for i in modules.keys():
    f = file('data/%s' % i.rstrip('.o'), 'w')
    f.write(' ' * 4 * 1024 * len(modules[i]))
    f.close()
