import 'package:flutter/material.dart';
import 'package:poc_flutter/common/constant/constant_assets.dart';
import 'package:poc_flutter/common/util/size_utils.dart';
import 'package:poc_flutter/common/widget/page_wrapper.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: Center(
        child: Image.asset(
          Assets.logo,
          height: 80.w,
          width: 80.w,
        ),
      ),
    );
  }
}
