import 'package:lomba_frontend/domain/entities/storage/filecloud.dart';

class FileCloudModel extends FileCloud {
  const FileCloudModel(
      {required id,
      required name,
      required path,
      required url,
      required size,
      required account,
      required filetype,
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
            url: url,
            size: size,
            account: account,
            filetype: filetype,
            enabled: enabled,
            builtIn: builtIn,
            created: created,
            updated: updated,
            deleted: deleted,
            expires: expires);

  factory FileCloudModel.fromJson(Map<String, dynamic> json) {
    return FileCloudModel(
        id: json["id"],
        name: json["name"],
        path: json["path"],
        url: json["url"],
        size: json["size"],
        account: json["account"],
        filetype: json["filetype"],
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
      'url': url,
      'size': size,
      'account': account,
      'filetype': filetype,
      'enabled': enabled,
      'builtIn': builtIn,
      'created': created.toIso8601String(),
      'updated': updated == null ? null : updated!.toIso8601String(),
      'deleted': deleted == null ? null : deleted!.toIso8601String(),
      'expires': expires == null ? null : expires!.toIso8601String()
    };
  }

  FileCloud toEntity() => FileCloud(
      id: id,
      name: name,
      path: path,
      url: url,
      size: size,
      account: account,
      filetype: filetype,
      enabled: enabled,
      builtIn: builtIn,
      created: created,
      updated: updated,
      deleted: deleted,
      expires: expires);

  @override
  List<Object> get props =>
      [id, name, url, size, account, filetype, enabled, builtIn, created];
}
