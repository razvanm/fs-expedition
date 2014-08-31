#!/usr/bin/env python

import sys
import glob
import subprocess
from collections import defaultdict

all = defaultdict(lambda : {'D':0, 'R':0, 'T':0, 'B':0})
for o in glob.glob('*/kernel'):
    release = o.split('/')[0]
    output = subprocess.Popen(['nm', o], stdout=subprocess.PIPE).communicate()[0]
    for line in output.split('\n'):
        v = line.split()
        if len(v) > 1 and v[1] in ['D', 'R', 'T', 'B']:
            all[release][v[1]] += 1

s = sorted(set(all.keys()))
order = dict(zip(s, range(1,len(s)+1)))
print 'index release data rodata text bss'
for (release, v) in all.items():
    print order[release], release, v['D'], v['R'], v['T'], v['B']
