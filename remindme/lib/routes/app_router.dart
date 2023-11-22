import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';
import 'guard/AuthGuard.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    /// Initial Route
    AutoRoute(path: '/alfraganusa', page:  Test.page),
    AutoRoute(path: '/', page:  Test.page, initial: true,guards: [AuthGuard()]),
    AutoRoute(path: '/login', page:  WelcomeRoute.page)
  ];
}