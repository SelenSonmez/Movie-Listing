part of 'movie_bloc.dart';

@immutable
sealed class MovieState {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitialState extends MovieState {}

final class MovieLoadingState extends MovieState {}

final class MovieLoadedState extends MovieState {
  final List<Content> movies;
  @override
  List<Object> get props => movies;

  const MovieLoadedState({required this.movies});
}
