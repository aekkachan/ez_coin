import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ez_coin/constant/app_color.dart' as _color;
import 'package:ez_coin/controller/ez_coin_controller.dart';
import 'package:ez_coin/view/currency_list_view.dart';
import 'package:ez_coin/view/exchange_rate_view.dart';
import 'package:ez_coin/view/history_view.dart';
import 'package:ez_coin/view/news_view.dart';
import 'package:ez_coin/view/setting_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constant/app_color.dart';

class HomeManager extends StatefulWidget {
  const HomeManager({Key? key}) : super(key: key);

  @override
  State<HomeManager> createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager>
    with TickerProviderStateMixin {
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;

  final _pages = const [
    NewsView(),
    CurrencyListView(),
    HistoryView(),
    SettingView(),
    ExchangeRateView(),
  ];

  int _activeIndex = 0;

  var _bgColor = AppColor().bgColor;
  var _themeColor = AppColor().themeColor;

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: HexColor('#373A36'),
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    Get.put(EZCoinCoinController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: IndexedStack(
          index: _activeIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: _bgColor,
        selectedItemColor: _themeColor,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Rankin',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.graph_square),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _activeIndex,
        elevation: 0,
        onTap: (index) => setState(() => _activeIndex = index),
      ),
    );
  }
}
