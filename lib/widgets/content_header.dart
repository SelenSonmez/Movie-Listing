import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/blocs/movie_bloc.dart';

import '../models/content.dart';

class ContentHeader extends StatelessWidget {
  const ContentHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("In Theaters",
                style: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.white)),
          ),
          SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: 15,
                options: CarouselOptions(
                    height: 300,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.50,
                    pageSnapping: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn),
                itemBuilder: (context, index, realIndex) {
                  return BlocBuilder<MovieBloc, MovieState>(
                    builder: (context, state) {
                      final movieBloc = BlocProvider.of<MovieBloc>(context);
                      if (state is MovieInitialState) {
                        movieBloc.add(FetchMoviesEvent());
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieLoadedState) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                              state.inTheaterMovies[index].posterPath),
                        );
                      } else if (state is MovieLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Text("Error");
                      }
                    },
                  );
                },
              ))
        ]),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:video_player/video_player.dart';

// import '../models/content.dart';
// import '../services/content_service.dart';
// import 'responsive.dart';
// import 'vertical_icon_button.dart';

// class ContentHeader extends StatelessWidget {
//   final Content featuredContent;

//   const ContentHeader({super.key, required this.featuredContent});

//   @override
//   Widget build(BuildContext context) {
//     return Responsive(
//       mobile: _ContentHeaderMobile(featuredContent: featuredContent),
//       desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
//     );
//   }
// }

// class _ContentHeaderMobile extends StatelessWidget {
//   const _ContentHeaderMobile({required this.featuredContent});
//   final Content featuredContent;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           height: 500,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage(featuredContent.posterPath),
//                   fit: BoxFit.cover)),
//         ),
//         Container(
//           height: 500,
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [Colors.black, Colors.transparent],
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter)),
//         ),
//         Positioned(
//             bottom: 110,
//             child: SizedBox(
//               width: 250,
//               child: Image.asset(featuredContent.movieName),
//             )),
//         Positioned(
//             left: 0,
//             right: 0,
//             bottom: 40,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 VerticalIconButton(
//                     icon: Icons.add,
//                     title: "List",
//                     onTap: () => print("My List")),
//                 _PlayButton(),
//                 VerticalIconButton(
//                     icon: Icons.info_outline,
//                     title: "Info",
//                     onTap: () => print("Info"))
//               ],
//             ))
//       ],
//     );
//   }
// }

// class _ContentHeaderDesktop extends StatefulWidget {
//   final Content featuredContent;

//   const _ContentHeaderDesktop({super.key, required this.featuredContent});

//   @override
//   __ContentHeaderDesktopState createState() => __ContentHeaderDesktopState();
// }

// class __ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
//   late VideoPlayerController _videoController;
//   bool _isMuted = true;

//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.networkUrl(Uri.parse(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       })
//       ..setVolume(0)
//       ..play();
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _videoController.value.isPlaying
//           ? _videoController.pause()
//           : _videoController.play(),
//       child: Stack(
//         alignment: Alignment.bottomLeft,
//         children: [
//           AspectRatio(
//             aspectRatio: _videoController.value.isInitialized
//                 ? _videoController.value.aspectRatio
//                 : 2.344,
//             child: _videoController.value.isInitialized
//                 ? VideoPlayer(_videoController)
//                 : Image.asset(
//                     widget.featuredContent.posterPath,
//                     fit: BoxFit.cover,
//                   ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: -1.0,
//             child: AspectRatio(
//               aspectRatio: _videoController.value.isInitialized
//                   ? _videoController.value.aspectRatio
//                   : 2.344,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.black, Colors.transparent],
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: 60.0,
//             right: 60.0,
//             bottom: 150.0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: 250.0,
//                   child: Image.asset(widget.featuredContent.posterPath),
//                 ),
//                 const SizedBox(height: 15.0),
//                 Text(
//                   widget.featuredContent.description,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.w500,
//                     shadows: [
//                       Shadow(
//                         color: Colors.black,
//                         offset: Offset(2.0, 4.0),
//                         blurRadius: 6.0,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Row(
//                   children: [
//                     _PlayButton(),
//                     const SizedBox(width: 16.0),
//                     ElevatedButton.icon(
//                       // padding:
//                       // const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
//                       onPressed: () {
//                         ContentService().fetchPopular();
//                       },

//                       // color: Colors.white,
//                       icon: const Icon(Icons.info_outline, size: 30.0),
//                       label: const Text(
//                         'More Info',
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20.0),
//                     if (_videoController.value.isInitialized)
//                       IconButton(
//                         icon: Icon(
//                           _isMuted ? Icons.volume_off : Icons.volume_up,
//                         ),
//                         color: Colors.white,
//                         iconSize: 30.0,
//                         onPressed: () => setState(() {
//                           _isMuted
//                               ? _videoController.setVolume(100)
//                               : _videoController.setVolume(0);
//                           _isMuted = _videoController.value.volume == 0;
//                         }),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PlayButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       // padding: !Responsive.isDesktop(context)
//       // ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
//       // : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
//       onPressed: () => print('Play'),
//       icon: const Icon(Icons.play_arrow, size: 30.0),
//       label: const Text(
//         'Play',
//         style: TextStyle(
//           fontSize: 16.0,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }
