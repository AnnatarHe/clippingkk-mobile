import 'dart:async';
import 'package:ClippingKK/model/appConfig.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';
import 'package:dio/dio.dart';

class ClippingsAPI extends KKHttpClient {
  Future<ClippingItem> getClippings(int from, int offset) async {
    final result = await this.client.get('/api/clippings/clippings/${AppConfig.uid}', data: {
      from: from,
      offset: offset
    });

    print(result);
    return ClippingItem.fromJSON(result.data);
  }
}