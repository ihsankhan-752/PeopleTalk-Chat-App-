import 'dart:io';

void main() {
  String char;

  stdout.write("Enter The Character:");
  char = stdin.readLineSync()!;
  if (char == 'a' || char == 'e' || char == 'i' || char == 'o' || char == 'u') {
    print("The Given Character is Vowel");
  } else {
    print("The Given Character is Consonant");
  }
}
