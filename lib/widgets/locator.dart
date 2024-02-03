import 'package:get_it/get_it.dart';
import 'package:netflix/data/movie_api_client.dart';
import 'package:netflix/data/movie_repository.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => MovieRepository());
  locator.registerLazySingleton(() => MovieApiClient());
}
