


import 'dart:io';

void main(){
  int number;


  stdout.write("Enter Your Desired Number:");

  number=int.parse(stdin.readLineSync()!);
  print("The Square of Your Entered Number =${number*number}");




}