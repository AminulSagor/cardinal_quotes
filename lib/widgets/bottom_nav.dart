import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

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
