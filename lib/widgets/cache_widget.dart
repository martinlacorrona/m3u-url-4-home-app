import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../rest/cache_rest.dart';

class CacheWidget extends StatefulWidget {
  const CacheWidget({Key? key}) : super(key: key);

  @override
  _CacheWidgetState createState() => _CacheWidgetState();
}

class _CacheWidgetState extends State<CacheWidget> {
  bool _isLoading = true;
  String _dateResult = "";

  @override
  void initState() {
    super.initState();
    getCache().then((cacheModel) {
      setState(() {
        _isLoading = false;
        _dateResult = cacheModel.lastUpdate.toString();
      });
    });
    //TODO: onError (control)
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
              _isLoading ? "Loading...".tr() : "lastCacheUpdate".tr() + _dateResult),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: _isLoading ? null : () {
              setState(() {
                _isLoading = true;
              });
              postCache().then((cacheModel) {
                setState(() {
                  _isLoading = false;
                  _dateResult = cacheModel.lastUpdate.toString();
                });
              });
              //TODO: onError (control)
            },
            child: Text('refreshCache'.tr()),
          ),
        ),
      ],
    );
  }
}
