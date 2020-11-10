#include <iostream>
#include "../../CS66/LAB3/Project3/convert_b_h_d.h"
#include <vector>
using namespace std;

//--------------------------------
//Bryan Perez
// cs66
//march 29 2019
//---------------------------------

//convert two dec to bin, add them than convert to 8 bit bin
string add_2_dec_to_8bit_bin(string dec1, string dec2);
//convert to dec to 8 bit bin
string dec_to_8bit_bin(string dec);
//adds two bins
string add_2_bin(string str1, string str2);
//reverse add 2 bins
string rev_add_2_bin(string s1, string s2);
//check if carry
string check_carry(string s);
//padding
string pad_8bit_bin(string str1);

//-------this code was not used------------
//covert dec to bin than add them
string add_2_dec_r_bin(string dec1, string dec2);
//convert to bin to 8 bit bin
string bin_to_8bit_bin(string str1);
//-------this code was not used------------


int main(int argc, char *argv[])
{
    string d1 = "9";
    string d2 = "6";
	string result = add_2_dec_to_8bit_bin(d1, d2);
    cout<<endl<<"-----------------------------------"
       <<endl;
    cout<<d1<<"d"<<"+"<<d2<<"d"<<"=";
    cout << result << endl<<endl;


    return 0;
}

//convert two dec to bin, add them than convert to 8 bit bin
string add_2_dec_to_8bit_bin(string dec1, string dec2) {
    //converts decimal to 8 bit binary
    //adds both binarys than checks if it has a carry
    return check_carry(add_2_bin(dec_to_8bit_bin(dec1)
                                 ,dec_to_8bit_bin(dec2)));

}

//convert to dec to 8 bit bin
string dec_to_8bit_bin(string dec){
    string str1="";
    for(int i=dec.length()-1;i>=0;i--){
        //this reads decimal by character
        //than converts it to binary
        str1=dec_to_bin(string (1,dec.at(i)))+str1;
        //this switch statement adds the padding
        str1=pad_8bit_bin(str1);
    }

    return str1;
}

//add two bins
string add_2_bin(string str1, string str2) {
    //reverses both binary numbers
    reverse(str1.begin(),str1.end());
    reverse(str2.begin(),str2.end());
    //easier to add two reverse binary numbers
    return rev_add_2_bin(str1,str2);
}

// adds two reverse bins
string rev_add_2_bin(string s1, string s2) {
    string str1=s1;
    string str2=s2;
    //this makes sure that 1st string is larger
    //since the function in for loop
    //must need it to be
    if(s1.length()-s2.length()<0){
        string temp =str1;
        str1=str2;
        str2=temp;
    }
    //c is the carry
	string c = "";
    string result="";

    for (int i = 0; i <=str1.length()-1 ; i++) {
        //if theres a carry
        if (!c.empty()) {
            if (str1.at(i) == '1') {
                str1.at(i) = '0';
                    //c stays the same since it carrys again
            }else if (str1.at(i) == '0') {
                str1.at(i) = '1';
                    c = "";
            }
         }
        //if the index is smaller than 2nd string
        if (i <= str2.length()-1){
            //each compares the index and decideds if carry is needed
                if (str1.at(i) == '1' && str2.at(i) == '1') {
                    result = "0" + result;
                    c = "1";
                }
                else if (str1.at(i) == '0' && str2.at(i) == '0') {
                    result = "0" + result;
                }
                else {
                    //if both strings at the same index is diff
                    result = "1" + result;
                }
            }else {
            //if index passes 2nd string just add to result
                result = str1.at(i) + result;
            }

        //this checks if the index pass
        if(i==str1.length()-1 && !c.empty()){
            result="1"+result;
        }

    }
    return result;
}

//check if carry
string check_carry(string s){
    string result="";
    string bin_6="0110";
    for(int i=(s.length()-1)/4; i>=0;i--){
        if(s.at((i*4))=='1'){
            if(s.at((i*4)+1)=='1' || s.at((i*4)+2)=='1'){
                result=add_2_bin(s,bin_6)+result;
            }
        }
        bin_6="0000"+bin_6;
    }
    //adds padding to final result
    return pad_8bit_bin(result);
}
//padding
string pad_8bit_bin(string str1){
        //this switch statement adds the padding
        switch((str1.length()-1)%4){
            case 0: str1="000"+str1;
                    break;
            case 1: str1="00"+str1;
                    break;
            case 2: str1="0"+str1;
                    break;
                    }

    return str1;
}


//-------------code not used--------------------------
//convert to bin to 8 bit bin
string bin_to_8bit_bin(string s1) {
    string str1="";
    //converts binary to decimal
    string dec= bin_to_dec(s1);
    for(int i=dec.length()-1;i>=0;i--){
        str1=dec_to_bin(string (1,dec.at(i)))+str1;
        switch((str1.length()-1)%4){
            case 0: str1="000"+str1;
                    break;
            case 1: str1="00"+str1;
                    break;
            case 2: str1="0"+str1;
                    break;
                    }
    }

    return str1;
}

////covert dec to bin than add them
string add_2_dec_r_bin(string dec1, string dec2) {
    //calls decimal to binary for both strings
    //than passes the binary of each to be added
    //in add_2_bin
    return (add_2_bin(dec_to_bin(dec1), dec_to_bin(dec2)));
}
//----------------end of code not used---------------------
