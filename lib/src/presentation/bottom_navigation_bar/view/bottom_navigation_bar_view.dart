import 'package:flutter/material.dart';
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
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Likes"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
      // bottomNavigationBar: NavigationBar(
      //   destinations: [
      //     NavigationDestination(
      //       icon: const Icon(Icons.home),
      //       label: LocalizationKey.homePage.tr(context),
      //     ),
      //     NavigationDestination(
      //       icon: const Icon(Icons.settings),
      //       label: LocalizationKey.settings.tr(context),
      //     ),
      //     NavigationDestination(
      //       icon: const Icon(Icons.person),
      //       label: LocalizationKey.myProfile.tr(context),
      //     ),
      //   ],
      //   selectedIndex: navigationShell.currentIndex,
      //   onDestinationSelected: (index) {
      //     navigationShell.goBranch(
      //       index,
      //       initialLocation: index == navigationShell.currentIndex,
      //     );
      //   },
      // ),
    );
  }
}
