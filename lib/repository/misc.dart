import 'dart:async';
import '../model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';
import 'package:ClippingKK/model/httpError.dart';

class MiscRepository extends KKHttpClient {
  Future<List<VersionItem>> checkUpdate() async {
    final _resp = await this.client.get('/version/android', data: { "take": 1 });
    final response = HttpResponse.fromJSON(_resp.data);

    if (response.status != 200) {
      final err = KKHttpError(msg: response.msg);
      return Future.error(err);
    }

    if (response.data == null) {
      return List.of([]);
    }

    final List<dynamic> list = response.data.toList();
    final List<VersionItem> rtn = list.map((item) => VersionItem.fromJSON(item)).toList();
    return rtn;
  }
}
