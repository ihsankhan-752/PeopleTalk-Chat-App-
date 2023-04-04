import 'dart:io';

void main() {
  int num1, num2, num3;
  stdout.write("Enter First Number:");
  num1 = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Second Number:");
  num2 = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Third Number:");
  num3 = int.parse(stdin.readLineSync()!);

  if (num1 > num2 && num1 > num3) {
    print("$num1 is Greater");
  } else if (num2 > num1 && num2 > num3) {
    print("$num2 is Greater");
  } else {
    print("$num3 is Greater");
  }
}
