import 'dart:io';
import 'dart:math';

void main() {
  int number, power;
  stdout.write("Enter Any Power:");
  number = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Power:");
  power = int.parse(stdin.readLineSync()!);
  printPower(number, power);
}

void printPower(int number, int power) {
  print("The Number $number having Power $power is =${pow(number, power)}");
}
