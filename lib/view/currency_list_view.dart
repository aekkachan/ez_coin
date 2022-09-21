import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ez_coin/constant/app_color.dart';
import 'package:ez_coin/controller/ez_coin_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:transparent_image/transparent_image.dart';

class CurrencyListView extends StatefulWidget {
  const CurrencyListView({Key? key}) : super(key: key);

  @override
  State<CurrencyListView> createState() => _CurrencyListViewState();
}

class _CurrencyListViewState extends State<CurrencyListView> {
  EZCoinCoinController coinController = Get.find();

  var colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    coinController.getCoin('market_cap_desc');

    return SafeArea(
      child: Container(
        color: AppColor().bgColor,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: GestureDetector(
                onTap: () {
                  _displaySelectorBottomSheet();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Market Cap',
                      style: TextStyle(
                          color: AppColor().themeColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: AppColor().themeColor,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Flexible(
                child: GetBuilder<EZCoinCoinController>(
              init: coinController,
              builder: (value) => ListView.builder(
                  itemCount: value.trxCoin.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Container(
                          color: HexColor('#DFDFDE'),
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${index < 9 ? '0' : ''}${index + 1}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  AnimatedTextKit(
                                    isRepeatingAnimation: true,
                                    repeatForever: true,
                                    animatedTexts: [
                                      ColorizeAnimatedText(
                                        value.trxCoin[index].symbol!
                                            .toUpperCase()
                                            .trim(),
                                        textAlign: TextAlign.start,
                                        textStyle: const TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                        colors: colorizeColors,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                '\$${value.trxCoin[index].currentPrice}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: '${value.trxCoin[index].image}',
                                width: 40,
                                height: 40,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )),
            //     child: Obx(() {
            //   if (coinController.dataCoinAvailable) {
            //     List<Coin> coins = coinController.trxCoin;
            //
            //     return ListView.builder(
            //         itemCount: coins.length,
            //         shrinkWrap: true,
            //         scrollDirection: Axis.vertical,
            //         itemBuilder: (context, index) {
            //           return Card(
            //             elevation: 4,
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(15.0),
            //             ),
            //             child: ClipPath(
            //               clipper: ShapeBorderClipper(
            //                   shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(15))),
            //               child: Container(
            //                 padding: const EdgeInsets.only(
            //                     top: 15, bottom: 15, left: 10, right: 10),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     Text(
            //                       '${index + 1}',
            //                       style: const TextStyle(
            //                           color: Colors.black,
            //                           fontWeight: FontWeight.w500,
            //                           fontSize: 20),
            //                     ),
            //                     Text(
            //                       coins[index].symbol!.toUpperCase(),
            //                       style: const TextStyle(
            //                           color: Colors.black38,
            //                           fontWeight: FontWeight.w700,
            //                           fontSize: 18),
            //                     ),
            //                     Text(
            //                       '\$${coins[index].currentPrice}',
            //                       style: const TextStyle(
            //                           color: Colors.black38,
            //                           fontWeight: FontWeight.w500,
            //                           fontSize: 14),
            //                     ),
            //                     FadeInImage.memoryNetwork(
            //                       placeholder: kTransparentImage,
            //                       image: '${coins[index].image}',
            //                       width: 50,
            //                       height: 50,
            //                       fit: BoxFit.fitWidth,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         });
            //   } else {
            //     return Shimmer.fromColors(
            //         baseColor: Colors.grey[300]!,
            //         highlightColor: Colors.grey[100]!,
            //         child: Card(
            //           elevation: 1,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(15.0),
            //           ),
            //           child: const SizedBox(
            //             height: 130,
            //             width: 240,
            //           ),
            //         ));
            //   }
            // })),
          ],
        ),
      ),
    );
  }

  _displaySelectorBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                onTap: () async {
                  Navigator.of(context).pop();
                  await coinController.getCoin('market_cap_desc');
                },
                leading: Icon(Icons.local_fire_department_outlined),
                title: Text('Market Cap'),
              ),
              ListTile(
                onTap: () async {
                  Navigator.of(context).pop();
                  await coinController.getCoin('volume_desc');
                },
                leading: Icon(CupertinoIcons.up_arrow),
                title: Text('High Volumn'),
              ),
            ],
          );
        });
  }
}
