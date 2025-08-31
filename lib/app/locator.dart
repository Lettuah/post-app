import 'package:get_it/get_it.dart';
import 'package:new_stacked/services/post_service.dart';
import 'package:new_stacked/services/second_post_service.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => PostService());
  locator.registerLazySingleton(() => SecondPostService());
}
