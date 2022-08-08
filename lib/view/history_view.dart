import 'package:ez_coin/controller/ez_coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  EZCoinCoinController coinController = Get.find();

  final List<SalesData> chartData = [];

  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _crosshairBehavior = CrosshairBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    coinController.getPrice('params');

    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Obx(() {
        if (coinController.dataPriceAvailable) {
          var price = coinController.trxPrice;
          List coinPrice = price.prices!;
          int i = 0;
          for (var element in coinPrice) {
            chartData.add(
                SalesData(DateTime.now().add(Duration(days: i)), element[1]));
            i--;
          }
        }
        return SfCartesianChart(
            crosshairBehavior: _crosshairBehavior,
            tooltipBehavior: _tooltipBehavior,
            legend: Legend(isVisible: true),
            enableAxisAnimation: true,
            title: ChartTitle(
              text: 'Bitcoin Historic Chart',
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              // Renders line chart
              LineSeries<SalesData, DateTime>(
                  dataSource: chartData,
                  enableTooltip: true,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales)
            ]);
      }),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
