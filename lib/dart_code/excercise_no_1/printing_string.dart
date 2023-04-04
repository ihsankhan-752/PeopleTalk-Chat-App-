import 'dart:io';

void main() {
  String firstName;
  String secondName;
  String address;
  stdout.write("Enter Your First Name:");
  firstName = stdin.readLineSync()!;
  stdout.write("Enter Your Second Name:");
  secondName = stdin.readLineSync()!;
  stdout.write("Enter Your Address:");
  address = stdin.readLineSync()!;

  print("Hello Mr! " + firstName + "your Second Name is" + secondName + "Your Full Address is " + address);
}
