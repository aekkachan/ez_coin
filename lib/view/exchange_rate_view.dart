import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ExchangeRateView extends StatefulWidget {
  const ExchangeRateView({Key? key}) : super(key: key);

  @override
  State<ExchangeRateView> createState() => _ExchangeRateViewState();
}

class _ExchangeRateViewState extends State<ExchangeRateView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Lottie.asset('assets/under_construction2.json'),
    );
  }
}
