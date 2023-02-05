#include <iostream>
#include <vector>
#include <list>
#include <set>
#include <cstdio>
using namespace std;

void print(const vector<std::list<int>> &adjList)//pass by const reference
{
    for(std::size_t i = 0; i < adjList.size(); i++)
    {
        std::cout << i << ": ";
        for(auto &j : adjList[i])//range based for loop to iterate through adjList[i] and use the reference j to refer to each element
        {
            std::cout << j << ' ';
        }
        std::cout << '\n';
    }
}

bool path(int i, set<int> &exit, set<int> &nonexit, vector<list<int>> array, set<int> &neighbours) {
  int next_node = array[i].back();
  //cout << "next" << next_node << endl;
  if (neighbours.find(i) != neighbours.end() || nonexit.find(i) != nonexit.end()) return false;
  neighbours.insert(i);
  if (exit.find(i) != exit.end()) return true;
  return path (next_node, exit, nonexit, array, neighbours);
}

int main(int argc, char *argv[]) {
  FILE *f;
  if ((f = fopen("loop_rooms-trivial-maze11.txt", "rt")) == nullptr)
    return 1;

  int N, M;
  fscanf(f, "%d %d", &N, &M);

  set<int> exit, nonexit;
  vector<list<int>> array;
  for (int i = 0;  i < N; i++) {
    for (int j = 0; j < M; j++) {
      int current = i*M + j;
      char c;
      list<int> l1;
      if ((c = fgetc(f)) == '\n') c = fgetc(f);
      switch(c) {
        case 'U': {
          if (i == 0) exit.insert(current);
          else l1.push_back(current - M);
          array.push_back(l1);
          break;
        }
        case 'D': {
          if (i == N - 1) exit.insert(current);
          else l1.push_back(current + M);
          array.push_back(l1);
          break;
        }
        case 'R': {
          if (j == M - 1) exit.insert(current);
          else l1.push_back(current + 1);
          array.push_back(l1);
          break;
        }
        case 'L': {
          if (j == 0) exit.insert(current);
          else l1.push_back(current - 1);
          array.push_back(l1);
          break;
        }
      }
    }
  }
  fclose(f);
  //print(array);

  for (int i = 0; i < N*M; i++) {
    set<int>::iterator itr;
    set<int> neighbours;
    if (exit.find(i) != exit.end() || nonexit.find(i) != nonexit.end()) continue;

    bool flag = path(i, exit, nonexit, array, neighbours);
    if (flag) {
       for (itr = neighbours.begin(); itr != neighbours.end(); itr++)
        exit.insert(*itr);
    }
    else {
      for (itr = neighbours.begin(); itr != neighbours.end(); itr++)
       nonexit.insert(*itr);
   }
  }

  /*set<int>::iterator itr;
  for (itr = nonexit.begin(); itr != nonexit.end(); itr++)
    cout << *itr << endl;*/
  cout << nonexit.size() << endl;
}
