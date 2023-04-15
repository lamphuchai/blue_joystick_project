import 'package:blue_joystick/views/scan_blue_device/scan_blue_device.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:blue_joystick/views/setting/setting.dart';
import '../../views/home/home.dart';
import './route_names.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.home:
        return PageTransition(
            settings: settings,
            child: const HomeView(),
            type: PageTransitionType.rightToLeft);
      case RouteNames.scanBlueDevice:
        return PageTransition(
            settings: settings,
            child: const ScanBlueDeviceView(),
            type: PageTransitionType.rightToLeft);
      case RouteNames.setting:
        return PageTransition(
            settings: settings,
            child: const SettingView(),
            type: PageTransitionType.rightToLeft);
      default:
        return _errRoute();
    }
  }

  static Route<dynamic> _errRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(title: const Text("No route")),
              body: const Center(
                child: Text("no route"),
              ),
            ));
  }
}
