import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  final String instagramHandle = '@wastetowealth';
  final String tiktokHandle = '@wastetowealth.my';
  final String phoneNumber = '+60 12-345-6789';
  final String emailAddress = 'hello@wastetowealth.my';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar with back icon and green background as per image
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Contact Us'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            padding: EdgeInsets.only(top: 24, bottom: 36),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 36,
                child: Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // Rounded top corners white container covering rest
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header text
                    Center(
                      child: Text(
                        'Get in Touch',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Connect with us on social media or reach out directly.',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 32),

                    // Social Media Section
                    Text(
                      'Social Media',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(height: 16),

                    // Instagram row
                    _socialMediaRow(
                      imagePath: 'assets/images/instagram.jpg',
                      label: instagramHandle,
                      onTap: () {
                        // TODO: Open Instagram profile link
                      },
                    ),

                    SizedBox(height: 24),

                    // TikTok row
                    _socialMediaRow(
                      imagePath: 'assets/images/tiktok.png',
                      label: tiktokHandle,
                      onTap: () {
                        // TODO: Open TikTok profile link
                      },
                    ),

                    SizedBox(height: 40),

                    // Direct Contact Section
                    Text(
                      'Direct Contact',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),

                    SizedBox(height: 16),

                    // Phone row
                    _contactRow(
                      icon: Icons.phone_outlined,
                      contactText: phoneNumber,
                      onTap: () {
                        // TODO: Launch phone dialer
                      },
                    ),

                    SizedBox(height: 16),

                    // Email row
                    _contactRow(
                      icon: Icons.email_outlined,
                      contactText: emailAddress,
                      onTap: () {
                        // TODO: Launch email client
                      },
                    ),

                    SizedBox(height: 40),

                    // Business hours info box
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Text(
                            'Business Hours',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Monday - Friday, 8:00 AM - 6:00 PM (GMT+8)',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'We typically respond within 24 hours',
                            style:
                                TextStyle(fontSize: 12, color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialMediaRow({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                imagePath,
                height: 36,
                width: 36,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            Icon(
              Icons.open_in_new,
              color: Colors.grey[600],
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactRow({
    required IconData icon,
    required String contactText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                contactText,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Icon(Icons.open_in_new, size: 18, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}