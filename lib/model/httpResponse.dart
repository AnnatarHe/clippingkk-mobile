class HttpResponse {
  final int status;
  final String msg;
  final Map<String, dynamic> data;

  HttpResponse.fromJSON(Map<String, dynamic> json)
      : status = json["status"],
        msg = json["msg"],
        data = json["data"];
}
