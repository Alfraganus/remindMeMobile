import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remindme/bloc/BottomNavBarState.dart';
import '../../BottomNavigationBar.dart';
import '../../bloc/BottomNavBarCubit.dart';


@RoutePage()
class NotificationList extends StatelessWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavBarCubit = BlocProvider.of<BottomNavBarCubit>(context);

    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Notification list"),
          ),
          resizeToAvoidBottomInset: true,
          body: Center(
            child: bottomWidgetList.elementAt(state.WidgetIndex),
          ),
          bottomNavigationBar: CommonBottomNavigationBar(
            currentIndex: state.WidgetIndex,
            onTap: (index) {
              bottomNavBarCubit.changeNavIndex(index);
            },
          ),
        );
      },
    );
  }
}
