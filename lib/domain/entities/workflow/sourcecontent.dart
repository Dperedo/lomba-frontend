import 'package:equatable/equatable.dart';

class SourceContent extends Equatable {
  const SourceContent(
      {required this.externalUriId,
      required this.url,
      required this.label,
      required this.title,
      required this.shortUrl,
      required this.description});

  final String externalUriId;

  final String url;

  final String description;
  final String label;
  final String title;
  final String shortUrl;

  @override
  List<Object?> get props =>
      [externalUriId, url, description, label, title, shortUrl];
}
