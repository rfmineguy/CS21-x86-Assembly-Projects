#include <iostream>
#include "myFuncs.h"

void printArray(long long array[], long long size);

int main() {
	long long ARRAY_SIZE = 10;
	int arrayTotal = 0;					//just for storing the total from the 'addArray' function. not being passed to any function
	long long array[ARRAY_SIZE] = {0, 45, 32};
	
	long long array1[ARRAY_SIZE] = {93, 41, 42, 874, 1};
	long long array2[ARRAY_SIZE] = {312, 942, 76, 42, 4, 43, 90, 2};
	
	//addTwo function testing
	std::cout << "=============================\n";
	std::cout << "Test#1:\n";
	std::cout << "addTwo(...)\n";
	std::cout << "Sum of 9 and 3 = " << addTwo(9, 3) << "\n\n";
	
	std::cout << "Test#2:\n";
	std::cout << "addTwo(...)\n";
	std::cout << "Sum of 3124982 and 383152 = " << addTwo(3124982, 383152) << "\n\n";


	//addArray function testing
	std::cout << "=============================\n";
	std::cout << "Test#1\n";
	std::cout << "addArray(...)\n";
	printArray(array, ARRAY_SIZE);
	arrayTotal = addArray(array, ARRAY_SIZE);
	std::cout << "Array total : " << arrayTotal << "\n\n";

	std::cout << "Test#2\n";
	std::cout << "addArray(...)\n";
	printArray(array2, ARRAY_SIZE);
	arrayTotal = addArray(array2, ARRAY_SIZE);
	std::cout << "Array total : " << arrayTotal << "\n\n";

	//swapArrays function testing
	std::cout << "=============================\n";
	std::cout << "Test:\n";
	std::cout << "swapArrays(...)\n";
	std::cout << "Original\n";
	std::cout << "\tArray1 => ";
	printArray(array1, ARRAY_SIZE);
	std::cout << "\tArray2 => ";
	printArray(array2, ARRAY_SIZE);
	
	swapArrays(array1, array2, ARRAY_SIZE);
	
	std::cout << "Swapped\n";
	std::cout << "\tArray1 => ";
	printArray(array1, ARRAY_SIZE);
	std::cout << "\tArray2 => ";
	printArray(array2, ARRAY_SIZE);

	std::cout << "\n\n";
	std::cout << "Program ending" << std::endl;
}

void printArray(long long array[], long long size) {
	std::cout << "Array [";
	for (int i = 0; i < size; i++) {
		std::cout << array[i];
		if (i != size-1)
			std::cout << ", ";
	}
	std::cout << "]" << std::endl;
}
