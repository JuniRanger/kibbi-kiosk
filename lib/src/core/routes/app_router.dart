import 'package:kibbi_kiosk/src/presentation/pages/pages.dart';
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: SplashRoute.page),
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(path: '/main', page: MainRoute.page),
      ];
}