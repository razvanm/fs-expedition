#!/usr/bin/env python

import sys

if len(sys.argv) != 3:
    print "Usage: %s summary.tux3 summary.tux3.exported" % sys.argv[0]
    sys.exit()

f = file(sys.argv[1])
line = f.readline() # skip the header
line = f.readline()
external = {}
while line:
    v = line.split()
    if v[1] != '__this_module':
        if v[0] not in external:
            external[v[0]] = set()
        external[v[0]].add(v[1])
    line = f.readline()

f = file(sys.argv[2])
line = f.readline() # skip the header
line = f.readline()
exported = {}
while line:
    v = line.split()
    if v[0] not in exported:
        exported[v[0]] = set()
    exported[v[0]].add(v[1])
    line = f.readline()

counter = 0
for i in external.keys():
    fs1 = i.rstrip('.o')
    for j in exported.keys():
        fs2 = j.rstrip('.o')
        diff = external[i].intersection(exported[j])
        if diff:
            l1 = len(external[i])
            l2 = len(diff)
            print 'seg%02d %s %d %d' % (counter, fs1, l1/2-l2/2, l1/2+l2/2)
            l1 = len(external[j])
            print 'seg%02d %s %d %d' % (counter, fs2, l1/2-l2/2, l1/2+l2/2)
            #print fs1, fs2, len(diff), len(exported[i]), len(exported[j]), len(external[i]), len(external[j])
            counter += 1
