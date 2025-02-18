import 'package:bloc_clean_architecture/src/common/localization/localization_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavigationBarView extends StatelessWidget {
  const BottomNavigationBarView({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: [
          /// Routine
          SalomonBottomBarItem(
            icon: Icon(Icons.home_outlined),
            title: CoreText.bodyMedium(LocalizationKey.routines.value),
            selectedColor: Colors.blue,
          ),

          /// Add Cosmetic
          SalomonBottomBarItem(
            icon: Icon(Icons.add_circle_outline_outlined),
            title: CoreText.bodyMedium(LocalizationKey.cosmetics.value),
            selectedColor: Colors.pink,
          ),

          /// Add Plans
          SalomonBottomBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            title: CoreText.bodyMedium(LocalizationKey.plans.value),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person_outlined),
            title: CoreText.bodyMedium(LocalizationKey.myProfile.value),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
