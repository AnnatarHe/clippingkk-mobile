import 'package:ClippingKK/model/appConfig.dart';

import '../model/httpClient.dart';

class MPRepository extends KKHttpClient {
  static String getQRCodeUrl(
      String scene, String page, int width, bool isHyaline) {
    return '${AppConfig.httpPrefix}/mp/qrcode?scene=${scene}&page=${page}&width=${width}&isHyaline=${isHyaline}';
  }
}
