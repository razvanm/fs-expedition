#!/usr/bin/env python

import sys
import glob
import subprocess

all = set()
allfs = {}
for o in glob.glob(sys.argv[1] + '/*.o'):
    fs = o.split('/')[1]
    output = subprocess.Popen(['nm', o], stdout=subprocess.PIPE).communicate()[0]
    for line in output.split('\n'):
        v = line.split()
        if len(v) > 1 and v[0] == 'U':
            all.add(v[1])
            if fs not in allfs:
                allfs[fs] = set()
            allfs[fs].add(v[1])

print len(allfs), len(all)
for i in allfs.keys():
    print i.split('.')[0],
    s = ''
    for j in all:
        if j in allfs[i]: s += '1 '
        else: s += '0 '
    print s

