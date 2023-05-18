import '../../../domain/entities/storage/host.dart';

class HostModel extends Host {
  const HostModel({required id, required host, required names})
      : super(id: id, host: host, names: names);

  factory HostModel.fromJson(Map<String, dynamic> json) {
    return HostModel(
      id: json["id"],
      host: json["host"],
      names: json["names"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'host': host,
      'names': names,
    };
  }

  Host toEntity() => Host(
        id: id,
        host: host,
        names: names,
      );

  @override
  List<Object> get props => [id, host, names];
}
