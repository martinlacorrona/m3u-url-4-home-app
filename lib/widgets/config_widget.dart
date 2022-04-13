import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:m3u_url_4_home_app/rest/config_rest.dart';

class ConfigWidget extends StatefulWidget {
  const ConfigWidget({Key? key}) : super(key: key);

  @override
  _ConfigWidgetState createState() => _ConfigWidgetState();
}

class _ConfigWidgetState extends State<ConfigWidget> {
  bool _isLoading = true;
  bool _isError = false;
  late ConfigModel _result;

  @override
  void initState() {
    super.initState();
    getConfigCall();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Center(
            child: Text(_isLoading ? 'loading'.tr() : _isError ? 'errorTryAgain'.tr() : _result.toString()),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: _isLoading ? null : getConfigCall,
            child: Text('update'.tr()),
            style: _isError ? ElevatedButton.styleFrom(
              primary: Colors.redAccent
            ) : null,
          ),
        ),
      ],
    );
  }

  getConfigCall() {
    setState(() {
      _isLoading = true;
    });
    getConfig().then((configModel) {
      setState(() {
        _isLoading = false;
        _isError = false;
        _result = configModel;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }
}
