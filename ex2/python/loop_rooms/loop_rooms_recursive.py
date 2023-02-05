import numpy as np
import sys

def path(i, j, t, M):
    me = i*M + j
    if t[i][j] == -1:
        if i != 0 and t[i-1][j] == me: t[i-1][j] = -1
        if i != N-1 and t[i+1][j] == me: t[i+1][j] = -1
        if j != 0 and t[i][j-1] == me: t[i][j-1] = -1
        if j != M-1 and t[i][j+1] == me: t[i][j+1] = -1
        return -1
    if t[i][j] == -2 or t[i][j] == -3:
        if i != 0 and t[i-1][j] == me: t[i-1][j] = -2
        if i != N-1 and t[i+1][j] == me: t[i+1][j] = -2
        if j != 0 and t[i][j-1] == me: t[i][j-1] = -2
        if j != M-1 and t[i][j+1] == me: t[i][j+1] = -2
        return -2
    I, J = t[i][j] // M, t[i][j] % M
    t[i][j] = -3
    t[i][j] = path(I, J, t, M)
    return t[i][j]

f = open(sys.argv[1], 'r')
N, M = map(int,f.readline().split())
result = 0
t = [[] for _ in range(N)]

for i in range(N):
    A = list(f.readline())
    for j in range(M):
        if A[j] == 'U':
            A[j] = (i-1)*M + j if i != 0 else -1
        elif A[j] == 'D':
            A[j] = (i+1)*M + j if i != N-1 else -1
        elif  A[j] == 'R':
            A[j] = i*M + j+1 if j != M-1 else -1
        elif  A[j] == 'L':
            A[j] = i*M + j-1 if j != 0 else -1
    t[i] = A

f.close()
for i in range(N):
    for j in range(M):
        t[i][j] = path(i, j, t, M)
        if t[i][j] == -2: result += 1
print(result)
