import 'package:flutter/material.dart';
import 'package:optimus_case/routes/create_view.dart';

Route? onGenerateRoute(RouteSettings settings) {
  if (settings.name != null) {
    final child = createView(settings.name!);

    if (child != null) {
      return MaterialPageRoute(builder: (_) => child, settings: settings);
    }
    return null;
  } else {
    return null;
  }
}
