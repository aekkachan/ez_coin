import 'package:ez_coin/controller/ez_coin_controller.dart';
import 'package:ez_coin/view/news_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  EZCoinCoinController coinController = Get.find();

  @override
  Widget build(BuildContext context) {
    // coinController.getPopularNews('data');
    // coinController.getLastedNews('data');

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'popular'.tr,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
                _popularNews(),
                _lastedNews(),
              ],
            )),
      )),
    );
  }

  _popularNews() {
    return Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
        child: SizedBox(
            height: 130.0,
            child: Obx(() {
              if (coinController.dataPopularAvailable) {
                var article = coinController.trxPopularNews.articles;

                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: article!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return NewsDetail(
                              imgUrl: article[index].urlToImage,
                              topic: article[index].title,
                              content: article[index].content,
                            );
                          }));
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      opacity: 0.6,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          '${article[index].urlToImage}'))),
                              width: 220,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${article[index].title}',
                                    textAlign: TextAlign.start,
                                    maxLines: 3,
                                    overflow: TextOverflow.fade,
                                    softWrap: true,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const SizedBox(
                        height: 130,
                        width: 240,
                      ),
                    ));
              }
            })));
  }

  _lastedNews() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'lasted'.tr,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30),
        ),
        Obx(() {
          if (coinController.dataLastedNewsAvailable) {
            var article = coinController.trxLastedNews.articles!;

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                var imgTag = 'imgLastedNews_$index';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NewsDetail(
                        imgUrl: article[index].urlToImage,
                        topic: article[index].title,
                        content: article[index].content,
                        imgTag: imgTag,
                      );
                    }));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 10, top: 8, bottom: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${article[index].title}',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('${article[index].content}',
                                  maxLines: 4,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Hero(
                            tag: imgTag,
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: article[index].urlToImage!,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0.5,
                  color: Colors.black26,
                );
              },
            );
          } else {
            return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                    )));
          }
        }),
      ],
    );
  }
}
