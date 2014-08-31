#!/usr/bin/env python

import sys
import glob
import subprocess

all = {}
for o in glob.glob(sys.argv[1] + '/*.o'):
    fs = o.split('/')[-1][0:-2]
    output = subprocess.Popen(['nm', o], stdout=subprocess.PIPE).communicate()[0]
    for line in output.split('\n'):
        v = line.split()
        if len(v) > 1 and v[0] == 'U':
            all[fs] = all.get(fs, 0) + 1

for (fs, n) in all.items():
    print fs, sys.argv[2], n
