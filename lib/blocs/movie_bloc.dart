import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:netflix/data/movie_repository.dart';
import 'package:netflix/models/content.dart';
import 'package:netflix/widgets/locator.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository = locator<MovieRepository>();
  MovieBloc() : super(MovieInitialState()) {
    on<FetchMoviesEvent>(
      (event, emit) async {
        emit(MovieLoadingState());
        try {
          final List<Content> popularMovies =
              await movieRepository.getPopular();
          final List<Content> nowPlayingMovies =
              await movieRepository.getNowPlaying();
          final List<Content> upcomingMovies =
              await movieRepository.getUpcoming();
          emit(MovieLoadedState(
              inTheaterMovies: nowPlayingMovies,
              popularMovies: popularMovies,
              upcomingMovies: upcomingMovies));
        } catch (e) {
          print(e.toString());
        }
      },
    );
    // on<FetchPopularMovieEvent>((event, emit) async {
    //   emit(MovieLoadingState());
    //   try {
    //     final List<Content> popularMovies = await movieRepository.getPopular();
    //     emit(MovieLoadedState(movies: popularMovies));
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // });
    // on<FetchLatestMovieEvent>(
    //   (event, emit) async {
    //     emit(MovieLoadingState());
    //     try {
    //       final List<Content> nowPlayingMovies =
    //           await movieRepository.getNowPlaying();
    //       emit(MovieLoadedState(movies: nowPlayingMovies));
    //     } catch (e) {
    //       print(e.toString());
    //     }
    //   },
    // );
    // on<FetchUpcomingMoviesEvent>(
    //   (event, emit) async {
    //     emit(MovieLoadingState());
    //     try {
    //       final List<Content> upcomingMovies =
    //           await movieRepository.getUpcoming();

    //       emit(MovieLoadedState(movies: upcomingMovies));
    //     } catch (e) {
    //       print(e.toString());
    //     }
    //   },
    // );
  }
}
