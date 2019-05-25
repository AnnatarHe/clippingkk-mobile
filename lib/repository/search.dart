import 'package:ClippingKK/model/doubanBookInfo.dart';
import 'package:ClippingKK/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';

enum SearchResultType { Book, Clipping }

// 第一期仅支持图书结果
class SearchResultItem {
  List<KKBookInfo> books;
  List<ClippingItem> clippings;

  SearchResultItem();

  SearchResultItem.fromJSON(dynamic data) {
    if (data['books'] != null) {
      final List<dynamic> _books = data['books'].toList();
      this.books = _books.map((item) => KKBookInfo.fromJSON(item)).toList();
    } else {
      this.books = [];
    }

    if (data['clippings'] != null) {
      final List<dynamic> _clippings = data['clippings'].toList();
      this.clippings = _clippings.map((item) => ClippingItem.fromJSON(item)).toList();
    }
  }
}

class SearchAPI extends KKHttpClient {
  Future<SearchResultItem> searchAnything(
      String query, int take, int offset) async {
    // final mockData = SearchResultItem();

    HttpResponse result;
    try {
      final _resp = await this.client.post('/search/all',
          data: {'query': query, 'take': take, 'from': offset});
      result = HttpResponse.fromJSON(_resp.data);
    } on DioError catch (err) {
      print(err);
      return null;
    }

    if (result.data == null) {
      return null;
    }

    final res = SearchResultItem.fromJSON(result.data);

    return res;
  }
}
