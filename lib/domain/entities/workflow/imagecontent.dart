import 'package:equatable/equatable.dart';

class ImageContent extends Equatable {
  const ImageContent(
      {required this.url,
      required this.size,
      required this.filetype,
      required this.cloudFileId,
      required this.width,
      required this.height,
      required this.description});

  final String url;
  final int size;
  final String filetype;
  final String cloudFileId;

  final int width;
  final int height;
  final String description;

  @override
  List<Object?> get props =>
      [url, size, filetype, cloudFileId, width, height, description];
}
