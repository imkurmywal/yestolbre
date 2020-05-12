import 'package:flutter/material.dart';
import 'package:yestolbre/widgets/carousel.dart';
import 'package:yestolbre/widgets/offer_in_list.dart';

class MerchantView extends StatefulWidget {
  @override
  _MerchantViewState createState() => _MerchantViewState();
}

class _MerchantViewState extends State<MerchantView> {
  var list = List<ListItem>();

  @override
  void initState() {
    super.initState();
    generateListItems();
  }

  void generateListItems() {
    setState(() {
      list = List<ListItem>.generate(
          10, (i) => i == 0 ? CreateCarousel() : OfferInList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Merchant Details"),
      ),
      body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            if (index == 0) {
              return Container(
                child: item.buildCarousel(context),
              );
            }
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {},
              child: Container(
                child: item.buildOfferInList(context),
              ),
            );
          }),
    );
  }
}

abstract class ListItem {
  Widget buildCarousel(BuildContext context);
  Widget buildOfferInList(BuildContext context);
}
