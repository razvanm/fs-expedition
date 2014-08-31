#!/usr/bin/env python

import sys

print 'version major minor date time'
line = sys.stdin.readline()
while line:
    line = line.replace('-dontuse', '')
    line = line.replace('linux-pre', 'linux-')
    line = line.replace('-pre', '.')
    v = line.split()
    #print v
    ver = v[1].split('"')[1].split('-')[1].split('.')[0:-2]
    minor = 0
    if len(ver) > 3:
        minor = ver[3]
    if len(ver) < 3:
        ver.append('0')
    print '.'.join(ver), ver[2], minor, v[2], v[3]
    line = sys.stdin.readline()
