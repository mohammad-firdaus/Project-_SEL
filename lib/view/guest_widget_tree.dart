import 'package:flutter/material.dart';
import 'package:project_sel/data/notifier.dart';
import 'package:project_sel/view/pages/customer_home.dart';
import 'package:project_sel/view/pages/customer_shop.dart';
import 'package:project_sel/view/pages/customer_cart.dart';
import 'package:project_sel/view/pages/customer_profile.dart';
import 'package:project_sel/widgets/customer_navbar_widget.dart';

List<Widget> pages = [
  CustomerHome(),
  CustomerShop(),
  CustomerCart(),
  CustomerProfile(),
];

class GuestWidgetTree extends StatelessWidget {
  const GuestWidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo_nobg.PNG'),
        ),
        title: Text('WasteToWealth'),
        centerTitle: false,
        backgroundColor: Color(0xFF42B642),
        actions: [
          IconButton(
            onPressed: () {
              isDarkmode.value = !isDarkmode.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkmode,
              builder: (context, darkMode, child) {
                return Icon(darkMode ? Icons.dark_mode : Icons.light_mode);
              },
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectedPageNotifier.value =
              (selectedPageNotifier.value + 1) % pages.length;
        },
        child: Icon(Icons.navigate_next),
      ),
      bottomNavigationBar: CustomerNavigationbarWidget(),
    );
  }
}
