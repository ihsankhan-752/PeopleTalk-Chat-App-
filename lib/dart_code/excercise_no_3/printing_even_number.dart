import 'dart:io';

void main() {
  printNumbers();
}

void printNumbers() {
  for (int i = 1; i < 100; i++) {
    if (i % 2 == 0) {
      stdout.write(" $i");
    }
  }
}
