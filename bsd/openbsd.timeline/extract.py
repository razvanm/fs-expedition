#!/usr/bin/env python

import glob
import os.path
from datetime import datetime
from collections import defaultdict

last = 0
print 'release major index date'
for f in glob.glob('*/i386/MD5'):
    version = f.split('/')[0]
    major = version.split('.')[0]
    date = datetime.fromtimestamp(os.path.getmtime(f)).strftime('%d-%b-%Y')
    print version, major, version.split('.')[1], date

