#!/usr/bin/env python

import sys

def read(s, x=0.0, depth=0):
    if s[0] != '(':
        # format: name:length
        (n, l) = s.split(':')
        l = float(l)
        print n, x, depth+l
        print 'line', x, depth, x, depth+l
        return (x+1, x)
    elif s[-1] != ')':
        sep = s.rfind(':')
        (n, l) = (s[0:sep], float(s[sep+1:]))
        (nextx, center) = read(n, x, depth+l)
        #print 'line', x, depth+l, nextx-1, depth+l
        print 'line', center, depth, center, depth+l
        return (nextx, center)
    s = s[1:-1]
    counter = 0
    stops = [-1]
    for i in range(len(s)):
        if s[i] == '(':
            counter += 1
        elif s[i] == ')':
            counter -= 1
        elif s[i] == ',' and counter == 0:
            stops.append(i)
    stops.append(i)
    children = []
    nextx = x
    centers = []
    for (i, j) in zip(stops[:-1], stops[1:]):
        (nextx, center) = read(s[i+1:j+1].strip(','), nextx, depth)
        centers.append(center)
    print 'line', min(centers), depth, max(centers), depth
    return (nextx, sum(centers)/len(centers))

all = []
line = sys.stdin.readline().strip()
while line[-1] != ';':
    all.append(line)
    line = sys.stdin.readline().strip()
all.append(line)
tree = ''.join(all) 
read(tree[0:tree.rfind(')')+1])


