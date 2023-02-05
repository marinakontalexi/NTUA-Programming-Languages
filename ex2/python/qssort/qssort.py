from collections import deque
import sys

def next(s):
    if s[0]:
        c = int(s[0][0])
        yield (s[0][1:], tuple([c]) + s[1], s[2] + ['Q'])
    if s[1]:
        c = int(s[1][0])
        yield (s[0] + tuple([c]), s[1][1:], s[2] + ['S'])

def isSorted(s):
    for i in range(len(s) - 1):
        if (int(s[i]) > int(s[i+1])): return False
    return True

f = open(sys.argv[1], 'r')
N = int(f.readline())
init = tuple(list(f.readline().split())), tuple([]), []

Q = deque([init])
prev = set()
solved  = False

while Q:
    s = Q.popleft()
    if not s[1] and isSorted(s[0]):
        solved = True
        break
    for t in next(s):
        if ((t[0], t[1])) not in prev:
            Q.append(t)
            prev.add((t[0],t[1]))
if s[2] == []: print("empty")
else: print("".join(s[2]))
