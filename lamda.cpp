
#include <random>
#include <iostream>
#include <vector>

// 实现argsort功能
template<typename T> std::vector<int> argsort(const std::vector<T>& array)
{
	const int array_len(array.size());
	std::vector<int> array_index(array_len, 0);
	for (int i = 0; i < array_len; ++i)
		array_index[i] = i;

	std::sort(array_index.begin(), array_index.end(),
		[&array](int pos1, int pos2) {return (array[pos1] < array[pos2]);});

	return array_index;
}

int main(){

std::default_random_engine generator;
std::uniform_int_distribution<int> distribution(1, 20);
std::vector<int> vec_data;
for (int i = 0; i < 10; ++i)
	vec_data.push_back(distribution(generator));
for (int item : vec_data)
	std::cout << item << "\t";
std::vector<int> index = argsort(vec_data);
std::cout << std::endl;
for (int item : index)
	std::cout << item << "\t";
return 0;
}
