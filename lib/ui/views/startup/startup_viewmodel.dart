import 'package:new_stacked/app/locator.dart';
import 'package:new_stacked/ui/views/home/home_view.dart';
import 'package:new_stacked/ui/views/second_home/second_home_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewmodel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void goInfinite() async {
    await _navigationService.navigateToView(SecondHomeView());
  }

  void goNormal() async {
    await _navigationService.navigateToView(HomeView());
  }
}
