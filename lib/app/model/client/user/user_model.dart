class UserModel {
  String userID;
  String name;
  Map<String, dynamic> locationMap;
  String contact;
  String nic;
  String email;

  UserModel({
    required this.userID,
    required this.name,
    required this.locationMap,
    required this.contact,
    required this.nic,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] ?? 'null',
      name: map['name'] ?? 'null',
      locationMap: map['location'] ?? 'null',
      contact: map['contact'] ?? 'null',
      nic: map['nic'] ?? 'null',
      email: map['email'] ?? 'null',
    );
  }


}

