import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';
import 'guard/AuthGuard.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    /// Initial Route
    AutoRoute(page: HomeRoute.page, initial: true),

    /// Login Route
    AutoRoute(page: LoginRoute.page),

    /// Protected Route
    AutoRoute(page: ProfileRoute.page, guards: [AuthGuard()]),

    /// Normal Route
    AutoRoute(page: AboutRoute.page),
  ];
}