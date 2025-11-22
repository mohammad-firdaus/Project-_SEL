import 'package:flutter/material.dart';

class WasteToWealthInfoPage extends StatelessWidget {
  final Color greenColor = const Color(0xFF42B642);

  const WasteToWealthInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: greenColor,
        title: Text('About Us', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Green Header with icon and title
              Row(
                children: [
                  Icon(Icons.eco, size: 32, color: greenColor),
                  SizedBox(width: 8),
                  Text(
                    'WasteToWealth',
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Mission',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'WasteToWealth is on a mission to revolutionize recycling and sustainability in Malaysia. We believe that every piece of waste has value, and through innovative technology and community engagement, we are creating a circular economy where environmental responsibility means financial rewards.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              Text(
                'What We Do',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 12),

              _infoItem(
                icon: Icons.recycling_outlined,
                title: 'Rewarding Recycling',
                description:
                    'Earn your recyclables into valuable green points. The more you recycle, the more you earn!',
                iconColor: greenColor,
              ),

              _infoItem(
                icon: Icons.storefront_outlined,
                title: 'Eco-Friendly Marketplace',
                description:
                    'Shop sustainable products made from recycled materials. Use your points to get discounts on eco-friendly items.',
                iconColor: greenColor,
              ),

              _infoItem(
                icon: Icons.group_outlined,
                title: 'Community Building',
                description:
                    'Join local cleanup events, share sustainability tips, and interact with like-minded eco-warriors in your area.',
                iconColor: greenColor,
              ),

              _infoItem(
                icon: Icons.school_outlined,
                title: 'Education & Awareness',
                description:
                    'Learn about recycling best practices, environmental impact, and how small actions create big changes.',
                iconColor: greenColor,
              ),

              SizedBox(height: 28),

              Text(
                'Our Core Values',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 16),

              _coreValueItem(
                number: '1',
                title: 'Sustainability First',
                description:
                    'Every decision we make prioritizes the health of our planet and future generations.',
                greenColor: greenColor,
              ),
              _coreValueItem(
                number: '2',
                title: 'Community Empowerment',
                description:
                    'We believe in the power of collective action to drive meaningful environmental change.',
                greenColor: greenColor,
              ),
              _coreValueItem(
                number: '3',
                title: 'Innovation & Technology',
                description:
                    'Using cutting-edge solutions to make recycling accessible, rewarding, and fun for everyone.',
                greenColor: greenColor,
              ),
              _coreValueItem(
                number: '4',
                title: 'Transparency & Trust',
                description:
                    'Open communication about our processes, impact, and how your support drives real results.',
                greenColor: greenColor,
              ),

              SizedBox(height: 28),

              Text(
                'Our Impact So Far',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _impactItem(
                    number: '250k+',
                    label: 'Bins Recycled',
                    icon: Icons.delete_sweep_outlined,
                    greenColor: greenColor,
                  ),
                  _impactItem(
                    number: '15k+',
                    label: 'Active Members',
                    icon: Icons.people_outline,
                    greenColor: greenColor,
                  ),
                ],
              ),

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _impactItem(
                    number: '180T',
                    label: 'CO2 Saved',
                    icon: Icons.cloud_outlined,
                    greenColor: greenColor,
                  ),
                  _impactItem(
                    number: '500+',
                    label: 'Community Events',
                    icon: Icons.event_outlined,
                    greenColor: greenColor,
                  ),
                ],
              ),

              SizedBox(height: 28),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A Vision for 2030',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'By 2030, we envision a Malaysia where recycling is second nature, waste is responsibly managed, and every citizen actively participates in building a sustainable future.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    _visionBullet('100,000+ active recyclers'),
                    _visionBullet(
                      '1 million tons of waste diverted from landfills',
                    ),
                    _visionBullet('Zero-waste communities across Malaysia'),
                    _visionBullet(
                      'Partnerships with 10,000+ eco-friendly brands',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28),

              Center(
                child: Column(
                  children: [
                    Text(
                      'Join Our Green Movement',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: greenColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Together, we can create a cleaner, greener Malaysia. Every action counts, and every person makes a difference.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Let’s transform waste into wealth, together! 🌍',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: greenColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              Center(
                child: Text(
                  'Get in Touch',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),

              SizedBox(height: 12),

              _contactRow(Icons.email_outlined, 'contact@wastetowealth.my'),
              _contactRow(Icons.phone_outlined, '+603-9123-4567'),
              _contactRow(
                Icons.location_on_outlined,
                '123 Eco St, Kuala Lumpur',
              ),

              SizedBox(height: 24),

              Center(
                child: Text(
                  '© 2025 WasteToWealth. Making Malaysia Sustainable.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String title,
    required String description,
    required Color iconColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: iconColor),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _coreValueItem({
    required String number,
    required String title,
    required String description,
    required Color greenColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: greenColor,
              shape: BoxShape.circle,
            ),
            width: 32,
            height: 32,
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(description, style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _impactItem({
    required String number,
    required String label,
    required IconData icon,
    required Color greenColor,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: greenColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 36, color: greenColor),
        ),
        SizedBox(height: 10),
        Text(
          number,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          width: 90,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _visionBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: greenColor),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
