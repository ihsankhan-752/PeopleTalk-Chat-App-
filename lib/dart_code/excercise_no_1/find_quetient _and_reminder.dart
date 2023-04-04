import 'dart:io';

void main() {
  int num1;
  int num2;
  int quotient;
  int reminder;
  stdout.write("Enter First Number:");
  num1 = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Second Number:");
  num2 = int.parse(stdin.readLineSync()!);
  quotient = num1 ~/ num2;
  reminder = num1 % num2;
  print("The Quotient Of Two Numbers is:$quotient");
  print("The Reminder Of Two Numbers is:$reminder");
}
