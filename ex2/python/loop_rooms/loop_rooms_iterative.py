import sys

f = open(sys.argv[1], 'r')
N, M = map(int,f.readline().split())
t = [[] for _ in range(N)]
c = 0

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
        path = set()
        I, J = i, j
        while True:
            if t[I][J] < 0:
                for (K, L) in path: t[K][L] = t[I][J]
                break
            if (I, J) in path:
                for (K, L) in path: t[K][L] = -2
                break
            path.add((I, J))
            I, J = t[I][J] // M, t[I][J] % M
        if t[i][j] == -2: c += 1

print(c)
