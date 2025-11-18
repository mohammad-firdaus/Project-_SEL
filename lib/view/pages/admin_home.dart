import 'package:flutter/material.dart';
import 'package:project_sel/view/pages/admin_featured_content_edit_page.dart';
import 'package:project_sel/view/pages/admin_upcoming_event_manage_page.dart';

class AdminHome extends StatelessWidget {
  final Color primaryGreen = Color(0xFF42B642);

  AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1, // Adjustable height
          color: primaryGreen,
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Platform Impact section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Platform Impact',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _buildSummaryCard(
                            'Total Users',
                            '15,234',
                            primaryGreen,
                            Icons.people,
                          ),
                          _buildSummaryCard(
                            'Rec. Active',
                            '8,567',
                            Colors.orange,
                            Icons.check_circle_outline,
                          ),
                          _buildSummaryCard(
                            'Events Attended',
                            '2,457',
                            Colors.blueAccent,
                            Icons.event_available,
                          ),
                          _buildSummaryCard(
                            'Points Earned',
                            '523K',
                            Colors.purple,
                            Icons.monetization_on_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Featured Content section with header and toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Content',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.green, size: 14),
                      SizedBox(width: 4),
                      Text('Live', style: TextStyle(color: primaryGreen)),
                      SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ManageFeaturedAdsPage();
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.edit, size: 16, color: Colors.white),
                        label: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Featured cards in staggered layout: first row 1 large, second row 2 small
              SizedBox(
                height: 380,
                child: Column(
                  children: [
                    // First row: one large card
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildFeaturedCard(
                              title: 'Join the Green Revolution',
                              subtitle:
                                  'Inspire change with our new initiatives today!',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb?fit=crop&w=800&q=60',
                              greenDot: true,
                              badgeText: 'New Campaign',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    // Second row: two smaller cards
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildFeaturedCard(
                              title: 'Recycle More',
                              subtitle:
                                  'Learn innovative ways to reduce waste.',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1542831371-29b0f74f9713?fit=crop&w=800&q=60',
                              greenDot: false,
                              titleFontSize: 14,
                              subtitleFontSize: 12,
                            ),
                          ),
                          Expanded(
                            child: _buildFeaturedCard(
                              title: 'Green Living Tips',
                              subtitle:
                                  'Discover daily habits for a sustainable life.',
                              imageUrl:
                                  'https://images.unsplash.com/photo-1518837695005-2083093ee35b?fit=crop&w=800&q=60',
                              greenDot: false,
                              titleFontSize: 14,
                              subtitleFontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

              // Upcoming Events header with Change button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Events',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle filter change
                    },
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UpcomingEventManagePage();
                            },
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, size: 16, color: Colors.white),
                      label: Text(
                        'Manage',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Upcoming events list
              _buildEventItem(
                icon: Icons.beach_access_outlined,
                title: 'Beach Cleanup Drive',
                date: 'Nov 12, 2023',
                location: 'Batu Pahat City, Langkawi',
                participants: 25,
              ),
              _buildEventItem(
                icon: Icons.recycling_outlined,
                title: 'Recycling Workshop',
                date: 'Nov 20, 2023',
                location: 'Kuala Lumpur',
                participants: 50,
              ),
              _buildEventItem(
                icon: Icons.local_florist_outlined,
                title: 'Green Market Festival',
                date: 'Dec 15, 2023',
                location: 'Penang',
                participants: 85,
              ),

              SizedBox(height: 25),

              // Today's Summary card
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFF66BB6A) // Brighter green for dark mode
                      : primaryGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    _buildSummaryRowWhite('New Users', '+28'),
                    _buildSummaryRowWhite('Orders Completed', '+17'),
                    _buildSummaryRowWhite('Event Participation', '+11'),
                    Divider(height: 30, thickness: 1, color: Colors.white),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Rewards',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'RM 1,460',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 60), // Extra spacing if needed for bottom navbar
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        // ignore: deprecated_member_use
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: color),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard({
    required String title,
    required String subtitle,
    required String imageUrl,
    bool greenDot = false,
    String? badgeText,
    double titleFontSize = 18,
    double subtitleFontSize = 14,
  }) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            // ignore: deprecated_member_use
            Colors.black.withOpacity(0.35),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          if (badgeText != null)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (greenDot)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: titleFontSize,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: subtitleFontSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem({
    required IconData icon,
    required String title,
    required String date,
    required String location,
    required int participants,
  }) {
    String formatDate(String dateStr) {
      List<String> parts = dateStr.split(' ');
      String month = parts[0];
      String day = parts[1].replaceAll(',', '');
      String year = parts[2];
      return '$month $day, $year';
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  formatDate(date),
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                Spacer(),
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 12),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.people, size: 20, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  '$participants going',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Active',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRowWhite(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
