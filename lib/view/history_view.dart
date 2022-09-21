import 'package:ez_coin/constant/app_color.dart';
import 'package:ez_coin/controller/ez_coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  EZCoinCoinController coinController = Get.find();

  final List<SalesData> chartData = [];
  final List<bool> selectedInterval = <bool>[true, false].obs;
  final List<bool> selectedChart = <bool>[true, false].obs;

  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        header: 'BTC',
        borderColor: AppColor.themeColor,
        borderWidth: 1);
    _crosshairBehavior = CrosshairBehavior(enable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    coinController.getPrice('params');
    coinController.getCoinDetail('param');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#2f3037'),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Bitcoin (BTC)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
        color: HexColor('#2f3037'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
              alignment: Alignment.centerLeft,
              child: GetBuilder<EZCoinCoinController>(
                init: coinController,
                builder: (value) => RichText(
                  text: TextSpan(
                    text: '1 BTC / USD\n',
                    style: TextStyle(
                      color: AppColor.themeColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '${value.trxCoinDetail[0].currentPrice}',
                          style: TextStyle(
                            color: AppColor.themeColor,
                            fontSize: 30.0,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            togglebutton(),
            chart(),
            GetBuilder<EZCoinCoinController>(
                init: coinController,
                builder: (value) => Container(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: Column(
                                children: [
                                  _itemRow(
                                      'Market Cap',
                                      NumberFormat.compact().format(
                                          value.trxCoinDetail[0].marketCap)),
                                  _itemRow(
                                      'Volume',
                                      NumberFormat.compact().format(
                                          value.trxCoinDetail[0].totalVolume)),
                                  _itemRow(
                                      'Supply',
                                      NumberFormat.compact().format(value
                                          .trxCoinDetail[0].circulatingSupply)),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 10),
                              child: Column(
                                children: [
                                  _itemRow('High 24 Hr',
                                      '\$${value.trxCoinDetail[0].high24h}'),
                                  _itemRow('Low 24 Hr',
                                      '\$${value.trxCoinDetail[0].low24h}'),
                                  _itemRow('Chang % 24 Hr',
                                      '${value.trxCoinDetail[0].priceChangePercentage24h?.toStringAsFixed(2)}%'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
          ],
        ),
      )),
    );
  }

  chart() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      alignment: Alignment.center,
      child: Obx(() {
        if (coinController.dataPriceAvailable) {
          var price = coinController.trxPrice;
          List coinPrice = price.prices!;
          int interval = 0;

          for (var index = coinPrice.length - 1; index >= 0; index--) {
            chartData.add(SalesData(
                DateTime.now().add(Duration(hours: interval)),
                coinPrice[index][1]));
            interval--;
          }
        }
        return SfCartesianChart(
            crosshairBehavior: _crosshairBehavior,
            tooltipBehavior: _tooltipBehavior,
            legend: Legend(isVisible: false),
            enableAxisAnimation: true,
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              // Renders line chart
              LineSeries<SalesData, DateTime>(
                  dataSource: chartData,
                  enableTooltip: true,
                  animationDuration: 10,
                  trendlines: null,
                  color: AppColor.themeColor,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales)
            ]);
      }),
    );
  }

  togglebutton() {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < selectedInterval.length; i++) {
                  selectedInterval[i] = i == index;
                }
              },
              constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: MediaQuery.of(context).size.width / 2,
                  minHeight: 30,
                  maxHeight: 30),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: AppColor.themeColor,
              selectedColor: AppColor.bgColor,
              borderColor: HexColor('#97b858'),
              fillColor: AppColor.themeColor,
              color: AppColor.themeColor,
              isSelected: selectedInterval,
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Text(
                    'Daily',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    'Hourly',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            );
          }),
          Obx(() {
            return ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < selectedChart.length; i++) {
                  selectedChart[i] = i == index;
                }
                callSnakBar();
              },
              constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: MediaQuery.of(context).size.width / 2,
                  minHeight: 30,
                  maxHeight: 30),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: AppColor.themeColor,
              selectedColor: AppColor.bgColor,
              borderColor: HexColor('#97b858'),
              fillColor: AppColor.themeColor,
              color: AppColor.themeColor,
              isSelected: selectedChart,
              children: const [
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Icon(Icons.show_chart_rounded)),
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Icon(Icons.candlestick_chart_rounded)),
              ],
            );
          }),
        ],
      ),
    );
  }

  _itemRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(value, style: TextStyle(color: AppColor.themeColor))
        ],
      ),
    );
  }

  callSnakBar() {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        textStyle: TextStyle(
            color: AppColor.themeColor,
            fontWeight: FontWeight.w500,
            fontSize: 16),
        message: "Under construction",
        backgroundColor: AppColor.bgColor,
        icon: Icon(Icons.construction, color: AppColor.themeColor, size: 40),
        iconPositionLeft: 30,
        boxShadow: [
          BoxShadow(color: AppColor.themeColor, spreadRadius: 1, blurRadius: 2)
        ],
      ),
      animationDuration: const Duration(milliseconds: 800),
      displayDuration: const Duration(milliseconds: 800),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
