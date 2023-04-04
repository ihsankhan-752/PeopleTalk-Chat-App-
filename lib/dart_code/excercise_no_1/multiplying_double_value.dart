import 'dart:io';

void main() {
  double x1;
  double x2;

  stdout.write("Enter First Number:");
  x1 = double.parse(stdin.readLineSync()!);
  stdout.write("Enter Second Number:");
  x2 = double.parse(stdin.readLineSync()!);
  print("The Multiplication of Two Numbers that you Entered is :${x1 * x2}");
}
