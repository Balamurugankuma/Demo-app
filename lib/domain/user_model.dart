class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;

  UserModel({this.uid, this.name, this.email, this.password});

  Map<dynamic, String> map() {
    final mapping = <dynamic, String>{};
    mapping['uid'] = uid!;
    mapping['name'] = name!;
    mapping['email'] = email!;
    mapping['password'] = password!;
    return mapping;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid']?.toString(),
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }
}
