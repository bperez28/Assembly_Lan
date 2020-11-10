#ifndef CONVERT_B_H_D_H
#define CONVERT_B_H_D_H

#include <iostream>
#include <string>
using namespace std;

// Bryan Perez
// cs66
// LAB 2

string bin_to_dec(string s) {
	int x = 0;
	int y = 0;
    for (int i = s.length() - 1; i >=0; i--) {

		//if string at index is 1 than just add w/ multi by 2
		if (s.at(i) == '1') {
			if (i == s.length() - 1) {
				x++;
			}
			else {
				//y needs to start at 1 cuz 0 will make it inval
				y = 1;
				//loop until the number of index, condi subtract to get index  
				for (int w = 0; w < s.length() - 1 - i; w++) {
					y = y * 2;
				}
				//add temp result(y) to total(x)
				x = x + y;
			}

		}
	}
	//to_sting is a library function that converts to string
	return to_string(x);

}
string dec_to_hex(string str) {
	string s = "";
	int x = atoi(str.c_str());
	//condition to stop when x when divided by 16 =0
	while (x != 0) {
		//% to get remender
		x = x % 16;
		//if dec is 1-9 just add it to string
		if (x < 9 && x != 0) {
			s = to_string(x % 16)+s;
		}
		else {
			//switch is a if else conditions
			//that passes a value to to brake it down
			//to sections
			switch (x) {
			case 10:s ="A"+ s;
				break;
			case 11:s = "B"+s;
				break;
			case 12:s = "C"+s;
				break;
			case 13:s = "D"+ s;
				break;
			case 14:s ="E"+s;
				break;
			case 15:s = "F"+s;
				break;

			}
		}
		//divided by 16 to get the next value 
		x = x / 16;
	}
	return s;

}
string dec_to_bin(string str){
	string s = "";
	int x = atoi(str.c_str());
	//stays in the loop til
    if(x==0){
        s="0";
    }else{
	while (x != 0) {
		if (x % 2 == 1) {
			s ="1"+s;

		}
		else if (x % 2 == 0) {
			s = "0"+s;
		}
		//divid to get next value
		x = x / 2;
	}
    }
	return s;
}
string hex_to_dec(string s) {
	//initialize
	int x = 0;
	int result = 0;
	int y = 0;
	//for loop to real string backwords
	for (int i = s.length() - 2; i > 0; i--) {
		//reset x value
		x = 0;
		//switch passes through char at string 
		//index
		
		//if the index isnt zero
		if (s.at(i)!= '0') {
			switch (s.at(i))
			{
			case '1': x = 1;
				break;
			case '2': x = 2;
				break;
			case '3': x = 3;
				break;
			case '4': x = 4;
				break;
			case '5': x = 5;
				break;
			case '6': x = 6;
				break;
			case '7': x = 7;
				break;
			case '8': x = 8;
				break;
			case '9': x = 9;
				break;
			case 'A': x = 10;
				break;
			case 'B': x = 11;
				break;
			case 'C': x = 12;
				break;
			case 'D': x = 13;
				break;
			case 'E': x = 14;
				break;
			case 'F': x = 15;
				break;
			default:
				break;
			}
			//if its not the zero index
			if (i != s.length() - 2) {
				//resets y value
				y = 1;
				//muti 16 everytime depending of the index 
				for (int w = 0; w < s.length() - 2 - i; w++) {
					y = y * 16;
				}
				//multi by the number and the 16 exp
				x = x * y;
			}
			//adding each loop
			result = result + x;
		}



	}
	//converting int to string
	return to_string(result);
}
string any_base_to_dec(string s, string base) {
	int x = 0;
	int y = 0;
	int b = atoi(base.c_str());
	for (int i = s.length() - 1; i > 0; i--) {

		//if string at index is 1 than just add w/ multi by 2
		if (s.at(i) != '0') {
			if (i == s.length() - 1) {
				x++;
			}
			else {
				//y needs to start at 1 cuz 0 will make it inval
				y = 1;
				//loop until the number of index, condi subtract to get index  
				for (int w = 0; w < s.length() - 1 - i; w++) {
					y = y * b;
				}
				//add temp result(y) to total(x)
				x = x + y;
			}

		}
	}
	//to_sting is a library function that converts to string
	return to_string(x);
}
string dec_to_any_base(string s, string base) {
	string r = "";
	int x = atoi(s.c_str());

	int b = atoi(base.c_str());

	//stays in the loop til
	while (x != 0) {
		r = to_string(x%b)+r;

		//divid to get next value
		x = x / b;
	}

	return r;
}
string add_any_base(string num1, string num2, string base) {
	//converts result of function to int
	//than adds them
	int x = atoi(any_base_to_dec(num1, base).c_str()) +
		atoi(any_base_to_dec(num2, base).c_str());
	//converts dec to any base and returns result
	return dec_to_any_base(to_string(x), base);
}
#endif // CONVERT_B_H_D_H

