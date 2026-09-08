class UserModel {
  final String uId;
  final String email;
  final String name;

  UserModel({required this.uId, required this.email, required this.name});

  Map<String, dynamic> toJson() {
    return {'uId': uId, 'email': email, 'name': name};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
