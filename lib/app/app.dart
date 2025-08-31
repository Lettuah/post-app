// lib/app/app.dart
import 'package:stacked/stacked_annotations.dart';
import 'package:new_stacked/ui/views/startup/startup_view.dart';
import 'package:new_stacked/ui/views/home/home_view.dart';
import 'package:new_stacked/ui/views/second_home/second_home_view.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SecondHomeView),
  ],
  dependencies: [
    // Register common services here so generator creates app.locator.dart
    LazySingleton(classType: NavigationService),
  ],
)
class AppSetup {}
