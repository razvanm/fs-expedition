#!/usr/bin/env python

import sys
import glob
import subprocess

all = set()
allfs = {}
for d in glob.glob('../linux-2.6.*.obj'):
    ver = d.split('.')[-2]
    for o in glob.glob(d + '/*.o'):
        fs = o.split('/')[-1].split('.')[0][0:7] + '-' + ver
        output = subprocess.Popen(['nm', o], stdout=subprocess.PIPE).communicate()[0]
        for line in output.split('\n'):
            v = line.split()
            if len(v) > 1 and v[0] == 'U':
                all.add(v[1])
                if fs not in allfs:
                    allfs[fs] = set()
                allfs[fs].add(v[1])

#print len(allfs), len(all)
for i in allfs.keys():
    print i.ljust(10),
    s = ''
    for j in all:
        if j in allfs[i]: s += '1'
        else: s += '0'
    print s

