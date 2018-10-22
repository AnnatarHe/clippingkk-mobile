import 'dart:typed_data';

import 'package:ClippingKK/model/doubanBookInfo.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:dio/dio.dart';

class DoubanAPI {

  Dio client = new Dio();

  Future<DoubanBookInfo> search(String bookTitle) async {
    print(bookTitle);
    final response = await this.client.get('https://api.douban.com/v2/book/search?q=$bookTitle');
    final bookInfo = response.data['books'][0];

    return DoubanBookInfo.fromJSON(bookInfo);
  }

}