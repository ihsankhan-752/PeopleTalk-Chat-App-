import 'dart:io';

void main() {
  String choice;

  int num1, num2;

  stdout.write("Enter First Number:");
  num1 = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Second Number:");
  num2 = int.parse(stdin.readLineSync()!);
  stdout.write("""
   +
   -
   %
   /
   *

  """);
  choice = stdin.readLineSync()!;

  switch (choice) {
    case '+':
      print("$num1 + $num2 =${num1 + num2}");
      break;
    case '-':
      print("$num1 - $num2 =${num1 - num2}");
      break;
    case '*':
      print("$num1 * $num2 =${num1 * num2}");
      break;
    case '/':
      print("$num1 / $num2 =${num1 / num2}");
      break;
    case '%':
      print("$num1 % $num2 =${num1 % num2}");
      break;
    default:
      print("Invalid Operator");
  }
}
