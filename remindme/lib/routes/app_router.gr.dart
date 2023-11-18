// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:remindme/login/Screens/Welcome/welcome_screen.dart' as _i2;
import 'package:remindme/Test.dart' as _i1;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    Test.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.Test(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.Test]
class Test extends _i3.PageRouteInfo<void> {
  const Test({List<_i3.PageRouteInfo>? children})
      : super(
          Test.name,
          initialChildren: children,
        );

  static const String name = 'Test';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.WelcomeScreen]
class WelcomeRoute extends _i3.PageRouteInfo<void> {
  const WelcomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
