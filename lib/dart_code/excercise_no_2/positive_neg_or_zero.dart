import 'dart:io';

void main() {
  int num;
  stdout.write("Enter Any Number:");
  num = int.parse(stdin.readLineSync()!);
  if (num < 0) {
    print("The Given Number is Negative");
  } else if (num > 0) {
    print("The Given Number is Positive");
  } else {
    print("The Given Number is Zero");
  }
}
