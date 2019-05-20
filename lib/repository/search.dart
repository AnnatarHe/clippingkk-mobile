import 'package:dio/dio.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';

enum SearchResultType {
  Book,
  Clipping
}

// 第一期仅支持图书结果
class SearchResultItem {
  String bookName;
  SearchResultType type;
  int bookID;
  String bookCover;
  String author;

  SearchResultItem.fromJSON(dynamic data)
  : bookName = data['bookName'],
  type = data['type'] == 'book' ? SearchResultType.Book : SearchResultType.Clipping,
  bookID = data['bookId'],
  bookCover = 'https://cdn.annatarhe.com/${data['image']}-copyrightDB.webp',
  author = data['author'];
}

class SearchAPI extends KKHttpClient {
  Future<List<SearchResultItem>> SearchAnything(String query, int take, int offset) async {
    HttpResponse result;
    try {
      final _resp = await this.client.post('/search/all', data: {
        'query': query,
        'take': take,
        'from': offset
      });
      result = HttpResponse.fromJSON(_resp.data);
    } on DioError catch(err) {
      print(err);
      return List.of([]);
    }

    if (result.data == null) {
      return List.of([]);
    }

    final List<dynamic> list = result.data.toList();

    final List<SearchResultItem> rtn = list.map((item) => SearchResultItem.fromJSON(item)).toList();
    return rtn;
  }
}
