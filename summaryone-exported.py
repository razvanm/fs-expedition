#!/usr/bin/env python

import sys
import glob
import subprocess

print 'fs expcall'
for o in glob.glob(sys.argv[1] + '/*.o'):
    fs = o.split('/')[1]
    output = subprocess.Popen(['nm', o], stdout=subprocess.PIPE).communicate()[0]
    for line in output.split('\n'):
        v = line.split()
        if len(v) > 1 and v[1] in ['D', 'R', 'B', 'T']:
            print fs, v[2]
