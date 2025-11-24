import 'package:flutter/material.dart';
import 'login_page.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginPage();
              },
            ),
            (route) => false,
          );
        },
        child: const Text('Go to Login Page'),
      ),
    );
  }
}
