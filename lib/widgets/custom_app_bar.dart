import 'package:flutter/material.dart';
import 'package:netflix/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.scrollOffset = 0.0});
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        color: Colors.black
            .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
        child: Responsive(
          mobile: _CustomAppBarMobile(),
          desktop: _CustomAppBarDesktop(),
        ));
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  const _CustomAppBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(children: [
        Image.asset("assets/images/netflix_logo0.png"),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _AppBarButton(title: "TV Shows", onTap: () => print("TV SHows")),
              _AppBarButton(title: "Movies", onTap: () => print("Movies")),
              _AppBarButton(title: "My List", onTap: () => print("My List")),
            ],
          ),
        )
      ]),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  const _CustomAppBarDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(children: [
        Image.asset("assets/images/netflix_logo1.png"),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _AppBarButton(title: "Home", onTap: () => print("Home")),
              _AppBarButton(title: "TV Shows", onTap: () => print("TV SHows")),
              _AppBarButton(title: "Movies", onTap: () => print("Movies")),
              _AppBarButton(title: "My List", onTap: () => print("My List")),
              _AppBarButton(title: "Latest", onTap: () => print("My List")),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  iconSize: 28,
                  color: Colors.white),
              _AppBarButton(title: "KIDS", onTap: () => print("Kids")),
              _AppBarButton(title: "DVD", onTap: () => print("DVD")),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(Icons.card_giftcard),
                  iconSize: 28,
                  color: Colors.white),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                  iconSize: 28,
                  color: Colors.white),
            ],
          ),
        )
      ]),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  const _AppBarButton({super.key, required this.title, required this.onTap});
  final VoidCallback onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
