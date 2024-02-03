import 'package:netflix/data/movie_api_client.dart';
import 'package:netflix/models/content.dart';
import 'package:netflix/widgets/locator.dart';

class MovieRepository {
  MovieApiClient movieApiClient = locator<MovieApiClient>();
  Future<List<Content>> getPopular() async {
    return await movieApiClient.fetchPopular();
  }

  Future<List<Content>> getNowPlaying() async {
    return await movieApiClient.fetchNowPlaying();
  }

  Future<List<Content>> getUpcoming() async {
    return await movieApiClient.fetchUpcoming();
  }
}
