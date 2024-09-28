import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poc_flutter/app/app.dart';
import 'package:poc_flutter/common/constant/env.dart';
import 'package:poc_flutter/common/util/log.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(
      App(env: EnvValue.development),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
