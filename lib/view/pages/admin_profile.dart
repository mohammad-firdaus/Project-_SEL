import 'package:flutter/material.dart';
import 'package:project_sel/view/pages/about_waste2wealth_page.dart';
import 'package:project_sel/view/pages/admin_profile_user_management_page.dart';
import 'package:project_sel/view/pages/admin_settings_page.dart';
import 'package:project_sel/view/pages/contact_us_page.dart';
import 'package:project_sel/view/pages/welcome_page.dart';

class AdminProfile extends StatelessWidget {
  final Color greenColor = const Color(0xFF42B642);
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
                    'Admin User',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Super Admin',
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
                          _infoCard('8,567', 'Total Users', Icons.group),
                          _infoCard('15.2K', 'Items Sold', Icons.bar_chart),
                          _infoCard(
                            'Admin',
                            'Access Level',
                            Icons.admin_panel_settings,
                          ),
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
                            value: 'admin@wastetowealth.com',
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _infoListTile(
                            icon: Icons.badge_outlined,
                            label: 'Role',
                            value: 'Super Admin',
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _infoListTile(
                            icon: Icons.account_box_outlined,
                            label: 'Account Type',
                            value: 'Administrator',
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
                            text: 'User Management',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UserManagementPage();
                                  },
                                ),
                              );
                            },
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          _menuListTile(
                            icon: Icons.settings_outlined,
                            text: 'Admin Settings',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AdminSettingsPage();
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

                    SizedBox(height: 16),

                    Divider(thickness: 1, color: Colors.grey[300]),

                    // System Information box
                    _sectionHeader('System Information'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: greenColor, // Dark green
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'System Information',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12),
                            _systemInfoRow('Platform Version', 'v2.5.0'),
                            Divider(height: 8, color: Colors.white24),
                            _systemInfoRow('Last Login', 'Today, 08:24 AM'),
                            Divider(height: 8, color: Colors.white24),
                            _systemInfoRow('Access Level', 'Full Access'),
                            Divider(height: 8, color: Colors.white24),
                            _systemInfoRow('Server Status', 'Online'),
                          ],
                        ),
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

  Widget _systemInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 13)),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
