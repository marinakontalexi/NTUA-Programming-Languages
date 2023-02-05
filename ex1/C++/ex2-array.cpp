#include <iostream>
#include <cstdio>
using namespace std;

int path(int i, int j, int *array[], int M) {
  if (array[i][j] == -1) return -1;
  if (array[i][j] == -2) return -2;
  if (array[i][j] == -3) {
    array[i][j] = -2;
    return -2;
  }
  int I = array[i][j]/M, J = array[i][j] % M;
  array[i][j] = -3;
  array[i][j] = path(I, J, array, M);
  return array[i][j];
}

int main(int argc, char *argv[]) {
  FILE *f;
  if ((f = fopen(argv[1], "rt")) == nullptr)
    return 1;

  int N, M, counter = 0;
  fscanf(f, "%d %d", &N, &M);
  int *array[N];
  bool *seen[N];

  for (int i = 0;  i < N; i++) {
    array[i] = new int[M];
    seen[i] = new bool[M];
    for (int j = 0; j < M; j++) {
      seen[i][j] = false;
      char c;
      if ((c = fgetc(f)) == '\n') c = fgetc(f);
      switch(c) {
        case 'U': {
          if (i == 0) array[i][j] = -1;
          else array[i][j] = (i-1)*M + j;
          break;
        }
        case 'D': {
          if (i == N - 1) array[i][j] = -1;
          else array[i][j] = (i+1)*M + j;
          break;
        }
        case 'R': {
          if (j == M - 1) array[i][j] = -1;
          else array[i][j] = i*M + j+1;
          break;
        }
        case 'L': {
          if (j == 0) array[i][j] = -1;
          else array[i][j] = i*M + j-1;
          break;
        }
      }
    }
  }
  fclose(f);

  for (int i = 0; i < N; i++)
    for (int j = 0; j < M; j++) {
      array[i][j] = path(i, j, array, M);
      if (array[i][j] == -2) counter++;
    }
  cout << counter << endl;
}
