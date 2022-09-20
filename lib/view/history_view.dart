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
  final List<bool> selectedInterval = <bool>[true, false].obs;
  final List<bool> selectedChart = <bool>[true, false].obs;

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

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            chart(),
            togglebutton(),
          ],
        ),
      ),
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

  togglebutton() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.blue[700],
              selectedColor: Colors.white,
              fillColor: Colors.blue[200],
              color: Colors.blue[400],
              isSelected: selectedInterval,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    'Daily',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    'Hourly',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            );
          }),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: VerticalDivider(
              color: Colors.black,
              thickness: 0.5,
            ),
          ),
          Obx(() {
            return ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < selectedChart.length; i++) {
                  selectedChart[i] = i == index;
                }
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.blue[700],
              selectedColor: Colors.white,
              fillColor: Colors.blue[200],
              color: Colors.blue[400],
              isSelected: selectedChart,
              children: const [
                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Icon(Icons.show_chart_rounded)),
                Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Icon(Icons.candlestick_chart_rounded)),
              ],
            );
          }),
        ],
      ),
    );
  }

  callSnakBar() {
    const snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
