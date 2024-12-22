import 'package:flutter/material.dart';
import 'package:optimus_case/routes/static_routes.dart';
import 'package:optimus_case/views/time_zone_details/time_zone_details_view.dart';
import 'package:optimus_case/views/home/home_view.dart';
import 'package:optimus_case/views/splash/splash_view.dart';

Widget? createView(String route) {
  switch (route) {
    case Routes.splash:
      return const SplashView();
    case Routes.home:
      return const HomeView();
    case Routes.timeZoneDetails:
      return const TimeZoneDetailsView();

    default:
      return null;
  }
}
