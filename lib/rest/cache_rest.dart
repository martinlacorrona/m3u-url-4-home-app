import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app/config.dart';
import 'model/cache_model.dart';

Future<CacheModel> getCache() async {
  final response = await http
      .get(Uri.parse(environment + 'cache'));

  if (response.statusCode == 200) {
    return CacheModel.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load cache.');
}

Future<CacheModel> postCache() async {
  final response = await http
      .post(Uri.parse(environment + 'cache'));

  if (response.statusCode == 200) {
    return CacheModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update cache.');
  }
}