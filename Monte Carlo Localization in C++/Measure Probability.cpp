#include <iostream>

using namespace std;

double w[] = { 0.6, 1.2, 2.4, 0.6, 1.2 };//You can also change this to a vector
double sum;
//TODO: Define a  ComputeProb function and compute the Probabilities
void measureprob(double w[], int n) {
	for (int i = 0; i < n; i++) {
		sum += w[i];
	}
	for (int i = 0; i < 5; i++) {
		w[i] = w[i] / sum;
		cout << "P" << i + 1 << "=" << w[i] << endl;
	}
}





int main()
{
	//TODO: Print Probabilites each on a single line:
	//P1=Value
	//:
	//P5=Value
	measureprob(w, sizeof(w) / sizeof(w[0]));
	return 0;
}
