import 'dart:io';

void main() {
  int x;
  stdout.write("Enter Number:");
  x = int.parse(stdin.readLineSync()!);
  if (x % 2 == 0) {
    print("The Number you Enter is Even");
  } else {
    print("The Number you Enter is Odd");
  }
}
