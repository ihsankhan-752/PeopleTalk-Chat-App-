import 'dart:io';

void main() {
  int a, b, swap;

  stdout.write("Enter First Number:");
  a = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Second Number:");
  b = int.parse(stdin.readLineSync()!);
  print("Numbers Before Swapping is = $a and $b");

  swap = a;
  a = b;
  b = swap;
  print("Number After Swapping is = $a and $b");
}
