class HttpResponse {
  final int status;
  final String msg;
  final dynamic data;

  HttpResponse.fromJSON(dynamic json)
      : status = json["status"],
        msg = json["msg"],
        data = json["data"];
}
