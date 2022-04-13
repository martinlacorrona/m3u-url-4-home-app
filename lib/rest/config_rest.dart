import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app/config.dart';
import 'model/config_model.dart';

Future<ConfigModel> getConfig() async {
  final response = await http
      .get(Uri.parse(environment + 'config'));

  if (response.statusCode == 200) {
    return ConfigModel.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load config.');
}

Future<ConfigModel> postConfig(ConfigModel configModel) async {
  String query = Uri(queryParameters: configModel.toJson()).query;
  final response = await http.post(
      Uri.parse(environment + 'config?$query'),
  );

  if (response.statusCode == 201) {
    return ConfigModel.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to update config.');
}