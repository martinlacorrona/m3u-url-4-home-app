import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:m3u_url_4_home_app/rest/config_rest.dart';

import '../rest/cache_rest.dart';

class ConfigWidget extends StatefulWidget {
  const ConfigWidget({Key? key}) : super(key: key);

  @override
  _ConfigWidgetState createState() => _ConfigWidgetState();
}

class _ConfigWidgetState extends State<ConfigWidget> {
  bool _isLoading = true;
  late ConfigModel _result;

  @override
  void initState() {
    super.initState();
    getConfig().then((configModel) {
      setState(() {
        _isLoading = false;
        _result = configModel;
      });
    });
    //TODO: onError (control)
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Center(
            child: Text(
                _isLoading ? "Loading...".tr() : _result.toString()),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: _isLoading ? null : () {
              setState(() {
                _isLoading = true;
              });
              getConfig().then((configModel) {
                setState(() {
                  _isLoading = false;
                  _result = configModel;
                });
              });
            },
            child: Text('update'.tr()),
          ),
        ),
      ],
    );
  }
}
