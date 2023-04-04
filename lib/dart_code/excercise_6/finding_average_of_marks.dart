import 'dart:io';

void main() {
  int firstSubMarks, secondSubMarks, thirdSubMarks;
  int sum;

  stdout.write("Enter First Subject Marks:");
  firstSubMarks = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Second Subject Marks:");
  secondSubMarks = int.parse(stdin.readLineSync()!);
  stdout.write("Enter Third Subject Marks:");
  thirdSubMarks = int.parse(stdin.readLineSync()!);
  sum = firstSubMarks + secondSubMarks + thirdSubMarks ~/ 3;
  if (sum >= 40) {
    print("Admission Granted!");
  } else {
    print("Sorry Next Time!");
  }
}
