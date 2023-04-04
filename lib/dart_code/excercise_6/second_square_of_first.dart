import 'dart:io';

void main() {
  int firstNumber;
  int secondNumber;

  stdout.write("Enter First Number:");
  firstNumber = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Second Number:");
  secondNumber = int.parse(stdin.readLineSync()!);
  if (firstNumber * firstNumber == secondNumber) {
    print("Second is Square of First");
  } else {
    print("Second Number is Not Square of First");
  }
}
