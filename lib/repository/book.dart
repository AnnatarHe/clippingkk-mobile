
import 'package:ClippingKK/model/doubanBookInfo.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpError.dart';
import 'package:ClippingKK/model/httpResponse.dart';

class BookRepository extends KKHttpClient {
  Future<KKBookInfo> load(String doubanId) async {
    final _resp = await this.client.get('/clippings/book/$doubanId');
    final response = HttpResponse.fromJSON(_resp.data);

    if (response.status != 200) {
      final err = KKHttpError(msg: response.msg);
      return Future.error(err);
    }

    if (response.data == null) {
      return null;
    }

    return KKBookInfo.fromJSON(response.data);
  }
}
