import 'dart:io';

void main() {
  int marks;
  stdout.write("Please Enter your Marks:");
  marks = int.parse(stdin.readLineSync()!);

  if (marks >= 40) {
    print("Congratulations! You Have Passed");
  } else {
    print("Try Again");
  }
}
