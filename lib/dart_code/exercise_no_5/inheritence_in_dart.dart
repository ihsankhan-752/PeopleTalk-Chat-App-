void main() {
  var cat1 = Cat();
  cat1.name = 'black Cat';
  cat1.sound = 'meow';
  cat1.id = '1234';
  cat1.color = 'black brown';
  print(cat1.name);
  print(cat1.sound);
  print(cat1.id);
  print(cat1.color);
}

class Animal {
  String? id;
  String? name;
  String? color;
}

class Cat extends Animal {
  String? sound;
}
