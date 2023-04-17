import 'package:flutter/material.dart';

import '../config/theme.dart';

class CustomNavBar extends StatefulWidget {
  int currentIndex;
  CustomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      selectedIconTheme: const IconThemeData(size: 32, opacity: 1),
      selectedFontSize: 16,
      unselectedIconTheme: const IconThemeData(opacity: 0.5),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.secondary,
      backgroundColor: AppColors.primary,
      currentIndex: widget.currentIndex,
      onTap: (index) => setState(() {
        widget.currentIndex = index;
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
