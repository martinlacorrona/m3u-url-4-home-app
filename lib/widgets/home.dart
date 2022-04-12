import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:m3u_url_4_home_app/widgets/config_widget.dart';

import 'cache_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appTitle'.tr()),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: const [
                  ConfigWidget(),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: const [
                  CacheWidget(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
