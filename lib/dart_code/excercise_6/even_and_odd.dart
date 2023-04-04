import 'dart:io';

void main() {
  int number;
  stdout.write("Enter Number:");
  number = int.parse(stdin.readLineSync()!);
  if (number % 2 == 0) {
    print("Even Number");
  } else {
    print("Odd Number");
  }
}
