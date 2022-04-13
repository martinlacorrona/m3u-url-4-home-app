import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:m3u_url_4_home_app/rest/config_rest.dart';

import '../rest/model/config_model.dart';

class ConfigWidget extends StatefulWidget {
  const ConfigWidget({Key? key}) : super(key: key);

  @override
  _ConfigWidgetState createState() => _ConfigWidgetState();
}

class _ConfigWidgetState extends State<ConfigWidget> {
  bool _isLoading = true;
  bool _isError = false;
  ConfigModel _result = ConfigModel(
      regexPattern: 'regexPattern'.tr(),
      url: 'url'.tr(),
      port: 'loading'.tr(),
      cacheRefresh: 'loading'.tr());

  String _url = "";
  String _regexPattern = "";

  @override
  void initState() {
    super.initState();
    getConfigCall();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                Form.of(primaryFocus!.context!)!.save();
              },
              child: Column(
                children: [
                  TextFormField(
                    enabled: !_isLoading && !_isError,
                    key: UniqueKey(),
                    initialValue: _isLoading
                        ? 'loading'.tr()
                        : _isError
                            ? 'errorTryAgain'.tr()
                            : _result.url,
                    onSaved: (String? value) {
                      if (value != null) {
                        _url = value;
                        log("_url updated to: $_url");
                      }
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.code),
                      labelText: 'url'.tr(),
                    ),
                    validator: (String? value) {
                      return (value != null
                          && value.isNotEmpty
                          && RegExp(r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?').hasMatch(value))
                          ? null
                          : 'notUrl'.tr();
                    },
                  ),
                  TextFormField(
                    enabled: !_isLoading && !_isError,
                    key: UniqueKey(),
                    initialValue: _isLoading
                        ? 'loading'.tr()
                        : _isError
                            ? 'errorTryAgain'.tr()
                            : _result.regexPattern,
                    onSaved: (String? value) {
                      if (value != null) {
                        _regexPattern = value;
                        log("_regexPattern updated to: $_regexPattern");
                      }
                    },
                    decoration: InputDecoration(
                      icon: const Icon(Icons.filter_alt),
                      labelText: 'regexPattern'.tr(),
                    ),
                  ),
                ],
              )),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: _isLoading ? null : postConfigCall,
            child: Text('update'.tr()),
            style: _isError
                ? ElevatedButton.styleFrom(primary: Colors.redAccent)
                : null,
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
        _regexPattern = _result.regexPattern;
        _url = _result.url;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  postConfigCall() {
    _result.regexPattern = _regexPattern;
    _result.url = _url;
    setState(() {
      _isLoading = true;
    });
    postConfig(_result).then((configModel) {
      setState(() {
        _isLoading = false;
        _isError = false;
        _result = configModel;
      });
    }).catchError((error) {
      log("error: $error");
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }
}
