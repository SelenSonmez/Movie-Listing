import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/blocs/movie_bloc.dart';
import 'package:netflix/cubits/app_bar/app_bar_cubit.dart';
import 'package:netflix/widgets/locator.dart';

import 'screens/screens.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Netflix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: InkRipple.splashFactory,
        scaffoldBackgroundColor: Colors.black,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AppBarCubit>(
            create: (context) => AppBarCubit(),
          ),
          BlocProvider<MovieBloc>(
            create: (context) => MovieBloc(),
          ),
        ],
        child: NavScreen(),
      ),
    );
  }
}
