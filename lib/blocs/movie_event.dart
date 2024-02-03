part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMoviesEvent extends MovieEvent {}
