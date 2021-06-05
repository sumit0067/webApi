import 'dart:convert';

GetUser getUserFromJson(String str) => GetUser.fromJson(json.decode(str));

String getUserToJson(GetUser data) => json.encode(data.toJson());

class GetUser {
  GetUser({
    this.user,
    this.code,
    this.message,
  });

  List<User> user;
  String code;
  String message;

  factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
    "code": code,
    "message": message,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
  });

  String id;
  String name;
  String email;
  String password;
  String phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "phone": phone,
  };
}
