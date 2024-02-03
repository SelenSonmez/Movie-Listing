part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovieEvent extends MovieEvent {}

class FetchLatestMovieEvent extends MovieEvent {}

class FetchUpcomingMoviesEvent extends MovieEvent {}
