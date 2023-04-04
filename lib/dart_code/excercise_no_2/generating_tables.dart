import 'dart:io';

void main() {
  int number, i;

  stdout.write("Enter Number b/w 1-9");
  number = int.parse(stdin.readLineSync()!);
  if (number > 9) {
    print("Table Number Must be b/w 1-9");
  } else {
    for (i = 1; i <= 10; i++) {
      print("$number * $i = ${number * i}");
    }
  }
}
