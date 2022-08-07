import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
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

  final _iconList = <IconData>[
    CupertinoIcons.home,
    Icons.auto_graph,
    Icons.currency_exchange,
    Icons.settings,
  ];

  final _menus = ['Home', 'Rankin', 'Exchange', 'Setting'];

  final _pages = const [
    NewsView(),
    CurrencyListView(),
    ExchangeRateView(),
    SettingView(),
    HistoryView(),
  ];

  int _activeIndex = 0;

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('#373A36'),
        splashColor: Colors.transparent,
        child: Icon(
          CupertinoIcons.graph_square,
          color: _activeIndex == 4 ? HexColor('#FFA400') : Colors.white,
        ),
        onPressed: () => setState(() => _activeIndex = 4),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? HexColor('#FFA400') : Colors.white;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  _menus[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                  group: AutoSizeGroup(),
                ),
              )
            ],
          );
        },
        backgroundColor: HexColor('#373A36'),
        activeIndex: _activeIndex,
        gapLocation: GapLocation.center,
        splashColor: Colors.transparent,
        splashSpeedInMilliseconds: 150,
        splashRadius: 0,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 10,
        rightCornerRadius: 10,
        onTap: (index) => setState(() => _activeIndex = index),
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.grey,
        ),
      ),
    );
  }
}
