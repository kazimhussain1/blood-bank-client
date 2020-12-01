class UserModel {
  UserModel(this.id, this.name, this.email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(json['id'], json['name'], json['email']);
  }

  int id;
  String name;
  String email;
}
