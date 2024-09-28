import 'dart:async';

import 'package:flutter/material.dart';
import 'package:poc_flutter/common/navigation/nav.dart';
import 'package:poc_flutter/common/util/size_utils.dart';
import 'package:poc_flutter/feature/dashboard/ui/dashboart_page.dart';
import 'package:poc_flutter/feature/splash/ui/splash_widget.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      NavigationService.pushAndRemoveUntil(const DashboardPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils.init(context: context);
    return SplashWidget();
  }
}
