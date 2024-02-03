import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/blocs/movie_bloc.dart';

import '../models/content.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 200,
          child: BlocBuilder<MovieBloc, MovieState>(
            bloc: BlocProvider.of<MovieBloc>(context),
            builder: (context, state) {
              if (state is MovieInitialState) {
                movieBloc.add(FetchMoviesEvent());

                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovieLoadedState) {
                List<Content> contents = [];
                if (title == "Popular") {
                  contents = state.popularMovies;
                } else {
                  contents = state.upcomingMovies;
                }
                return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: contents.length,
                  itemExtent: 135,
                  itemBuilder: (BuildContext context, int index) {
                    final Content currentContent = contents[index];
                    return Row(
                      children: [
                        GestureDetector(
                          // onTap: () => print(content.movieName),
                          // child: Text(currentContent.movieName)
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(currentContent.posterPath),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (state is MovieLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text("Error displaying previews"),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
