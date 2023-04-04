void main() {
  Map<String, dynamic> user = {"name": "Ihsan", "address": "Swat", "age": 24, "country": "Pak"};
  print(user);
  user.update('country', (value) => 'Eng');
  print(user);
}
