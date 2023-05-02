import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.enabled,
      required this.builtIn,
      required this.pictureUrl,
      required this.pictureCloudFileId,
      required this.pictureThumbnailUrl,
      required this.pictureThumbnailCloudFileId,});

  final String id;
  final String name;
  final String username;
  final String email;
  final bool enabled;
  final bool builtIn;
  final String? pictureUrl;
  final String? pictureCloudFileId;
  final String? pictureThumbnailUrl;
  final String? pictureThumbnailCloudFileId;

  @override
  List<Object> get props => [id, name, username, email, enabled, builtIn];
}
