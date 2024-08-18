class UserModel {
  String email;
  String password;
  int phoneNumber;
  String id;
  String name;

  UserModel({
    required this.email,
    required this.id,
    required this.password,
    required this.phoneNumber,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "id": id,
        "name": name,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      id: json["id"],
      password: json["password"],
      phoneNumber: json["phoneNumber"],
      name: json["name"],
    );
  }
}
