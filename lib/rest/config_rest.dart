import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app/config.dart';

Future<ConfigModel> getConfig() async {
  final response = await http
      .get(Uri.parse(environment + 'config'));

  if (response.statusCode == 200) {
    return ConfigModel.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load config.');
}

/*Future<ConfigModel> postCache(ConfigModel configModel) async {
  //TODO: pasar el modelo
  final response = await http
      .post(Uri.parse(environment + 'config'));

  if (response.statusCode == 200) {
    return ConfigModel.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to update cache.');
}*/

class ConfigModel {
  final String regexPattern;
  final String url;
  final String port;
  final String cacheRefresh;

  const ConfigModel({
    required this.regexPattern,
    required this.url,
    required this.port,
    required this.cacheRefresh,
  });

  @override
  String toString() {
    return 'ConfigModel{regexPattern: $regexPattern, url: $url, port: $port, cacheRefresh: $cacheRefresh}';
  }

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      regexPattern: json['regexPattern'],
      url: json['url'],
      port: json['port'],
      cacheRefresh: json['cacheRefresh'],
    );
  }
}