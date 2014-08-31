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
result = []
root = 0
for k in s:
    fs2 = k.strip('.o')
    if fs1 != fs2:
        l1 = scale*len(all[i].intersection(all[k]))/len(all[i])
        l2 = scale*len(all[k].intersection(all[i]))/len(all[k])
        root += l1
        result.append((fs2, l1, l2))
space = scale*0.1
rootscale = (scale-space)/root
space = space/(len(result) - 2)
counter = 0
root = 0
result.sort()
for (fs2, l1, l2) in reversed(result):
    if fs1 > fs2:
        l1 = rootscale*l1
        print 'seg%06d %s %d %d' % (counter, fs1, root, root+l1-space)
        print 'seg%06d %s %d %d' % (counter, fs2, scale/2-l2/2, scale/2+l2/2)
        root += l1 + space
        counter += 1
for (fs2, l1, l2) in reversed(result):
    if fs1 < fs2:
        l1 = rootscale*l1
        print 'seg%06d %s %d %d' % (counter, fs1, root, root+l1-space)
        print 'seg%06d %s %d %d' % (counter, fs2, scale/2-l2/2, scale/2+l2/2)
        root += l1 + space
        counter += 1


