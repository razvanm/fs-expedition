#!/usr/bin/env python

import sys
import glob
import subprocess

all = {}
for o in glob.glob('*/*'):
    release = o.split('/')[0]
    fs = o.split('/')[-1]
    if fs.endswith('.ko'):
        fs = fs[0:-3]
    if fs == 'kernel':
        continue
    output = subprocess.Popen(['nm', o], stdout=subprocess.PIPE).communicate()[0]
    for line in output.split('\n'):
        v = line.split()
        if len(v) > 1 and v[0] == 'U':
            all[(fs, release)] = all.get((fs, release), 0) + 1

s = sorted(set([release for (_, release) in all.keys()]))
order = dict(zip(s, range(1,len(s)+1)))
print 'index fs release extsyms'
for ((fs, release), n) in all.items():
    print order[release], fs, release, n
