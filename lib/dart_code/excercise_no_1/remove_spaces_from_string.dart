void main() {
  String data = "Hi My name is Ihsan and I am from Swat";
  print("Data Before Removing Spaces is:$data");
  print("Data After Removing Spaces is: ${data.replaceAll(" ", "")}");
}
