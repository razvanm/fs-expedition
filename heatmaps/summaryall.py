#!/usr/bin/env python

import sys
import glob
import subprocess

print 'fs extcall'
for o in glob.glob(sys.argv[1] + 'linux-2.6.*.obj/*.o'):
    major = o.split('/')[-2].split('.')[-2]
    fs = o.split('/')[-1]
    output = subprocess.Popen(['nm', o], stdout=subprocess.PIPE).communicate()[0]
    for line in output.split('\n'):
        v = line.split()
        if len(v) > 1 and v[0] == 'U':
            print '%s-%s %s' % (fs[:-2], major, v[1])
