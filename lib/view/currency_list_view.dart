import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyListView extends StatefulWidget {
  const CurrencyListView({Key? key}) : super(key: key);

  @override
  State<CurrencyListView> createState() => _CurrencyListViewState();
}

class _CurrencyListViewState extends State<CurrencyListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _displaySelectorBottomSheet();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Top Gain',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${index + 1}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                              const Text(
                                'ATOM',
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              const Text(
                                '\$0.00000007',
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              const Icon(
                                CupertinoIcons.graph_square_fill,
                                size: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
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
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.local_fire_department_outlined),
                title: Text('Trending'),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                },
                leading: Icon(CupertinoIcons.up_arrow),
                title: Text('Top gain'),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                },
                leading: Icon(CupertinoIcons.arrow_down),
                title: Text('Top loose'),
              ),
            ],
          );
        });
  }
}
