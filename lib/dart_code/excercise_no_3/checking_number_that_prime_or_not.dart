import 'dart:io';

void main() {
  checkNumber();
}

void checkNumber() {
  int number;
  stdout.write("Please Enter A Number:");
  number = int.parse(stdin.readLineSync()!);
  if (number / number == 0) {
    print("Yes This Is Prime");
  } else {
    print("Not Prime");
  }
}
