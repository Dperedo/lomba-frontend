import '../../domain/entities/token.dart';

class TokenModel extends Token {
  const TokenModel({required String id, required String username})
      : super(id: id, username: username);
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(id: json["id"], username: json["username"]);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username};
  }

  Token toEntity() => Token(id: id, username: username);

  @override
  List<Object> get props => [id, username];
}
