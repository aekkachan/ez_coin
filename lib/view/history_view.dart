import 'package:ez_coin/controller/ez_coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
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

  String lastPrice = "0.00";

  var themeColor = HexColor('#8baa50');
  var bgColor = HexColor('#32343b');

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true, header: 'BTC', borderColor: themeColor, borderWidth: 1);
    _crosshairBehavior = CrosshairBehavior(enable: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    coinController.getPrice('params');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
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
        color: bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: '1 BTC / USD\n',
                  style: TextStyle(
                    color: themeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: '\$ 10.0',
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 30.0,
                        )),
                  ],
                ),
              ),
            ),
            togglebutton(),
            chart(),
          ],
        ),
      )),
    );
  }

  chart() {
    return Container(
      padding: const EdgeInsets.all(10),
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
                  color: themeColor,
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
              selectedBorderColor: themeColor,
              selectedColor: bgColor,
              borderColor: HexColor('#97b858'),
              fillColor: themeColor,
              color: themeColor,
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
              selectedBorderColor: themeColor,
              selectedColor: bgColor,
              borderColor: HexColor('#97b858'),
              fillColor: themeColor,
              color: themeColor,
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

  callSnakBar() {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        textStyle: TextStyle(
            color: themeColor, fontWeight: FontWeight.w500, fontSize: 16),
        message: "Under construction",
        backgroundColor: bgColor,
        icon: Icon(Icons.construction, color: themeColor, size: 40),
        iconPositionLeft: 30,
        boxShadow: [
          BoxShadow(color: themeColor, spreadRadius: 1, blurRadius: 2)
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
