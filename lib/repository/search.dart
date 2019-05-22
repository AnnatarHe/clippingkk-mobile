import 'package:ClippingKK/model/doubanBookInfo.dart';
import 'package:dio/dio.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';

enum SearchResultType {
  Book,
  Clipping
}

// 第一期仅支持图书结果
class SearchResultItem {

  KKBookInfo bookInfo;
  ClippingItem clipping;

  SearchResultItem();

  SearchResultItem.fromJSON(dynamic data)
  : bookInfo = KKBookInfo.fromJSON(data['book']),
    clipping = ClippingItem.fromJSON(data['clipping']);
}

class SearchAPI extends KKHttpClient {
  Future<List<SearchResultItem>> SearchAnything(String query, int take, int offset) async {

    // final mockData = SearchResultItem();

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
