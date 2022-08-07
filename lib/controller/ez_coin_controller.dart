import 'package:ez_coin/model/news.dart';
import 'package:ez_coin/model/news2.dart';
import 'package:ez_coin/service/request_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EZCoinCoinController extends GetxController {

  var _trxPopularNews;
  var _trxLastedNews;

  var _dataPopularNewsAvailable = false.obs;
  var _dataLastedNewsAvailable = false.obs;

  bool get dataPopularAvailable => _dataPopularNewsAvailable.value;
  bool get dataLastedNewsAvailable => _dataLastedNewsAvailable.value;

  News get trxPopularNews => _trxPopularNews;
  News2 get trxLastedNews => _trxLastedNews;


  Future<void> getPopularNews(String data) {
    var fetchUrl = 'https://newsapi.org/v2/everything?q=bitcoin&from=2022-08-07&to=2022-08-07&sortBy=popularity&language=en&pageSize=4&apiKey=4519a665f5a547f682f6773ac794badd';

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
      if (response != null) _trxPopularNews = News.fromJson(response);
    })
        .catchError((err) => debugPrint('Error getPopularNews : $err'))
        .whenComplete(() => _dataPopularNewsAvailable.value = _trxPopularNews != null);
  }

  Future<void> getLastedNews(String data) {
    var fetchUrl = 'https://newsapi.org/v2/everything?q=cryptocurrency&from=2022-08-07&to=2022-08-07&sortBy=publishedAt&pageSize=10&language=en&apiKey=4519a665f5a547f682f6773ac794badd';

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
      if (response != null) _trxLastedNews = News2.fromJson(response);
    })
        .catchError((err) => debugPrint('Error getLastedNews : $err'))
        .whenComplete(() => _dataLastedNewsAvailable.value = _trxLastedNews != null);
  }
}
