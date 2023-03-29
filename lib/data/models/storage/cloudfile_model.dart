import 'package:lomba_frontend/domain/entities/storage/cloudfile.dart';

class CloudFileModel extends CloudFile {
  const CloudFileModel(
      {required id,
      required name,
      required path,
      required host,
      required url,
      required size,
      required account,
      required filetype,
      required orgaId,
      required userId,
      required associated,
      required enabled,
      required builtIn,
      required created,
      required updated,
      required deleted,
      required expires})
      : super(
            id: id,
            name: name,
            path: path,
            host: host,
            url: url,
            size: size,
            account: account,
            filetype: filetype,
            orgaId: orgaId,
            userId: userId,
            associated: associated,
            enabled: enabled,
            builtIn: builtIn,
            created: created,
            updated: updated,
            deleted: deleted,
            expires: expires);

  factory CloudFileModel.fromJson(Map<String, dynamic> json) {
    return CloudFileModel(
        id: json["id"],
        name: json["name"],
        path: json["path"],
        host: json["host"],
        url: json["url"],
        size: int.parse(json["size"].toString()),
        account: json["account"],
        filetype: json["filetype"],
        orgaId: json["orgaId"],
        userId: json["userId"],
        associated: json["associated"].toString().toLowerCase() == "true",
        enabled: json["enabled"],
        builtIn: json["builtIn"],
        created: DateTime.parse(json["created"]),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        deleted:
            json["deleted"] == null ? null : DateTime.parse(json["deleted"]),
        expires:
            json["expires"] == null ? null : DateTime.parse(json["expires"]));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'host': host,
      'url': url,
      'size': size,
      'account': account,
      'filetype': filetype,
      'orgaId': orgaId,
      'userId': userId,
      'associated': associated,
      'enabled': enabled,
      'builtIn': builtIn,
      'created': created.toIso8601String(),
      'updated': updated == null ? null : updated!.toIso8601String(),
      'deleted': deleted == null ? null : deleted!.toIso8601String(),
      'expires': expires == null ? null : expires!.toIso8601String()
    };
  }

  CloudFile toEntity() => CloudFile(
      id: id,
      name: name,
      path: path,
      host: host,
      url: url,
      size: size,
      account: account,
      filetype: filetype,
      orgaId: orgaId,
      userId: userId,
      associated: associated,
      enabled: enabled,
      builtIn: builtIn,
      created: created,
      updated: updated,
      deleted: deleted,
      expires: expires);

  @override
  List<Object> get props => [
        id,
        name,
        path,
        host,
        url,
        size,
        account,
        filetype,
        orgaId,
        userId,
        associated,
        enabled,
        builtIn,
        created
      ];
}
