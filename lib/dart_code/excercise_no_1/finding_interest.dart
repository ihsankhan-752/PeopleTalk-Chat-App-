import 'dart:io';

void main() {
  //interest formula p*t*r/100
  //p is money borrowed
  //r is interest rate over a specific period
  //t is time of interest
  //lets calculate

  int p, t, r;
  int formula;
  stdout.write("Enter The Amount Of Money You Borrowed:");
  p = int.parse(stdin.readLineSync()!);
  stdout.write("Enter the Rate of Interest Over one Year:");
  r = int.parse(stdin.readLineSync()!);
  stdout.write("Enter The Duration that for how Much Time You will Keep this Borrowed Money:");
  t = int.parse(stdin.readLineSync()!);
  formula = p * t * r ~/ 100;

  print("After Calculating You Will Return $formula after $t years");
}
