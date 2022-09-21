import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail(
      {Key? key,
      this.imgUrl = "",
      this.topic = "",
      this.content = "",
      this.imgTag = ""})
      : super(key: key);

  final dynamic imgUrl;
  final dynamic topic;
  final dynamic content;
  final dynamic imgTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 35,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                topic,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: Hero(
                  tag: imgTag,
                  flightShuttleBuilder: (flightContext, animation, direction,
                      fromContext, toContext) {
                    Widget widget = toContext.widget;
                    return ScaleTransition(
                      scale: animation.drive(
                        Tween<double>(begin: 0.0, end: 1.0),
                      ),
                      child: widget,
                    );
                  },
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imgUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  content,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
