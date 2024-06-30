import 'dart:math';

import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static List<Widget> allRoutes = [];
  static List<Widget> get allMyRoutes => allRoutes;
  static Future<T?> routeTo<T extends Object?>(
      BuildContext context, Widget page, 
      {int delayMS = 0}) async {
    T? t;
    await Future.delayed(Duration(milliseconds: delayMS), () async {
      allRoutes.add(page);
      print('allRoutes t>>> $allRoutes');
      t = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => page));
    });
    return t;
  }

  static Future<T?> routeRemoveTo<T extends Object?>(
      BuildContext context, Widget page,
      {int delayMS = 0}) async {
    T? t;
    await Future.delayed(Duration(milliseconds: delayMS), () async {
      try {
        allRoutes.removeLast();
        allRoutes.add(page);
      } catch (e) {}
      t = await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    });
    return t;
  }

  static Future<T?> routeRemoveAllTo<T extends Object?>(
      BuildContext context, Widget page,
      {int delayMS = 0}) async {
    T? t;
    await Future.delayed(Duration(milliseconds: delayMS), () async {
      allRoutes.clear();
      allRoutes.add(page);
      print('allRoutes ra>>> $allRoutes');
      t = await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (route) => false,
      );
    });
    return t;
  }

  static Future pop<T extends Object?>(BuildContext context,
      {int delayMS = 0, T? result, bool sub = false}) async {
    await Future.delayed(Duration(milliseconds: delayMS), () async {
      if (!sub) {
        try {
          allRoutes.removeLast();
        } catch (e) {}
        print('allRoutes>>> $allRoutes');
      }
      Navigator.pop(context, result);
    });
  }
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(
      debugLabel: 'key${Random().nextInt(999999999)}');
  static BuildContext get context => AppNavigator.navigatorKey.currentContext!;
}
