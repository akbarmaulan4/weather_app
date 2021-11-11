import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/utils/Utils.dart';
import 'package:weather_app/utils/color_code.dart';
import 'package:weather_app/widget/font/text_meta.dart';
import 'package:weather_app/widget/pull_refresh_widget.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin{

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PullRefreshWidget(
        onRefresh: (){},
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
                ListTile(title: TextMeta('vuasbhdjinkamsa')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
