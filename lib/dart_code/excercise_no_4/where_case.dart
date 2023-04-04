void main() {
  List<String> frndList = ['Zakria', 'Qasim', 'azan', 'Huzaifa', 'farooq', 'atal', 'umar'];
  print(frndList.where((element) {
    return element.startsWith('a');
  }));
}
