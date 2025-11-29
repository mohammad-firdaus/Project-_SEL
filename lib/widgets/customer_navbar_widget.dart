import 'package:flutter/material.dart';
import 'package:project_sel/data/notifier.dart';

class CustomerNavigationbarWidget extends StatelessWidget {
  const CustomerNavigationbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Shop',
            ),
            NavigationDestination(
              icon: Icon(Icons.insert_drive_file_outlined),
              label: 'Catalogue',
            ),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
          selectedIndex: selectedPage,
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
        );
      },
    );
  }
}
