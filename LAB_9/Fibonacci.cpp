#include <iostream>
#include <vector> 
#include <time.h>
using namespace std;
void Fibonacci_n_term(vector<unsigned int> &a, int n);
void  Fibonacci_function(vector<unsigned int> &a, int n, int index);
int main() {
	clock_t tStart = clock();
	vector<unsigned int> f;
	int n = 26;
	f.push_back(1);
	f.push_back(1);
	Fibonacci_n_term(f, n);
	//cout << f.size() << endl;
	cout << f.at(n) << endl;

	printf("Time taken: %.2fs\n", (double)(clock() - tStart) / CLOCKS_PER_SEC);

	return 0;
}
void Fibonacci_n_term(vector<unsigned int> &a, int n) {
	Fibonacci_function(a, n, 0);
}
void  Fibonacci_function(vector<unsigned int> &a, int n, int index) {
	if (index == n) {
		return;
	}
	else {

		unsigned int x = a.at(index);
		unsigned int y = a.at(index + 1);
		index++;
		a.push_back(x + y);
		Fibonacci_function(a, n, index);
	}
}