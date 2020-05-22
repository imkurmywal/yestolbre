import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yestolbre/src/merchnat_view.dart';
import 'package:yestolbre/src/models/merchnat.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class CreateCarousel implements ListItem {
  Merchant merchant;
  CreateCarousel({@required this.merchant});
  Widget buildOfferInList(BuildContext context) => null;
  Widget buildCarousel(BuildContext context) {
    return MyCarousel(
      merchant: merchant,
    );
  }
}

class MyCarousel extends StatefulWidget {
  Merchant merchant;
  MyCarousel({@required this.merchant});
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<MyCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      CarouselSlider(
        items: imageSliders(),
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.merchant.carousel.map((url) {
          int index = widget.merchant.carousel.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            // borderRadius: BorderRadius.circular(30.0),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                widget.merchant.logoUrl,
                width: 80,
                height: 80,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.merchant.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.merchant.address,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.merchant.category,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      "Call Now",
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox.fromSize(
                      size: Size(40, 40), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: Theme.of(context).primaryColor, // button color
                          child: InkWell(
                            splashColor: Colors.grey, // splash color
                            onTap: () {
                              launch("tel:+${widget.merchant.phoneNumber}");
                            }, // button pressed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.call, color: Colors.white), // icon
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      )
    ]);
  }

  List<Widget> imageSliders() {
    final List<Widget> imageSliders = widget.merchant.carousel
        .map((item) => Container(
              child: Container(
                // margin: EdgeInsets.all(5.0),
                child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
              ),
            ))
        .toList();
    return imageSliders;
  }
}
