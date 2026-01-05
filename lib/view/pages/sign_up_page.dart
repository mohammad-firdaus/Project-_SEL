import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isCustomer = true;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool isTermsAccepted = false;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!isTermsAccepted) {
      _showSnackBar("Please accept the Terms & Conditions");
      return;
    }

    setState(() => isLoading = true);

    try {
      // 1. Create Auth User
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // 2. Save Role & Name to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'fullName': fullNameController.text.trim(),
        'email': emailController.text.trim(),
        'role': isCustomer ? 'Customer' : 'Admin',
        'isProfileComplete': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _showSnackBar("Account created successfully!");
      // Navigator.pushReplacementNamed(context, '/home');

    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.message ?? "An authentication error occurred");
    } catch (e) {
      _showSnackBar("An unexpected error occurred");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final greenColor = const Color(0xFF4CAF50);
    return Scaffold(
      appBar: AppBar(backgroundColor: greenColor, elevation: 0),
      body: Stack(
        children: [
          Container(color: Colors.white),
          Container(height: MediaQuery.of(context).size.height * 0.4, color: greenColor),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                children: [
                  const Icon(Icons.eco_outlined, color: Colors.white, size: 60),
                  const SizedBox(height: 10),
                  const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRoleToggle(greenColor),
                          const SizedBox(height: 20),
                          _buildTextField("Full Name *", fullNameController, Icons.person_outlined),
                          _buildTextField("Email Address *", emailController, Icons.email_outlined, keyboard: TextInputType.emailAddress),
                          _buildPasswordField("Password *", passwordController, passwordVisible, () => setState(() => passwordVisible = !passwordVisible)),
                          _buildPasswordField("Confirm Password *", confirmPasswordController, confirmPasswordVisible, () => setState(() => confirmPasswordVisible = !confirmPasswordVisible), isConfirm: true),
                          _buildTerms(greenColor),
                          const SizedBox(height: 25),
                          _buildSubmitButton(greenColor),
                        ],
                      ),
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

  // --- Helper Widgets ---
  Widget _buildRoleToggle(Color greenColor) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          _toggleBtn("Customer", Icons.person, isCustomer, () => setState(() => isCustomer = true), greenColor),
          _toggleBtn("Admin", Icons.admin_panel_settings, !isCustomer, () => setState(() => isCustomer = false), greenColor),
        ],
      ),
    );
  }

  Widget _toggleBtn(String label, IconData icon, bool active, VoidCallback onTap, Color greenColor) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(color: active ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10), boxShadow: active ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : []),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: active ? greenColor : Colors.grey), const SizedBox(width: 8), Text(label, style: TextStyle(color: active ? greenColor : Colors.grey, fontWeight: FontWeight.bold))]),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {TextInputType keyboard = TextInputType.text}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 5),
      TextFormField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(prefixIcon: Icon(icon), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        validator: (v) => v!.isEmpty ? "Required" : null,
      ),
      const SizedBox(height: 15),
    ]);
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool visible, VoidCallback onToggle, {bool isConfirm = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 5),
      TextFormField(
        controller: controller,
        obscureText: !visible,
        decoration: InputDecoration(prefixIcon: const Icon(Icons.lock_outline), suffixIcon: IconButton(icon: Icon(visible ? Icons.visibility : Icons.visibility_off), onPressed: onToggle), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        validator: (v) {
          if (v!.isEmpty) return "Required";
          if (!isConfirm && v.length < 6) return "Min 6 characters";
          if (isConfirm && v != passwordController.text) return "Passwords match error";
          return null;
        },
      ),
      const SizedBox(height: 15),
    ]);
  }

  Widget _buildTerms(Color greenColor) {
    return Row(children: [
      Checkbox(value: isTermsAccepted, onChanged: (v) => setState(() => isTermsAccepted = v!), activeColor: greenColor),
      const Expanded(child: Text("I agree to the Terms & Conditions", style: TextStyle(fontSize: 12))),
    ]);
  }

  Widget _buildSubmitButton(Color greenColor) {
    return SizedBox(
      width: double.infinity, height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : _handleSignUp,
        style: ElevatedButton.styleFrom(backgroundColor: greenColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}