import 'package:ez_coin/constant/app_constant.dart';
import 'package:ez_coin/model/coin.dart';
import 'package:ez_coin/model/coin_detail.dart';
import 'package:ez_coin/model/data.dart';
import 'package:ez_coin/model/news.dart';
import 'package:ez_coin/model/news2.dart';
import 'package:ez_coin/service/request_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EZCoinCoinController extends GetxController {
  var _trxPopularNews;
  var _trxLastedNews;
  var _trxPrice;

  List<Coin> trxCoin = <Coin>[].obs;
  List<CoinDetail> _trxCoinDetail = <CoinDetail>[].obs;

  var _dataPopularNewsAvailable = false.obs;
  var _dataLastedNewsAvailable = false.obs;
  var _dataCoinAvailable = false.obs;
  var _dataPriceAvailable = false.obs;
  var _dataCoinDetailAvailable = false.obs;

  bool get dataPopularAvailable => _dataPopularNewsAvailable.value;
  bool get dataLastedNewsAvailable => _dataLastedNewsAvailable.value;
  bool get dataCoinAvailable => _dataCoinAvailable.value;
  bool get dataPriceAvailable => _dataPriceAvailable.value;
  bool get dataCoinDetailAvailable => _dataCoinDetailAvailable.value;

  News get trxPopularNews => _trxPopularNews;
  News2 get trxLastedNews => _trxLastedNews;
  Data get trxPrice => _trxPrice;
  List<CoinDetail> get trxCoinDetail => _trxCoinDetail;

  Future<void> getPopularNews(String params) {
    var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var fetchUrl =
        'https://newsapi.org/v2/everything?q=bitcoin&from=$currentDate&to=$currentDate&sortBy=popularity&language=en&pageSize=4&apiKey=${AppConstant().newsApiKey}';

    debugPrint(fetchUrl);

    return RequestService.fetchJsonDataGetRequest(fetchUrl).then((response) {
      if (response != null) _trxPopularNews = News.fromJson(response);
    }).catchError((error) {
      debugPrint('Error getPopularNews : $error');
    }).whenComplete(
        () => _dataPopularNewsAvailable.value = _trxPopularNews != null);
  }

  Future<void> getLastedNews(String params) {
    var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var fetchUrl =
        'https://newsapi.org/v2/everything?q=cryptocurrency&from=$currentDate&to=$currentDate&sortBy=publishedAt&pageSize=10&language=en&apiKey=${AppConstant().newsApiKey}';

    debugPrint(fetchUrl);
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
    debugPrint(fetchUrl);

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
          if (response != null) {
            trxCoin = (response as List)
                .map((element) => Coin.fromJson(element))
                .toList()
                .obs;
            update();
          }
        })
        .catchError((err) => debugPrint('Error getCoin : $err'))
        .whenComplete(() => _dataCoinAvailable.value = true);
  }

  Future<void> getPrice(String interval) {
    var day = interval == 'daily' ? '30' : '15';
    var fetchUrl =
        'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=$day&interval=$interval';
    debugPrint(fetchUrl);

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
          if (response != null) {
            _trxPrice = Data.fromJson(response);
          }
        })
        .catchError((err) => debugPrint('Error getLastedNews : $err'))
        .whenComplete(() => _dataPriceAvailable.value = _trxPrice != null);
  }

  Future<void> getCoinDetail(String params) {
    var fetchUrl =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h';
    debugPrint(fetchUrl);

    return RequestService.fetchJsonDataGetRequest(fetchUrl)
        .then((response) {
          if (response != null) {
            _trxCoinDetail = (response as List)
                .map((element) => CoinDetail.fromJson(element))
                .toList()
                .obs;
            update();
          }
        })
        .catchError((err) => debugPrint('Error getCoinDetail : $err'))
        .whenComplete(() => _dataPriceAvailable.value = _trxPrice != null);
  }
}
