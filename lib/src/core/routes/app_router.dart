
import 'package:kiosk/src/presentation/pages/pages.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';


@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        MaterialRoute(path: '/', page: SplashRoute.page),
        MaterialRoute(path: '/login', page: LoginRoute.page),
        MaterialRoute(path: '/main', page: MainRoute.page),
        MaterialRoute(path: '/lang', page: LanguagesRoute.page),
        MaterialRoute(path: '/help', page: HelpRoute.page),
        MaterialRoute(path: '/web-view', page: WebViewRoute.page),
      ];
}
