import 'dart:io';

void main() {
  findCircleArea();
}

void findCircleArea() {
  //A =Pir2
  int number;
  double area;
  const double PI = 3.14;
  stdout.write("Enter Radius of Circle:");
  number = int.parse(stdin.readLineSync()!);
  area = PI * (number * number);
  print("Area Of A Circle is=$area");
}
