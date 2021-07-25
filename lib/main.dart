// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'models/news.dart';
import 'bootstrap.dart';

const Map<String, String> svgIcons = {
  'star': 'assets/svg/star.svg',
  'drink': 'assets/svg/drink.svg',
  'creditCard': 'assets/svg/creditCard.svg',
  'lunchBox': 'assets/svg/lunchBox.svg',
  'motorbike': 'assets/svg/motorbike.svg',
  'order': 'assets/svg/order.svg',
  'memberCard': 'assets/svg/memberCard.svg',
  'membership': 'assets/svg/membership.svg',
  'foodDelivery': 'assets/svg/food-delivery.svg',
  'discountVoucher': 'assets/svg/discount-voucher.svg',
  'customerService': 'assets/svg/customer-service.svg',
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => News()),
      ],
      child: MaterialApp(
          title: 'ZangTee - Drinks & more',
          home: Scaffold(
            body: Column(
              children: [
                Container(
                  child: Column(children: [
                    Container(
                      child: HeaderWelcome(),
                      margin: EdgeInsets.fromLTRB(0, s5, 0, s3),
                    ),
                    Container(child: HeaderActions()),
                  ]),
                  alignment: Alignment.center,
                  color: Colors.deepPurple,
                  width: double.infinity,
                  padding: EdgeInsets.all(s1),
                ),
                Container(child: NewsWidget()),
              ],
            ),
          )),
    );
  }
}

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(s3, 0, s3, 0),
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: s2),
        child: Text('Tin mới từ ZangTee',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class HeaderWelcome extends StatelessWidget {
  const HeaderWelcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Column(children: [
        Text('ZANGTEE - DRINKS & MORE',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                height: 2)),
        Text('Chúc bạn một ngày tốt lành',
            style: TextStyle(color: Colors.white)),
      ]);
  }
}

class HeaderActions extends StatelessWidget {
  const HeaderActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black26))),
            child: Padding(
              padding: const EdgeInsets.only(bottom: s2),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hạng thành viên: Kim cương',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text('1800',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: SvgPicture.asset(svgIcons['star'].toString(),
                              color: Colors.amber,
                              height: 14,
                              semanticsLabel: 'Star'),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: s2),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(s1),
                      child: SvgPicture.asset(
                          svgIcons['foodDelivery'].toString(),
                          height: 30,
                          semanticsLabel: 'foodDelivery'),
                    ),
                    Text('Đặt hàng',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(s1),
                      child: SvgPicture.asset(
                          svgIcons['discountVoucher'].toString(),
                          height: 30,
                          semanticsLabel: 'discountVoucher'),
                    ),
                    Text('Khuyến mại',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(s1),
                      child: SvgPicture.asset(
                          svgIcons['customerService'].toString(),
                          height: 30,
                          semanticsLabel: 'customerService'),
                    ),
                    Text('Hỗ trợ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      margin: EdgeInsets.fromLTRB(s2, s2, s2, s5),
      padding: EdgeInsets.fromLTRB(s3, s3, s3, s3),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [shadow],
      ),
    );
  }
}
