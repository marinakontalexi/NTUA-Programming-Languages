// C++ implementation of above approach
#include <bits/stdc++.h>
using namespace std;

// Utility Function to find the index
// with maximum difference
int maxIndexDiff(int arr[], int n)
{
	int maxDiff, maxi;
	int i, j;

	int LMin[n], RMax[n];

	// Construct LMin[] such that LMin[i]
	// stores the minimum value
	// from (arr[0], arr[1], ... arr[i])
	LMin[0] = arr[0];
	for (i = 1; i < n; ++i)
		LMin[i] = min(arr[i], LMin[i - 1]);

	// Construct RMax[] such that RMax[j]
	// stores the maximum value
	// from (arr[j], arr[j+1], ..arr[n-1])
	RMax[n - 1] = arr[n - 1];
	for (j = n - 2; j >= 0; --j) 
		RMax[j] = max(arr[j], RMax[j + 1]);


	// Traverse both arrays from left to right
	// to find optimum j - i
	// This process is similar to merge()
	// of MergeSort
	i = 0, j = 0, maxDiff = -1;
	while (j < n && i < n) {
		if (LMin[i] < RMax[j]) {
      if (maxDiff < j - i) {
        maxDiff = j - i;
        maxi = i;
        //if (maxi == 0) maxDiff++;
      }
			j = j + 1;
		}
		else
			i = i + 1;
	}
	return maxDiff;
}

// utility Function which subtracts X from all
// the elements in the array
void modifyarr(int arr[], int n, int x)
{
	for (int i = 0; i < n; i++)
		arr[i] = -arr[i] - x;
}

// Calculating the prefix sum array
// of the modified array
void calcprefix(int arr[], int n)
{
	int s = 0;
	for (int i = 0; i < n; i++) {
		s += arr[i];
		arr[i] = s;
	}
}

// Function to find the length of the longest
// subarray with average >= x
int longestsubarray(int arr[], int n, int x)
{
	modifyarr(arr, n, x);
	calcprefix(arr, n);

	return maxIndexDiff(arr, n);
}

// Driver code
int main()
{
	int M, N, input, ans = -1;
	fstream my_file;

	my_file.open("m.txt", ios::in);
	if (!my_file) {
		 cout << "No such file";
	}
	my_file >> M >> N;
	int c[M+1];
	c[0] = 0;

	for (int i = 0; i < M; i++) {
			my_file >> input;
			c[i+1] = input;
	}
	cout << longestsubarray(c, M+1, N) << endl;

	return 0;
}
