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
  bool _isError = false;
  DateTime _dateResult = DateTime.now();

  @override
  void initState() {
    super.initState();
    getCacheCall();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(_isLoading
              ? "Loading...".tr()
              : _isError
                  ? 'errorTryAgain'.tr()
                  : "lastCacheUpdate".tr() + _dateResult.toString()),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: _isLoading ? null : postCacheCall,
            child: Text('refreshCache'.tr()),
            style: _isError
                ? ElevatedButton.styleFrom(primary: Colors.redAccent)
                : null,
          ),
        ),
      ],
    );
  }

  getCacheCall() {
    getCache().then((cacheModel) {
      setState(() {
        _isLoading = false;
        _dateResult = cacheModel.lastUpdate;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }

  postCacheCall() {
    setState(() {
      _isLoading = true;
    });
    postCache().then((cacheModel) {
      setState(() {
        _isLoading = false;
        _isError = false;
        _dateResult = cacheModel.lastUpdate;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    });
  }
}
