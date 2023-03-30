import 'package:equatable/equatable.dart';

class VideoContent extends Equatable {
  const VideoContent(
      {required this.url,
      required this.size,
      required this.filetype,
      required this.cloudFileId,
      required this.width,
      required this.height,
      required this.description,
      required this.thumbnailUrl,
      required this.thumbnailSize,
      required this.thumbnailCloudFileId});

  final String url;
  final int size;
  final String filetype;
  final String cloudFileId;

  final int width;
  final int height;
  final String description;
  final String thumbnailUrl;
  final int thumbnailSize;
  final String thumbnailCloudFileId;

  @override
  List<Object?> get props => [
        url,
        size,
        filetype,
        cloudFileId,
        width,
        height,
        description,
        thumbnailUrl,
        thumbnailSize,
        thumbnailCloudFileId
      ];
}
