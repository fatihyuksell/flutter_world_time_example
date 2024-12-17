import 'package:flutter/material.dart';
import 'package:optimus_case/routes/static_routes.dart';
import 'package:optimus_case/views/clocks/clocks_view.dart';
import 'package:optimus_case/views/splash/splash_view.dart';

Widget? createView(String route) {
  switch (route) {
    case Routes.splash:
      return const SplashView();
    case Routes.clocks:
      return const ClocksView();

    default:
      return null;
  }
}
