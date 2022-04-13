class ConfigModel {
  String regexPattern;
  String url;
  final String port;
  final String cacheRefresh;

  ConfigModel({
    required this.regexPattern,
    required this.url,
    required this.port,
    required this.cacheRefresh,
  });

  @override
  String toString() {
    return 'ConfigModel{regexPattern: $regexPattern, url: $url, port: $port, cacheRefresh: $cacheRefresh}';
  }

  Map<String, String> toJson() {
    return {
      'regexPattern': regexPattern,
      'url': url,
      'port': port,
      'cacheRefresh': cacheRefresh,
    };
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