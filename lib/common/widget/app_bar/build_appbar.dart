import 'package:flutter/material.dart';
import 'package:poc_flutter/common/navigation/nav.dart';
import 'package:poc_flutter/common/util/size_utils.dart';

AppBar buildAppBar(String title,
    {Color? bgColor,
    bool showBackButton = true,
    List<Widget> actions = const [],
    Color? backIconColor,
    Color? titleColor}) {
  BuildContext ctx = NavigationService.navKey.currentContext;
  final txt = Theme.of(ctx).textTheme;
  return AppBar(
    backgroundColor: bgColor ?? Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: showBackButton == false
        ? Container()
        : InkWell(
            onTap: () {
              Navigator.pop(ctx);
            },
            child: Icon(
              Icons.arrow_back,
              color: backIconColor ?? Colors.black,
            ),
          ),
    title: Text(
      title,
      style: txt.headlineMedium!.copyWith(color: titleColor),
      textScaler: TextScaler.linear(SizeUtils.textScaleFactor),
    ),
    actions: actions,
  );
}
