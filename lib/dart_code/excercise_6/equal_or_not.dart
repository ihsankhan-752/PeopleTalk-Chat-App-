import 'dart:io';

void main() {
  int myNumber = 15;
  int number;
  stdout.write("Enter Number:");
  number = int.parse(stdin.readLineSync()!);
  if (number == myNumber) {
    print("Numbers are equal");
  } else {
    print("Not Equal");
  }
}
