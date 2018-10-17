import 'dart:async';
import 'package:ClippingKK/model/appConfig.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';

class ClippingsAPI extends KKHttpClient {
  Future<List<ClippingItem>> getClippings(int take, int offset) async {
    final _resp = await this.client.get('/clippings/clippings/${AppConfig.uid}', data: {
      'take': take,
      'from': offset
    });
    final result = HttpResponse.fromJSON(_resp.data);

    if (result.data == null) {
      return List.of([]);
    }

    final List<dynamic> list = result.data.toList();

    final List<ClippingItem> rtn = list.map((item) => ClippingItem.fromJSON(item)).toList();
    return rtn;
  }
}