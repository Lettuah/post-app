import 'package:new_stacked/ui/views/home/home_view.dart';
import 'package:new_stacked/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
  ],
)
class App {}
