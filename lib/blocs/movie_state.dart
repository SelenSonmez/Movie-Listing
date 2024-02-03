part of 'movie_bloc.dart';

@immutable
sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitialState extends MovieState {}

final class MovieLoadingState extends MovieState {}

final class MovieLoadedState extends MovieState {
  final List<Content> inTheaterMovies;
  final List<Content> popularMovies;
  final List<Content> upcomingMovies;
  @override
  List<Object> get props => [inTheaterMovies, popularMovies, upcomingMovies];

  const MovieLoadedState(
      {required this.inTheaterMovies,
      required this.popularMovies,
      required this.upcomingMovies});
}
