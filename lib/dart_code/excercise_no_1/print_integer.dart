import 'dart:io';

void main() {
  int a, b, c, d, e, f;
  stdout.write("Enter First Integer:");
  a = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Second Integer:");
  b = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Third Integer:");
  c = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Fourth Integer:");
  d = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Fifth Integer:");
  e = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Sixth Integer:");
  f = int.parse(stdin.readLineSync()!);

  print("You Enter These Digits:$a $b $c $d $e $f");
}
