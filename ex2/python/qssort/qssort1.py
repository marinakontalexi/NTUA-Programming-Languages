from collections import deque

def next(s):
    if s[1]:
        c = int(s[1][0])
        yield (s[0] + tuple([c]), s[1][1:], s[2] + ['S'])
    if s[0]:
        c = int(s[0][0])
        yield (s[0][1:], tuple([c]) + s[1], s[2] + ['Q'])

def isSorted(s):
    for i in range(len(s) - 1):
        if (int(s[i]) > int(s[i+1])): return False
    return True

init = tuple([input().split()]), tuple([]), []

Q = deque([init])
prev = set()
solved  = False

while Q:
    s = Q.popleft()
    if not s[1] and isSorted(s[0]):
        solved = True
        break
    for t in next(s):
        if str(t[2]) not in prev:
            Q.append(t)
            prev.add(str(t[2]))
k = ""
print(k.join(s[2]))
