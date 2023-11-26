// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:remindme/login/Screens/Welcome/welcome_screen.dart' as _i4;
import 'package:remindme/notifications/addNotification/main.dart' as _i1;
import 'package:remindme/notifications/notificationList/main.dart' as _i2;
import 'package:remindme/Test.dart' as _i3;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AddNotification.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddNotification(),
      );
    },
    NotificationList.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.NotificationList(),
      );
    },
    Test.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.Test(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.WelcomeScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddNotification]
class AddNotification extends _i5.PageRouteInfo<void> {
  const AddNotification({List<_i5.PageRouteInfo>? children})
      : super(
          AddNotification.name,
          initialChildren: children,
        );

  static const String name = 'AddNotification';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.NotificationList]
class NotificationList extends _i5.PageRouteInfo<void> {
  const NotificationList({List<_i5.PageRouteInfo>? children})
      : super(
          NotificationList.name,
          initialChildren: children,
        );

  static const String name = 'NotificationList';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.Test]
class Test extends _i5.PageRouteInfo<void> {
  const Test({List<_i5.PageRouteInfo>? children})
      : super(
          Test.name,
          initialChildren: children,
        );

  static const String name = 'Test';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.WelcomeScreen]
class WelcomeRoute extends _i5.PageRouteInfo<void> {
  const WelcomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
