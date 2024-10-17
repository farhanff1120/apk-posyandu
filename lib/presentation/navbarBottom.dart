import 'package:flutter/material.dart';
import 'package:posyandu/presentation/pages/history.dart';
import 'package:posyandu/presentation/pages/home.dart';
import 'package:posyandu/presentation/pages/profil.dart';

class NavbarBot extends StatefulWidget {
  const NavbarBot({super.key});

  @override
  _NavbarBotState createState() => _NavbarBotState();
}

class _NavbarBotState extends State<NavbarBot> {
  int pageIndex = 0;

  final pages = [
    const Home(),
    const HistoryPage(),
    const Profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdcd7f3),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xff1e3883),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.home_outlined,
              size: 35,
              color: Colors.white,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.featured_play_list_rounded,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.featured_play_list_outlined,
              size: 35,
              color: Colors.white,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}