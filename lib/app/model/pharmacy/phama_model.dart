class PharmaModel {
  String pharmaID;
  String name;
  Map<String, dynamic> locationMap;
  String contact;
  String registrationID;
  String email;

  PharmaModel({
    required this.pharmaID,
    required this.name,
    required this.locationMap,
    required this.contact,
    required this.registrationID,
    required this.email,
  });

  factory PharmaModel.fromJson(Map<String, dynamic> map) {
    return PharmaModel(
      pharmaID: map['pharmaID'] ?? 'null',
      name: map['name'] ?? 'null',
      locationMap: map['location'] ?? 'null',
      contact: map['contact'] ?? 'null',
      registrationID: map['registrationID'] ?? 'null',
      email: map['email'] ?? 'null',
    );
  }


}

