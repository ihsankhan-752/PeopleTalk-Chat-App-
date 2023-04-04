import 'dart:io';

void main() {
  String name;
  String ftnArg;
  stdout.write("Enter Name:");
  name = stdin.readLineSync()!;
  ftnArg = reverse(name);
  print(ftnArg);
}

String reverse(String name) {
  return name.split('').reversed.join('');
}
