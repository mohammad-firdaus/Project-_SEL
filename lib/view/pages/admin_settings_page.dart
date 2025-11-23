import 'package:flutter/material.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({super.key});

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  final TextEditingController _fullNameController = TextEditingController(
    text: 'Admin User',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'admin@wastetowealth.com',
  );

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isEditingProfile = false;

  bool _emailNotifications = true;
  bool _newOrdersNotification = true;
  bool _userSignupsNotification = true;
  bool _systemAlertsNotification = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveNotificationSettings() {
    // Placeholder for saving notification settings
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Notification settings saved')));
  }

  void _changePassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.lock_outline, color: Colors.green[700]),
              SizedBox(width: 8),
              Text(
                'Change Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Text(
                    'For security reasons, please enter your current password and choose a strong new password.',
                    style: TextStyle(color: Colors.green[800], fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _currentPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    hintText: 'Enter your current password',
                    prefixIcon: Icon(Icons.lock, color: Colors.green[700]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.green[700]!,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter a strong new password',
                    prefixIcon: Icon(
                      Icons.lock_reset,
                      color: Colors.green[700],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.green[700]!,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    hintText: 'Re-enter your new password',
                    prefixIcon: Icon(
                      Icons.lock_person,
                      color: Colors.green[700],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.green[700]!,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate and change password
                if (_newPasswordController.text ==
                        _confirmPasswordController.text &&
                    _newPasswordController.text.isNotEmpty) {
                  // Here you would typically call an API to change the password
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Password changed successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  _currentPasswordController.clear();
                  _newPasswordController.clear();
                  _confirmPasswordController.clear();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match or are empty'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Change Password'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No back icon as per request, so no leading widget
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Admin Settings'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage your admin account',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),

            SizedBox(height: 24),

            // Profile Information Header and Edit button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile Information',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEditingProfile = !_isEditingProfile;
                    });
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(
                    _isEditingProfile ? 'Save Profile' : 'Edit Profile',
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Full Name Field (disabled / read-only)
            _profileField(
              label: 'Full Name',
              icon: Icons.person_outline,
              controller: _fullNameController,
              readOnly: !_isEditingProfile,
            ),

            SizedBox(height: 16),

            // Email Address Field (disabled / read-only)
            _profileField(
              label: 'Email Address',
              icon: Icons.email_outlined,
              controller: _emailController,
              readOnly: !_isEditingProfile,
            ),

            SizedBox(height: 36),

            // Security Section
            Text(
              'Security',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(height: 8),
            OutlinedButton(
              onPressed: _changePassword,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              child: Center(child: Text('Change Password')),
            ),

            SizedBox(height: 36),

            // Notifications Section
            Text(
              'Notifications',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(height: 12),

            _notificationToggle(
              label: 'Email Notifications',
              subLabel: 'Receive updates via email',
              value: _emailNotifications,
              onChanged: (val) => setState(() => _emailNotifications = val),
            ),

            _notificationToggle(
              label: 'New Orders',
              subLabel: 'Notify on new customer orders',
              value: _newOrdersNotification,
              onChanged: (val) => setState(() => _newOrdersNotification = val),
            ),

            _notificationToggle(
              label: 'User Signups',
              subLabel: 'Notify on new user registrations',
              value: _userSignupsNotification,
              onChanged: (val) =>
                  setState(() => _userSignupsNotification = val),
            ),

            _notificationToggle(
              label: 'System Alerts',
              subLabel: 'Critical system notifications',
              value: _systemAlertsNotification,
              onChanged: (val) =>
                  setState(() => _systemAlertsNotification = val),
            ),

            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: _saveNotificationSettings,
              icon: Icon(Icons.save, color: Colors.white),
              label: Text(
                'Save Notification Settings',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 36),

            // Platform Settings Section
            Text(
              'Platform Settings',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            SizedBox(height: 12),

            _settingsMenuItem(
              icon: Icons.payment_outlined,
              label: 'Payment Gateway',
              subtitle: 'Configure ToyyloPay settings',
              onTap: () {
                // Navigate or show config
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment Gateway tapped')),
                );
              },
            ),

            _settingsMenuItem(
              icon: Icons.shield_outlined,
              label: 'Privacy & Security',
              subtitle: 'Manage security settings',
              onTap: () {
                // Navigate or show privacy settings
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Privacy & Security tapped')),
                );
              },
            ),

            SizedBox(height: 36),

            // Admin Account info box
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green[900],
                    ),
                  ),
                  SizedBox(height: 12),
                  _accountInfoRow('Account Created', 'January 2024'),
                  _accountInfoRow('Access Level', 'Super Admin'),
                  _accountInfoRow('Last Modified', 'Oct 29, 2025'),
                ],
              ),
            ),

            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _profileField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green[700]),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  Widget _notificationToggle({
    required String label,
    required String subLabel,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subLabel),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        // ignore: deprecated_member_use
        activeColor: Colors.green,
      ),
    );
  }

  Widget _settingsMenuItem({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.green[700]),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _accountInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.green[800],
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Text(value, style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
