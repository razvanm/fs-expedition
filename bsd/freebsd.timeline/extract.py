#!/usr/bin/env python

import glob
import os.path
from datetime import datetime
from collections import defaultdict

all = defaultdict(list)
for line in file('index.html'):
    if line.startswith('<li><b>'):
        v = line.split()
        version = v[0][7:-4]
        major = version.split('.')[0]
        if version != '1.1.5':
            try:
                date = datetime.strptime('01 %s %s' % (v[1].strip('(,'), v[2].split(')')[0]), '%d %B %Y').strftime('%d-%b-%Y')
            except ValueError:
                date = datetime.strptime('01 %s %s' % (v[1].strip('(,'), v[2].split(')')[0]), '%d %b %Y').strftime('%d-%b-%Y')
            all[major].append((version, date))

last = 0
print 'release major index date'
for f in glob.glob('*-RELEASE/README.TXT'):
    version = f.split('-')[0]
    major = version.split('.')[0]
    date = datetime.fromtimestamp(os.path.getmtime(f)).strftime('%d-%b-%Y')
    #print version, major, i, date
    all[major].append((version, date))

for k in sorted(all):
    i = 0
    for (version, date) in sorted(all[k]):
        print version, k, i, date
        i += 1
