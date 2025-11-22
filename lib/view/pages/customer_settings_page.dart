import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomerSettingsPage extends StatefulWidget {
  const CustomerSettingsPage({super.key});

  @override
  State<CustomerSettingsPage> createState() => _CustomerSettingsPageState();
}

class _CustomerSettingsPageState extends State<CustomerSettingsPage> {
  // Profile image file selected by user, null means default asset image
  File? _profileImage;

  // Controllers for editable fields
  final TextEditingController _usernameController = TextEditingController(
    text: 'Alex Johnson',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'alex.johnson@email.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+60 12-345-6789',
  );

  final TextEditingController _streetController = TextEditingController(
    text: '123 Green Street, Eco Valley',
  );
  final TextEditingController _cityController = TextEditingController(
    text: 'Kuala Lumpur',
  );
  final TextEditingController _stateController = TextEditingController(
    text: 'Wilayah Persekutuan',
  );
  final TextEditingController _zipController = TextEditingController(
    text: '50450',
  );
  final TextEditingController _countryController = TextEditingController(
    text: 'Malaysia',
  );

  // Controllers for password change fields
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isEditingProfile = false;
  bool _showChangePassword = false;

  final _formKeyProfile = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  final primaryGreen = const Color(0xFF42B642);

  // Pick image from gallery using image_picker
  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Save edited profile info
  void _saveProfile() {
    if (_formKeyProfile.currentState!.validate()) {
      setState(() {
        _isEditingProfile = false;
        // Here you can also save the profile info to your backend or local storage
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated')));
    }
  }

  // Cancel editing profile
  void _cancelEditProfile() {
    setState(() {
      _isEditingProfile = false;
      // Reset fields to original values if needed
      // For demo, keep text as is - you can enhance this to reset
    });
  }

  // Validate and change password
  void _changePassword() {
    if (_formKeyPassword.currentState!.validate()) {
      // Here implement your password change logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password changed'),
          backgroundColor: primaryGreen,
        ),
      );
      // Clear password fields and hide box
      setState(() {
        _showChangePassword = false;
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _countryController.dispose();

    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // To scroll when keyboard appears or content expands
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Manage your account settings',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // Profile Picture Section
              const Text(
                'Profile Picture',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: _pickProfileImage,
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: _profileImage == null
                              ? Image.asset(
                                  'assets/images/profile_user.jpg',
                                  fit: BoxFit.cover,
                                )
                              : Image.file(_profileImage!, fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryGreen,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Click the camera icon to change your profile picture\nAccepted: .JPG, PNG, GIF (Max 1MB)',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              // Personal Information Section Header & Edit Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditingProfile = !_isEditingProfile;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isEditingProfile
                          ? Colors.grey.shade400
                          : primaryGreen,
                    ),
                    child: Text(_isEditingProfile ? 'Cancel' : 'Edit Profile'),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Form(
                key: _formKeyProfile,
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'Username',
                      controller: _usernameController,
                      icon: Icons.person,
                      enabled: _isEditingProfile,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: 'Email Address',
                      controller: _emailController,
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      enabled: _isEditingProfile,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email cannot be empty';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: 'Phone Number',
                      controller: _phoneController,
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      enabled: _isEditingProfile,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone number cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Show Save button only during edit mode
                    if (_isEditingProfile)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: _cancelEditProfile,
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _saveProfile,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Delivery Address Section
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                label: 'Street Address',
                controller: _streetController,
                enabled: _isEditingProfile,
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'City',
                      controller: _cityController,
                      enabled: _isEditingProfile,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'State',
                      controller: _stateController,
                      enabled: _isEditingProfile,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: 'ZIP Code',
                      controller: _zipController,
                      enabled: _isEditingProfile,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: 'Country',
                      controller: _countryController,
                      enabled: _isEditingProfile,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Security Section Header
              const Text(
                'Security',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),

              // Change Password Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: primaryGreen,
                  side: BorderSide(color: primaryGreen),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _showChangePassword = !_showChangePassword;
                  });
                },
                child: Text(
                  _showChangePassword
                      ? 'Cancel Change Password'
                      : 'Change Password',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              // Expandable Change Password box
              if (_showChangePassword) ...[
                const SizedBox(height: 15),
                Form(
                  key: _formKeyPassword,
                  child: Column(
                    children: [
                      _buildPasswordField(
                        label: 'Current Password',
                        controller: _currentPasswordController,
                      ),
                      const SizedBox(height: 10),
                      _buildPasswordField(
                        label: 'New Password',
                        controller: _newPasswordController,
                      ),
                      const SizedBox(height: 10),
                      _buildPasswordField(
                        label: 'Confirm Password',
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: _changePassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Text(
                              'Save Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 30),

              // Account Information Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  // ignore: deprecated_member_use
                  border: Border.all(color: primaryGreen.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _accountInfoRow('Member Since', 'January 2024'),
                    const SizedBox(height: 10),
                    _accountInfoRow('Account Type', 'Eco Warrior'),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Account Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    TextInputType? keyboardType,
    bool enabled = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: primaryGreen) : null,
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: enabled ? primaryGreen : Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: enabled ? primaryGreen : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: primaryGreen, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return '$label cannot be empty';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: primaryGreen, width: 2),
        ),
      ),
    );
  }

  Widget _accountInfoRow(String title, String detail) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Text(detail),
      ],
    );
  }
}
