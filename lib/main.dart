// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zangteevn/models/news.dart';
import 'package:zangteevn/providers/news.dart';
import 'providers/news.dart';
import 'global-constant.dart';

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
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
          title: 'ZangTee - Drinks & more',
          home: Container(
            color: Colors.deepPurple,
            child: SafeArea(
              bottom: false,
              child: Scaffold(
                bottomNavigationBar: Container(
                  child: BottomNavbar(),
                ),
                body: Column(
                  children: [
                    Container(
                      child: Column(children: [
                        Container(
                          child: HeaderWelcome(),
                          margin: EdgeInsets.fromLTRB(0, s1, 0, s3),
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
              ),
            ),
          )),
    );
  }
}

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black26))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(s1),
                child: SvgPicture.asset(
                    svgIcons['drink'].toString(),
                    color: Colors.deepPurple,
                    height: 25,
                    semanticsLabel: 'foodDelivery'),
              ),
              Text('Đồ uống',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(s1),
                child: SvgPicture.asset(
                    svgIcons['lunchBox'].toString(),
                    color: Colors.deepPurple,
                    height: 25,
                    semanticsLabel: 'discountVoucher'),
              ),
              Text('Hoa quả',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(s1),
                child: SvgPicture.asset(
                    svgIcons['creditCard'].toString(),
                    height: 25,
                    color: Colors.deepPurple,
                    semanticsLabel: 'customerService'),
              ),
              Text('Tài khoản',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple,)),
            ],
          )
        ],
      ),
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
  void initState() {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.getNews(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.all(s3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tin mới từ ZangTee',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
                padding: EdgeInsets.only(top: s1),
                child: Consumer<NewsProvider>(
                    builder: (context, newsProvider, child) {
                  if (newsProvider.news.loading) {
                    return Text('Đang tải tin tức mới...');
                  } else if (newsProvider.news.success != null &&
                      newsProvider.news.success == false) {
                    return Text('Lỗi khi tải tin');
                  } else if (newsProvider.news.success != null &&
                      newsProvider.news.success == true &&
                      newsProvider.news.data != null) {
                    return Container(
                      height: 420,
                      width: double.infinity,
                      child: GridView.count(
                        primary: false,
                        crossAxisSpacing: s1,
                        mainAxisSpacing: s1,
                        crossAxisCount: 2,
                        children: newsProvider.news.data!.data
                            .map((news) => NewsItem(
                                thumbnail: news.thumbnail, title: news.title, description: news.description))
                            .toList(),
                      ),
                    );
                  } else {
                    print(newsProvider.news.success);
                    return Text('Lỗi tải tinmmn');
                  }
                })),
          ],
        ),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String description;

  const NewsItem({Key? key, required this.thumbnail, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
            children: [
              Image.network(thumbnail),
              Padding(
                padding: const EdgeInsets.fromLTRB(s2, s1, s2, s1),
                child: Text(title, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(s2, 0, s2, 0),
                child: Text(description, overflow: TextOverflow.ellipsis, maxLines: 3),
              )
            ]
        ));
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
              color: Colors.white, fontWeight: FontWeight.bold, height: 2)),
      Text('Chúc bạn một ngày tốt lành', style: TextStyle(color: Colors.white)),
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
                              height: 14.0,
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
