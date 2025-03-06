import 'package:kibbi_kiosk/src/core/utils/utils.dart';
import 'package:kibbi_kiosk/src/presentation/components/components.dart';
import 'package:kibbi_kiosk/src/presentation/theme/light_theme.dart';
import 'package:kibbi_kiosk/src/presentation/theme/theme.dart';

import 'package:kibbi_kiosk/src/presentation/theme/theme/theme.dart';
import 'package:kibbi_kiosk/src/repository/repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:provider/provider.dart';
import 'core/di/dependency_manager.dart';
import 'core/routes/app_router.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait({
          AppTheme.create,
        }),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            final AppTheme theme = snapshot.data?[0];
            return ScreenUtilInit(
              designSize: const Size(1194, 900),
              builder: (context, child) {
                return ChangeNotifierProvider(
                  create: (BuildContext context) => theme,
                  child: MaterialApp.router(
                    theme: lightTheme(),
                    scrollBehavior: CustomScrollBehavior(),
                    debugShowCheckedModeBanner: false,
                    routerDelegate: appRouter.delegate(),
                    routeInformationParser: appRouter.defaultRouteParser(),
                    locale: Locale('es', 'MX'),
                    color: Style.white,
                    builder: (context, child) => ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: child ?? const SizedBox.shrink(),
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
