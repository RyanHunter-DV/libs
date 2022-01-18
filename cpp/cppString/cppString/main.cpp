//
//  main.cpp
//  cppString
//
//  Created by huangqi on 2021/8/1.
//

#include <iostream>
#include "cppString.cpp"

using namespace std;
int main(int argc, const char * argv[]) {
	// insert code here...
	cout << "start main ...\n";
	
	cppString string;
	
	string.append("hello");
	cout<<"string: "<<string.getString()<<endl;
	string.append("world",' ');
	cout<<"appended string: "<<string.getString()<<endl;
	
	return 0;
}
