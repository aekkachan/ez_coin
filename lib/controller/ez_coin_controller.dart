

import 'package:ez_coin/constant/app_constant.dart';
import 'package:ez_coin/model/coin.dart';
import 'package:ez_coin/model/data.dart';
import 'package:ez_coin/model/news.dart';
import 'package:ez_coin/model/news2.dart';
import 'package:ez_coin/service/request_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EZCoinCoinController extends GetxController {
  var _trxPopularNews;
  var _trxLastedNews;
  var _trxPrice;
  // var _trxCoin= <Coin>[].obs;

  List<Coin> trxCoin = <Coin>[].obs;

  var userslist = <Coin>[].obs;

  var _dataPopularNewsAvailable = false.obs;
  var _dataLastedNewsAvailable = false.obs;
  var _dataCoinAvailable = false.obs;
  var _dataPriceAvailable = false.obs;

  bool get dataPopularAvailable => _dataPopularNewsAvailable.value;

  bool get dataLastedNewsAvailable => _dataLastedNewsAvailable.value;

  bool get dataCoinAvailable => _dataCoinAvailable.value;

  bool get dataPriceAvailable => _dataPriceAvailable.value;

  News get trxPopularNews => _trxPopularNews;

  News2 get trxLastedNews => _trxLastedNews;

  Data get trxPrice => _trxPrice;

  Future<void> getPopularNews(String params) {
    var fetchUrl =
        'https://newsapi.org/v2/everything?q=bitcoin&from=2022-08-07&to=2022-08-07&sortBy=popularity&language=en&pageSize=4&apiKey=${AppConstant().newsApiKey}';

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
          if (response != null) _trxPopularNews = News.fromJson(response);
        })
        .catchError((err) => debugPrint('Error getPopularNews : $err'))
        .whenComplete(
            () => _dataPopularNewsAvailable.value = _trxPopularNews != null);
  }

  Future<void> getLastedNews(String params) {
    var fetchUrl =
        'https://newsapi.org/v2/everything?q=cryptocurrency&from=2022-08-07&to=2022-08-07&sortBy=publishedAt&pageSize=10&language=en&apiKey=${AppConstant().newsApiKey}';

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
          if (response != null) _trxLastedNews = News2.fromJson(response);
        })
        .catchError((err) => debugPrint('Error getLastedNews : $err'))
        .whenComplete(
            () => _dataLastedNewsAvailable.value = _trxLastedNews != null);
  }

  Future<void> getCoin(String order) {
    var fetchUrl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&order=$order&per_page=15&page=1&sparkline=false';

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
          if (response != null) {
            trxCoin = (response as List)
                .map((element) => Coin.fromJson(element))
                .toList().obs;
            update();

          }
        })
        .catchError((err) => debugPrint('Error getCoin : $err'))
        .whenComplete(() => _dataCoinAvailable.value = trxCoin != null);
  }

  Future<void> getPrice(String params) {
    var fetchUrl =
        'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=30&interval=daily';

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
      if (response != null) {
        _trxPrice = Data.fromJson(response);
      }
    })
        .catchError((err) => debugPrint('Error getLastedNews : $err'))
        .whenComplete(
            () => _dataPriceAvailable.value = _trxPrice != null);
  }
}
