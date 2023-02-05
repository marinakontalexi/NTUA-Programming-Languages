#include <stdio.h>
#include <iostream>
#include <vector>

using namespace std;

int main(){
    int M, N, input, ans = -1;
    double sum = 0;
    vector<int> beds;

    cin >> M >> N;
    for (int i = 0; i < M; i++) {
        cin >> input;
        beds.push_back(input);
    }

    for (int start = 0; start < M; ++start) {
      for (int end = start; end < M; ++end) {
        sum += beds[end];
        if (sum / ((end-start+1)*N) <= -1 && end - start + 1 > ans) ans = end - start + 1;
      }
      sum = 0;
    }
    cout << ans << endl;
  }
