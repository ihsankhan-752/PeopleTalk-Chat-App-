void main() {
  var obj1 = Laptop();
  obj1.name = 'Dell';
  obj1.id = '7280';
  obj1.ram = 8;
  print(obj1.name);
  print(obj1.id);
  print(obj1.ram.toString());
  var obj2 = Laptop();
  obj2.name = 'HP';
  obj2.id = '7E280';
  obj2.ram = 16;

  print(obj2.name);
  print(obj2.id);
  print(obj2.ram.toString());
}

class Laptop {
  String? id;
  String? name;
  int? ram;
}
