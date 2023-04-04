void main() {
  List<dynamic> houseData = [];
  var obj1 = House();
  var obj2 = House();
  var obj3 = House();

  obj1.name = 'Home Town in swat';
  obj1.id = 'Swat';
  obj1.price = 12000;
  obj2.name = 'Home Town in Mardan';
  obj2.id = 'Mardan';
  obj2.price = 15000;
  obj3.name = 'Home Town in Lahore';
  obj3.id = 'Lahore';
  obj3.price = 122045;
  houseData.add(obj1.name);
  houseData.add(obj2.name);
  houseData.add(obj3.name);
  houseData.add(obj1.id);
  houseData.add(obj2.id);
  houseData.add(obj3.id);
  houseData.add(obj1.price);
  houseData.add(obj2.price);
  houseData.add(obj3.price);

  for (int i = 0; i < houseData.length; i++) {
    print(houseData[i]);
  }
}

class House {
  String? id;
  String? name;
  int? price;
  House() {
    print("Default Constructor");
  }
}
