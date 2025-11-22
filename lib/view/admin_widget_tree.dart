import 'package:flutter/material.dart';
import 'package:project_sel/data/notifier.dart';
import 'package:project_sel/view/pages/admin_home.dart';
import 'package:project_sel/view/pages/admin_orders.dart';
import 'package:project_sel/view/pages/admin_products.dart';
import 'package:project_sel/view/pages/admin_profile.dart';
import 'package:project_sel/view/pages/admin_shop.dart';
import 'package:project_sel/widgets/admin_navbar_widget.dart';

List<Widget> pages = [
  AdminHome(),
  AdminShop(),
  AdminProducts(),
  AdminOrders(),
  AdminProfile(),
];

class AdminWidgetTree extends StatelessWidget {
  const AdminWidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    // Reset the notifier to 0 for this user type to avoid stale state from previous logins
    selectedPageNotifier.value = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF42B642),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo_nobg.PNG'),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: AdminNavigationBarWidget(),
    );
  }
}
