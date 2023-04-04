import 'dart:io';

void main() {
  print("1. Standard Adult Membership");
  print("2. Child Membership");
  print("3. Senior Citizen Membership");
  print("4. Quit The Program");

  int choice, months;
  stdout.write("Enter Choice:");
  choice = int.parse(stdin.readLineSync()!);
  stdout.write("For How Many Months:");
  months = int.parse(stdin.readLineSync()!);
  if (choice == 1) {
    print("You are selected Standard Adult Membership so the Charges Will be ${50 * months} ");
  } else if (choice == 2) {
    print("You are selected Child Membership So The Charges Will be ${20 * months}");
  } else if (choice == 3) {
    print("You are selected Senior Citizen Membership So The Charges Will be ${30 * months}");
  } else if (choice == 4) {
    print("Quit The Program!");
  } else {
    print("Sorry Your Choice is Wrong!");
  }
}
