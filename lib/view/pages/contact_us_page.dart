import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  final String instagramHandle = '@ecofab_wastetowealth';
  final String tiktokHandle = '@ecofab_wastetowea';
  final String phoneNumber = '+60 13-512 7709';
  final String emailAddress = 'wastetowealth.ecofab@gmail.com';

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
                          color: Colors.black,
                        ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Instagram row
                    _socialMediaRow(
                      imagePath: 'assets/images/instagram.jpg',
                      label: instagramHandle,
                      onTap: () async {
                        final url = Uri.parse(
                          'https://www.instagram.com/ecofab_wastetowealth?igsh=bXRud3RIMzlyMng1',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                    ),

                    SizedBox(height: 24),

                    // TikTok row
                    _socialMediaRow(
                      imagePath: 'assets/images/tiktok.png',
                      label: tiktokHandle,
                      onTap: () async {
                        final url = Uri.parse(
                          'https://www.tiktok.com/@ecofab_wastetowea?_r=1&_t=ZS-91ssZhXX5pw',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                    ),

                    SizedBox(height: 40),

                    // Direct Contact Section
                    Text(
                      'Direct Contact',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(height: 16),

                    // Phone row
                    _contactRow(
                      icon: Icons.phone_outlined,
                      contactText: phoneNumber,
                      onTap: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path:
                              '0135127709', // Replace with the desired phone number
                        );
                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          // Handle the case where the URL cannot be launched (e.g., show a SnackBar)
                          print('Could not launch $launchUri');
                        }
                      },
                    ),

                    SizedBox(height: 16),

                    // Email row
                    _contactRow(
                      icon: Icons.email_outlined,
                      contactText: emailAddress,
                      onTap: () async {
                        // The recipient email address
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path:
                              'wastetowealth.ecofab@gmail.com', // The email address you want to send to
                          query: _encodeQueryParameters(<String, String>{
                            'subject':
                                'Example Subject', // Optional: pre-filled subject
                            'body':
                                'Example body content', // Optional: pre-filled body
                          }),
                        );

                        if (await canLaunchUrl(emailLaunchUri)) {
                          await launchUrl(emailLaunchUri);
                        } else {
                          // Handle the case where no email app is installed
                          // You could show a dialog or a snackbar
                          throw 'Could not launch $emailLaunchUri';
                        }
                      },
                    ),

                    SizedBox(height: 40),

                    // Business hours info box
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.green.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
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
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'We typically respond within 24 hours',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
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

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
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
            Icon(Icons.open_in_new, color: Colors.grey[600], size: 22),
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
            Expanded(child: Text(contactText, style: TextStyle(fontSize: 15))),
            Icon(Icons.open_in_new, size: 18, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
