#include <iostream>
#include <string>
#include "convert_b_h_d.h"

using namespace std;

//Bryan Perez
//cs66
//3/14
//lab 3

string convert_hex_to_bin(string h);
string type_of_eflag(string s);
int main() {
	//long varA = 1;
	//long varB = 2;
	//long varC = 3;
	//long varD = 4;
	//varA = (5 + 10);
	//varA = varB - varC;
	//system("pause");
	string str = "00000A16";
	//convert_hex_to_bin calls hex to dec 
	//than dec to bin
	string bin = convert_hex_to_bin(str);
	//type_of_eflag reads binary and runs it 
	//through a switch to return the flags
	string result = type_of_eflag(bin);
	cout <<endl<< result << endl;
}
//convert_hex_to_bin calls hex to dec 
	//than dec to bin
string convert_hex_to_bin(string h) {
	//converts hex to dec
	//d is the result in dec
	string d=hex_to_dec(h);
	//converts dec to bin 
	//result is in bin
	string result = dec_to_bin(d);
	return result;
}
string type_of_eflag(string s) {
	string result="";
	//reads the string backwards
	for (int i = s.length() - 1; i >=0; i--) {
		//if at the index its 1
		if (s.at(i)=='1') {
			int x = s.length()-i;
			//if the index matches it hold it in results
			switch (x) {
			case 1:	result = result + "CF ";
				break;
			case 3:	result = result + "PF ";
				break;
			case 5:	result = result + " AF ";
				break;
			case 7:	result = result + "ZF ";
				break;
			case 8:	result = result + "SF ";
				break;
			case 9:	result = result + "TF ";
				break;
			//case 10:	result = result + "IF ";
				//break;
			case 11:	result = result + "DF  ";
				break;
			case 12:	result = result + "OF ";
				break;
			case 13:
			case 14: result = result + "IOPL ";
				break;
			case 15:	result = result + "NT ";
				break;
			case 17:	result = result + "RF ";
				break;
			case 18:	result = result + "VM ";
				break;
			case 19:	result = result + "AC ";
				break;
			case 20:	result = result + "VIF ";
				break;
			case 21:	result = result + "VIP ";
				break;
			case 22:	result = result + "ID ";
				break;
			}
		}
	}
	return result;
}

