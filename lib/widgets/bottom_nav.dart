import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/home_view.dart';
import '../sound/sound_list_view.dart';
import '../soul_checking/soul_checking_view.dart';
import '../quote/quote_view.dart';
import '../save/save_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    Widget destination = HomeView(); // default

    switch (index) {
      case 0:
        destination = HomeView();
        break;
      case 1:
        destination = SoundListView(category: 'cardinal_sounds');
        break;
      case 2:
        destination = SoulCheckingView();
        break;
      case 3:
        destination = QuoteView(category: 'top_quotes');
        break;
      case 4:
        //destination = SaveView(category: 'saved');
        break;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8EDDA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.brown.shade800,
        unselectedItemColor: Colors.brown.shade400,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
        unselectedLabelStyle: TextStyle(fontSize: 12.sp),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/bottom_navigation/home.png', width: 22.w),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/bottom_navigation/sounds.png', width: 22.w),
            label: 'Sounds',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/bottom_navigation/soul.png', width: 22.w),
            label: 'Soul',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/bottom_navigation/top.png', width: 22.w),
            label: 'Top',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/bottom_navigation/more.png', width: 22.w),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
