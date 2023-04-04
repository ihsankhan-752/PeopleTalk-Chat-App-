import 'dart:io';

void main() {
  double area, circumference;
  int choice;
  const PI = 3.14;
  //circle = rad * rad * PI
  //circumference= 2 * PI * rad

  double rad;

  stdout.write("Enter Radius:");
  rad = double.parse(stdin.readLineSync()!);
  stdout.write("Enter Choice:");
  choice = int.parse(stdin.readLineSync()!);
  if (choice == 1) {
    area = rad * rad * PI;
    print("circle area = $area");
  } else if (choice == 2) {
    area = 2.0 * PI * rad;
    print("Circumference area = $area");
  } else {
    print("Invalid Choice");
  }
}
