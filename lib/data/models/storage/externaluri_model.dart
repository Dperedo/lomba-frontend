import '../../../domain/entities/storage/externaluri.dart';

class ExternalUriModel extends ExternalUri {
  const ExternalUriModel({
    required id,
    required userId,
    required uri,
    required path,
    required host,
    required hosts,
    required sourceName,
    required title,
    required shortUrl,
    required description,
    required type,
    required httpstatus,
    required lastchecked,
  })
    : super(
        id: id,
        userId: userId,
        uri: uri,
        path: path,
        host: host,
        hosts: hosts,
        sourceName: sourceName,
        title: title,
        shortUrl: shortUrl,
        description: description,
        type: type,
        httpstatus: httpstatus,
        lastchecked: lastchecked,
      );

  factory ExternalUriModel.fromJson(Map<String, dynamic> json) {
    return ExternalUriModel(
      id: json["id"],
      userId: json["userId"],
      uri: json["uri"],
      path: json["path"],
      host: json["host"],
      hosts: json["hosts"],
      sourceName: json["sourceName"],
      title: json["title"],
      shortUrl: json["shortUrl"],
      description: json["description"],
      type: json["type"],
      httpstatus: json["httpstatus"],
      lastchecked: json["lastchecked"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'uri': uri,
      'path': path,
      'host': host,
      'hosts': hosts,
      'sourceName': sourceName,
      'title': title,
      'shortUrl': shortUrl,
      'description': description,
      'type': type,
      'httpstatus': httpstatus,
      'lastchecked': lastchecked,
    };
  }

  ExternalUri toEntity() => ExternalUri(
        id: id,
        userId: userId,
        uri: uri,
        path: path,
        host: host,
        hosts: hosts,
        sourceName: sourceName,
        title: title,
        shortUrl: shortUrl,
        description: description,
        type: type,
        httpstatus: httpstatus,
        lastchecked: lastchecked,
      );

  @override
  List<Object> get props => [id, userId, uri, path, host, hosts, sourceName, title, shortUrl, description, type, httpstatus];
}
