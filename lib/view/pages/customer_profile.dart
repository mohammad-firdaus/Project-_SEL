import 'package:flutter/material.dart';
import 'package:project_sel/view/pages/about_waste2wealth_page.dart';
import 'package:project_sel/view/pages/contact_us_page.dart';
import 'package:project_sel/view/pages/customer_order_history_page.dart';
import 'package:project_sel/view/pages/customer_settings_page.dart';
import 'package:project_sel/view/pages/welcome_page.dart';

class CustomerProfile extends StatelessWidget {
  final Color greenColor = const Color(0xFF42B642);

  const CustomerProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          color: greenColor,
        ),
        Column(
          children: [
            // Profile icon and name
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green[100],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.shield,
                      size: 56,
                      color: Colors.green[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Izz Ezzad',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Eco Warrior | Member since 2024',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 20), // Add padding at bottom
                child: Column(
                  children: [
                    // Info cards row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _infoCard(
                            '24',
                            'Item Recycled',
                            Icons.recycling_rounded,
                          ),
                          _infoCard('150kg', 'CO2 Saved', Icons.spa_outlined),
                        ],
                      ),
                    ),

                    Divider(thickness: 1, color: Colors.grey[300]),

                    // Account Information
                    _sectionHeader('Account Information'),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _infoListTile(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            value: 'customer@wastetowealth.com',
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _infoListTile(
                            icon: Icons.phone_rounded,
                            label: 'Phone',
                            value: '+60123456789',
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _infoListTile(
                            icon: Icons.location_on_outlined,
                            label: 'Location',
                            value: 'San Fransisco, CA',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    Divider(thickness: 1, color: Colors.grey[300]),

                    // Management Section
                    _sectionHeader('Management'),
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _menuListTile(
                            icon: Icons.people_alt_outlined,
                            text: 'Order History',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CustomerOrderHistoryPage();
                                  },
                                ),
                              );
                            },
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _menuListTile(
                            icon: Icons.settings_outlined,
                            text: 'Customer Settings',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CustomerSettingsPage();
                                  },
                                ),
                              );
                            },
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _menuListTile(
                            icon: Icons.info_outline,
                            text: 'About Waste2Wealth',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return WasteToWealthInfoPage();
                                  },
                                ),
                              );
                            },
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _menuListTile(
                            icon: Icons.contact_mail_outlined,
                            text: 'Contact Us',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ContactUsPage();
                                  },
                                ),
                              );
                            },
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _menuListTile(
                            icon: Icons.logout,
                            text: 'Logout',
                            textColor: Colors.red,
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return WelcomePage();
                                  },
                                ),
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoCard(String count, String label, IconData icon) {
    return SizedBox(
      height: 150, // adjusted height for better appearance
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: Colors.green[700]),
            SizedBox(height: 10),
            Text(
              count,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.green[900],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.green[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }

  Widget _infoListTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _menuListTile({
    required IconData icon,
    required String text,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.green[700]),
      title: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      dense: true,
      onTap: onTap,
      visualDensity: VisualDensity.compact,
    );
  }
}
