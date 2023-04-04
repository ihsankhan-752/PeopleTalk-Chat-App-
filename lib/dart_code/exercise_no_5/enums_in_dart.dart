enum gender {
  male,
  female,
  others,
}

void main() {
  gender first = gender.others;
  gender second = gender.female;
  gender third = gender.male;
  print(first.name);
  print(second.name);
  print(third.name);
}
