#!/usr/bin/env python

import glob

print 'major fs type'
for d in glob.glob('linux-2.6.*.obj'):
    major = d.split('.')[2]
    for o in [o.split('/')[1].split('.')[0] for o in glob.glob(d + '/*.o')]:
        print major, o, 'ok'

for f in glob.glob('log-2.6.*'):
    fs = f.split('.')[2]
    for line in file(f):
        if line.startswith('>>>>>'):
            v = line.split()
            if v[1] == 'Skip':
                print fs, v[2][:-2], 'skip'
            elif v[1] == 'Building' and '(2nd' in v:
                print fs, v[2][:-2], 'second'
            elif v[1] == 'Building' and '(1st' in v:
                print fs, v[2][:-2], 'first'
            elif v[1] == 'Building' and '(1ng' in v:
                print fs, v[2][:-2], 'first'
            elif v[1] == 'Building':
                print fs, v[2][:-5], 'first'
