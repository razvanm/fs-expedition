#!/usr/bin/env python

import sys

if len(sys.argv) != 3:
    print "Usage: %s summary.tux3 System.map" % sys.argv[0]
    sys.exit()

color = {'D': 'red', 'R': 'orange', 'B': 'lyellow', 'T': 'green', 'U': 'lgrey'}
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

modules['vmlinux'] = set()
for t in ['D', 'R', 'T', 'B']:
    modules['vmlinux'].update(system[t])
s = [k for (_, k) in sorted([(len(v), k) for (k,v) in modules.items()])]
for i in s:
    fs = i.rstrip('.o')
    print 'chr - %s %s 0 %d' % (fs, fs, len(modules[i]))
offset = 0
for i in s:
    fs = i.rstrip('.o')
    offset = 0
    for t in ['D', 'R', 'B', 'T']:
        l = len(modules[i].intersection(system[t]))
        if l > 0:
            print 'band %s %s.%s %s.%s %d %d %s' % (fs, fs, t, fs, t, offset, offset+l, color[t])
        offset += l
    l = len(modules[i].difference(system['D']).difference(system['R']).difference(system['T']).difference(system['B']))
    if l > 0:
        print 'band %s %s.%s %s.%s %d %d %s' % (fs, fs, 'U', fs, 'U', offset, offset+l, color['U'])


