class UserModel {
  String name;
  String nic;
  String mobile;
  String email;
  String password;
  Map<String, String> location;

  UserModel({
    required this.name,
    required this.mobile,
    required this.nic,
    required this.location,
    required this.email,
    required this.password,
  });

    Map<String, dynamic> toMap(UserModel model) {
    return {
      'name': model.name,
      'mobile': model.mobile,
      'nic': model.nic,
      'location':model.location,
      'email':model.email,
      'passward':model.password,
    };
  }
  
}
