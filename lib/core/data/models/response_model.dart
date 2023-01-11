class ResponseModel {
  String? apiVersion;
  String? context;
  String? id;
  String? method;
  Object? params;
  DataResponse? data;
  ErrorResponse? error;
}

class DataResponse {
  String? kind;
  String? fields;
  String? etag;
  String? id;
  String? lang;
  DateTime? updated;
  DateTime? deleted;
  int? currentItemCount;
  int? itemsPerPage;
  int? startIndex;
  int? totalItems;
  int? pageIndex;
  int? totalPages;
  String? pageLinkTemplate;
  Object? next;
  String? nextLink;
  Object? previous;
  String? previousLink;
  Object? self;
  String? selfLink;
  Object? edit;
  String? editLink;
  Object? items;
}

class ErrorResponse {
  String? code;
  String? message;
  List<ErrorItem>? errors;
}

class ErrorItem {
  String? domain;
  String? reason;
  String? message;
  String? location;
  String? locationType;
  String? extendedHelp;
  String? sendReport;
}
