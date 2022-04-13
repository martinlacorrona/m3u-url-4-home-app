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

/*Future<ConfigModel> postCache(ConfigModel configModel) async {
  //TODO: pasar el modelo
  final response = await http
      .post(Uri.parse(environment + 'config'));

  if (response.statusCode == 200) {
    return ConfigModel.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to update cache.');
}*/