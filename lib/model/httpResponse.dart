class HttpResponse {
  final int status;
  final String msg;
  final dynamic data;

  HttpResponse.fromJSON(dynamic json)
      : status = json["status"],
        msg = json["msg"],
        data = json["data"];
}

class ClippingItem {
  final int id;
  final String title;
  final String content;
  final String bookId;
  final String pageAt;
  final int createdBy;
  final int sequence;

  ClippingItem.fromJSON(dynamic json)
    : id = json["id"],
      title = json['title'],
      content = json['content'],
      bookId = json['bookId'],
      pageAt = json['pageAt'],
      createdBy = json['createdBy'],
      sequence = json['seq'];
}
