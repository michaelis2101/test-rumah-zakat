class LocationModel {
  final String id;
  final String name;

  LocationModel({required this.id, required this.name});

  // @override
  // String toString() {
  //   return '{id: $id, name: $name}';
  // }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
