#!/usr/bin/env python

import sys
import glob
import subprocess

print 'fs extcall'
for o in glob.glob(sys.argv[1] + '/*.o'):
    fs = o.split('/')[-1]
    output = subprocess.Popen(['nm', o], stdout=subprocess.PIPE).communicate()[0]
    for line in output.split('\n'):
        v = line.split()
        if len(v) > 1 and v[0] == 'U':
            print fs.rstrip('.o'), v[1]
