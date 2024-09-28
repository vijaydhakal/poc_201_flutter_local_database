import 'package:flutter/material.dart';
import 'package:poc_flutter/app/theme.dart';
import 'package:poc_flutter/common/bloc/multi_repo_provider_listing.dart';
import 'package:poc_flutter/common/constant/env.dart';
import 'package:poc_flutter/common/constant/strings.dart';
import 'package:poc_flutter/common/navigation/nav.dart';
import 'package:poc_flutter/common/route/route_generator.dart';
import 'package:poc_flutter/common/route/routes.dart';
import 'package:poc_flutter/common/widget/global_error_widget.dart';

class App extends StatefulWidget {
  final Env env;
  const App({super.key, required this.env});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProviderListing(
      env: widget.env,
      child: MaterialApp(
        navigatorKey: NavigationService.navKey,
        builder: (context, Widget? widget) {
          setErrorBuilder(context);
          return widget!;
        },
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: CustomTheme.lightTheme,
        title: Strings.APP_TITLE,
        initialRoute: Routes.root,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
