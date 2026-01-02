import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_sel/view/admin_widget_tree.dart';
import 'package:project_sel/view/customer_widget_tree.dart';
import 'package:project_sel/view/guest_widget_tree.dart';
import 'package:project_sel/view/pages/forgot_password_page.dart';
import 'package:project_sel/view/pages/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCustomer = true; // State for the toggle button
  bool passwordVisible = false;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toggleUserType(bool customerSelected) {
    setState(() => isCustomer = customerSelected);
  }

  void togglePasswordVisibility() {
    setState(() => passwordVisible = !passwordVisible);
  }

  // --- LOGIC: SIGN IN + ROLE VERIFICATION + NOTIFICATION ---
  Future<void> _handleSignIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Please enter your email and password", isError: true);
      return;
    }

    setState(() => isLoading = true);

    try {
      // 1. Firebase Auth Sign In
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // 2. Fetch User Data from Firestore to verify role
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists && mounted) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        String dbRole = userData['role'] ?? 'Customer';

        // --- ROLE SELECTION CHECK ---
        // Verify that the user picked the correct role on the UI toggle
        String selectedRole = isCustomer ? 'Customer' : 'Admin';

        if (dbRole != selectedRole) {
          // If the role in database doesn't match the UI selection, stop login
          await FirebaseAuth.instance.signOut();
          throw "Access Denied: Your account is registered as $dbRole, but you selected $selectedRole.";
        }

        // Check if profile is complete
        bool isComplete = userData['isProfileComplete'] == true;

        // 3. Navigate to the correct Tree based on verified role
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => dbRole == 'Admin'
                ? const AdminWidgetTree()
                : const CustomerWidgetTree(),
          ),
              (route) => false,
        );

        // 4. Show Reminder if profile is incomplete
        if (!isComplete) {
          _showProfileReminder();
        }
      } else {
        throw "User record not found in the database.";
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.message ?? "Authentication failed", isError: true);
    } catch (e) {
      _showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showProfileReminder() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("🔔 Profile incomplete! Please update it in Settings."),
          backgroundColor: Colors.orange[900],
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
          action: SnackBarAction(
            label: "GO",
            textColor: Colors.white,
            onPressed: () {
              // Navigation to settings page logic here
            },
          ),
        ),
      );
    });
  }

  void _showSnackBar(String m, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(m),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final greenColor = const Color(0xFF4CAF50);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(color: Colors.white),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: greenColor,
          ),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  // White Logo Box from your design
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Icon(Icons.spa_outlined, color: greenColor, size: 50),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'WasteToWealth',
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Login Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome Back', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),

                        // Role Selection Row
                        _buildRoleToggle(greenColor),

                        const SizedBox(height: 20),
                        _inputLabel("Email Address"),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _inputDecoration('Enter your email', Icons.email_outlined),
                        ),
                        const SizedBox(height: 15),
                        _inputLabel("Password"),
                        TextField(
                          controller: passwordController,
                          obscureText: !passwordVisible,
                          decoration: _inputDecoration('Enter your password', Icons.lock_outline).copyWith(
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: togglePasswordVisibility,
                            ),
                          ),
                        ),

                        _buildForgotPassword(greenColor),
                        const SizedBox(height: 20),

                        // Action Buttons
                        _buildSignInButton(greenColor),
                        const SizedBox(height: 15),
                        _buildGuestButton(greenColor),
                        const SizedBox(height: 15),
                        _buildSignUpLink(greenColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- UI WIDGET HELPERS ---

  Widget _buildRoleToggle(Color greenColor) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(child: _toggleBtn("Customer", Icons.person_outline, isCustomer, () => toggleUserType(true), greenColor)),
          Expanded(child: _toggleBtn("Admin", Icons.admin_panel_settings_outlined, !isCustomer, () => toggleUserType(false), greenColor)),
        ],
      ),
    );
  }

  Widget _toggleBtn(String label, IconData icon, bool active, VoidCallback onTap, Color greenColor) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: active ? Colors.white : Colors.grey),
      label: Text(label, style: TextStyle(color: active ? Colors.white : Colors.grey)),
      style: ElevatedButton.styleFrom(
        backgroundColor: active ? greenColor : Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _inputLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
  );

  InputDecoration _inputDecoration(String hint, IconData icon) => InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
  );

  Widget _buildForgotPassword(Color greenColor) => Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage())),
      child: Text('Forgot Password?', style: TextStyle(color: greenColor, fontWeight: FontWeight.w600, fontSize: 13)),
    ),
  );

  Widget _buildSignInButton(Color greenColor) => SizedBox(
    width: double.infinity, height: 48,
    child: ElevatedButton(
      onPressed: isLoading ? null : _handleSignIn,
      style: ElevatedButton.styleFrom(backgroundColor: greenColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
    ),
  );

  Widget _buildGuestButton(Color greenColor) => SizedBox(
    width: double.infinity, height: 48,
    child: OutlinedButton(
      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const GuestWidgetTree()), (route) => false),
      style: OutlinedButton.styleFrom(side: BorderSide(color: greenColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text('Continue as Guest', style: TextStyle(color: greenColor, fontWeight: FontWeight.bold, fontSize: 16)),
    ),
  );

  Widget _buildSignUpLink(Color greenColor) => Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?  "),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage())),
          child: Text('Sign Up', style: TextStyle(color: greenColor, fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}