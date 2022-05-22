class Indicator {
  final String name;
  final String searchKey;
  final String description;
  String value;
  bool checked = true;

  Indicator(this.name, this.searchKey, this.description, this.value);
}
