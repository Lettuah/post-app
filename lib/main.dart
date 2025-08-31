// main.dart
import 'package:flutter/material.dart';
import 'package:new_stacked/app/locator.dart';
import 'package:new_stacked/ui/views/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Post App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'inter'),
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: StartupView(),
    );
  }
}
