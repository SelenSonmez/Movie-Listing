import 'package:flutter/material.dart';
import 'package:netflix/blocs/movie_bloc.dart';
import 'package:netflix/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/content.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          final cubit = AppBarCubit();
          cubit.setOffset(_scrollController.offset);
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        onPressed: () {},
        child: const Icon(
          Icons.cast,
          color: Colors.white,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(scrollOffset: scrollOffset);
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: const [
          SliverToBoxAdapter(child: ContentHeader()),
          SliverToBoxAdapter(child: CardPreview(title: 'Popular')),
          SliverToBoxAdapter(child: CardPreview(title: 'Upcoming')),
        ],
      ),
    );
  }
}
