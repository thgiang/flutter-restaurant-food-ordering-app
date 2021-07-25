import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/news.dart';
import 'package:http/http.dart' as http;
import '../global-constant.dart';

class NewsProvider extends ChangeNotifier {
  NewsModel news = new NewsModel();

  Future<void> getNews(context) async {
    print(Uri.parse(apiUrl + "/api/news"));
    try {
      final response = await http.get(
        Uri.parse(apiUrl + "/api/news"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        news = NewsModel.fromJson(item);
      } else {
      }
    } catch (e) {
    }
    news.loading = false;
    notifyListeners();
  }
}