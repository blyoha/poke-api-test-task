import 'package:flutter/material.dart';

import '../config/theme.dart';
import 'random_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = const [
    SearchPage(),
    RandomPage(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildNavBar(),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
    );
  }

  Widget _buildNavBar() {
    return BottomNavigationBar(
      selectedIconTheme: const IconThemeData(size: 32, opacity: 1),
      selectedFontSize: 16,
      unselectedIconTheme: const IconThemeData(opacity: 0.5),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.secondary,
      backgroundColor: AppColors.primary,
      currentIndex: currentIndex,
      onTap: (index) => setState(() {
        currentIndex = index;
      }),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_mark_rounded),
          label: "Random",
        ),
      ],
    );
  }
}
