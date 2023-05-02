import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required id,
      required name,
      required username,
      required email,
      required enabled,
      required builtIn,
      required pictureUrl,
      required pictureCloudFileId,
      required pictureThumbnailUrl,
      required pictureThumbnailCloudFileId,})
      : super(
            id: id,
            name: name,
            username: username,
            email: email,
            enabled: enabled,
            builtIn: builtIn,
            pictureUrl: pictureUrl,
            pictureCloudFileId: pictureCloudFileId,
            pictureThumbnailUrl: pictureThumbnailUrl,
            pictureThumbnailCloudFileId: pictureThumbnailCloudFileId,);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        enabled: json["enabled"],
        builtIn: json["builtIn"],
        pictureUrl: json["pictureUrl"],
        pictureCloudFileId: json["pictureCloudFileId"],
        pictureThumbnailUrl: json["pictureThumbnailUrl"],
        pictureThumbnailCloudFileId: json["pictureThumbnailCloudFileId"],);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'enabled': enabled,
      'builtIn': builtIn,
      'pictureUrl': pictureUrl,
      'pictureCloudFileId': pictureCloudFileId,
      'pictureThumbnailUrl': pictureThumbnailUrl,
      'pictureThumbnailCloudFileId': pictureThumbnailCloudFileId,
    };
  }

  User toEntity() => User(
      id: id,
      name: name,
      username: username,
      email: email,
      enabled: enabled,
      builtIn: builtIn,
      pictureUrl: pictureUrl,
      pictureCloudFileId: pictureCloudFileId,
      pictureThumbnailUrl: pictureThumbnailUrl,
      pictureThumbnailCloudFileId: pictureThumbnailCloudFileId,);

  @override
  List<Object> get props => [id, name, username, email, enabled, builtIn,];
}
