#include <stdio.h>
#include <iostream>
#include <fstream>

using namespace std;

void mMerge(int c[][2], int start, int mid, int end) {
  int NL = mid - start + 1, NR = end - mid;
  int L[NL][2], R[NR][2];

  for(int i = 0; i < NL; i++) {
    L[i][0] = c[start + i][0];
    L[i][1] = c[start + i][1];
  }
  for(int i = 0; i < NR; i++) {
    R[i][0] = c[mid + 1 + i][0];
    R[i][1] = c[mid + 1 + i][1];
  }

  int i = 0, j = 0;
  while (i < NL && j < NR) {
    if (L[i][0] <= R[j][0]) {
      c[start][0] = L[i][0];
      c[start][1] = L[i][1];
      i++;
    }
    else {
      c[start][0] = R[j][0];
      c[start][1] = R[j][1];
      j++;
    }
    start++;
  }

  while (i < NL) {
    c[start][0] = L[i][0];
    c[start][1] = L[i][1];
    i++;
    start++;
  }

  while (j < NR) {
    c[start][0] = R[j][0];
    c[start][1] = R[j][1];
    j++;
    start++;
  }
  return;
}

void mSort(int c[][2], int start, int end) {
  if (start >= end) return;
  int mid = start + (end - start)/2;
  mSort(c, start, mid);
  mSort(c, mid + 1, end);
  mMerge(c, start, mid, end);
  return;
}

int main(int argc, char *argv[]){
    int M, N, input, ans = -1;
    fstream my_file;

    my_file.open("meth.txt", ios::in);
    if (!my_file) {
       cout << "No such file";
    }

    my_file >> M >> N;
    int c[M+1][2], newarr[M+1];
    c[0][0] = 0;
    c[0][1] = 0;

    for (int i = 0; i < M; i++) {
        my_file >> input;
        c[i+1][0] = -input - N;
        c[i+1][1] = i+1;
    }

    for (int i = 1; i < M+1; i++) c[i][0] += c[i-1][0];

    mSort(c, 0, M);

    newarr[M] = c[M][1];
    for (int i = M - 1; i >= 0; i--) {
      newarr[i] = max(c[i][1], newarr[i+1]);
    }

    for (int i = 0; i < M+1; i++){
      ans = max(ans, newarr[i] - c[i][1]);
    }

    cout << ans << endl;
}
