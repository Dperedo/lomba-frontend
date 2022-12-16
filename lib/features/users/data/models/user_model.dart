import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required id,
      required name,
      required username,
      required email,
      required enabled,
      required builtIn})
      : super(
            id: id,
            name: name,
            username: username,
            email: email,
            enabled: enabled,
            builtIn: builtIn);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        enabled: json["enabled"],
        builtIn: json["builtIn"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'enabled': enabled,
      'builtIn': builtIn
    };
  }

  User toEntity() => User(
      id: id,
      name: name,
      username: username,
      email: email,
      enabled: enabled,
      builtIn: builtIn);

  @override
  List<Object> get props => [id, name, username, email, enabled, builtIn];
}
