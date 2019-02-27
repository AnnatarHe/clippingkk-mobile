import 'dart:async';
import 'package:ClippingKK/model/doubanBookInfo.dart';
import 'package:ClippingKK/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:ClippingKK/model/appConfig.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';

class ClippingsAPI extends KKHttpClient {
  Future<List<ClippingItem>> getClippings(int take, int offset) async {
    HttpResponse result;
    try {
      final _resp = await this.client.get('/clippings/clippings/${AppConfig.uid}', data: {
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

    final List<ClippingItem> rtn = list.map((item) => ClippingItem.fromJSON(item)).toList();
    return rtn;
  }

  Future<List<KKBookInfo>> getBooks(int uid, int offset) async {
    KKLogger().getLogger().fine(uid, offset);
    final response = await this.client.get('/clippings/books/$uid', data: {
      'take': 20,
      'from': offset
    });

    final result = HttpResponse.fromJSON(response.data);
    if (result.data == null) {
      return List.of([]);
    }

    final List<dynamic> list = result.data.toList();

    final List<KKBookInfo> rtn = list.map((item) => KKBookInfo.fromJSON(item))
      .toList();
    return rtn;
  }

  Future<List<ClippingItem>> getClippingsByBook(int userid, String bookId,
    int offset) async {
    HttpResponse result;
    try {
      final _resp = await this.client.get(
        '/book/clippings/$userid/$bookId', data: {
        'take': 20,
        'from': offset
      });
      result = HttpResponse.fromJSON(_resp.data);
    } on DioError catch (err) {
      print(err);
      return List.of([]);
    }

    if (result.data == null) {
      return List.of([]);
    }

    final List<dynamic> list = result.data.toList();

    final List<ClippingItem> rtn = list.map((item) =>
      ClippingItem.fromJSON(item)).toList();
    return rtn;
  }
}
