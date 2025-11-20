import 'package:flutter/material.dart';

class CustomerHome extends StatelessWidget {
  const CustomerHome({Key? key}) : super(key: key);

  Widget _buildFeaturedCard(String imageUrl, String title, String subtitle,
      {bool isNewCampaign = false, bool isSponsored = false}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imageUrl,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        if (isNewCampaign)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.shade700.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'New Campaign',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        if (isSponsored)
          Positioned(
            top: 12,
            right: 12,
            child: const Text(
              'Sponsored',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        Positioned(
          bottom: 12,
          left: 12,
          right: 12,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEventCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade700,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                'Beach Cleanup Day',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '27 spots left',
                  style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Saturday, Nov 2, 2025 - 10:00 AM',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          const Text(
            'Join us for a community beach cleanup and earn double points!',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green, backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Register Now'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerReview({
    required String name,
    required String date,
    required String review,
    required double rating,
    bool showButton = false,
    String? buttonText,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                const SizedBox(width: 8),
                Text(date,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    )),
                const Spacer(),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.green,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
            ),
            if (showButton && buttonText != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    buttonText,
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
<<<<<<< HEAD
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.eco, color: Colors.green, size: 28),
                  const SizedBox(width: 8),
                  const Text(
                    'WasteToWealth',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {},
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/300'), // placeholder avatar
                    radius: 16,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Welcome Text
          const Text(
            'Welcome back!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          const Text(
            "Let's Save the Planet Together",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 32),
=======
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome & Subtitle
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Welcome back!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=9',
                ),
              )
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            'Let\'s Save the Planet Together',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 24),
>>>>>>> 6f00fc411f4147c759564408bbf4509cdac81465

          // Featured Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Featured',
<<<<<<< HEAD
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Sponsored',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Featured Card (Join the Green Revolution)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60',
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: const Text('New Campaign',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Positioned(
                  left: 16,
                  bottom: 40,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'GO GREEN',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Join the Green Revolution',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Small changes, big impact. Start your eco journey today!',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Two smaller cards horizontally
          Row(
            children: [
              Expanded(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1542838687-a35d06f1e3e3?auto=format&fit=crop&w=600&q=60',
                        height: 110,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Recycle More',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Earn ecoPoints!',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1503602642458-232111445657?auto=format&fit=crop&w=600&q=60',
                        height: 110,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'New Arrivals',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Sustainable products',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Upcoming Events Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green[100],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Beach Cleanup Day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Saturday, Nov 2, 2025 • 9:00 AM',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Join us for a community beach cleanup and earn double points!',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: const Text(
                        '25 spots left',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)), backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    minimumSize: const Size.fromHeight(45),
                  ),
                  child: const Text(
                    'Register Now',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Customer Reviews Header
          Row(
            children: const [
              Text(
                'Customer Reviews',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.star, color: Colors.green, size: 20),
              Text(
                '4.8/5.0',
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          const SizedBox(height: 16),

          // Review Cards
          _ReviewCard(
            name: 'Sarah Chen',
            date: 'Nov 18, 2025',
            review:
                'Amazing eco-friendly products! The quality exceeded my expectations and delivery was super fast. Love supporting sustainable brands!',
            productTag: 'Recycled Glass Bottle Set',
          ),
          _ReviewCard(
            name: 'Michael Torres',
            date: 'Nov 17, 2025',
            review:
                'Best decision ever! These products are not only good for the environment but also incredibly well-made. Highly recommend!',
            productTag: 'Eco Metal Lunch Box',
          ),
          _ReviewCard(
            name: 'Emma Wilson',
            date: 'Nov 16, 2025',
            review:
                'The packaging was thoughtful and the products arrived in perfect condition. So happy to contribute to a greener planet!',
            productTag: 'Bamboo Paper Notebooks',
          ),
          _ReviewCard(
            name: 'Lisa Anderson',
            date: 'Nov 14, 2025',
            review:
                'Absolutely love it! The customer service was exceptional and the products are top-notch. Making a positive impact feels so good!',
            productTag: 'Glass Water Bottle',
=======
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                'Sponsored',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Featured cards
          Column(
            children: [
              _buildFeaturedCard(
                'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60',
                'Join the Green Revolution',
                'Small changes, big impact. Start your eco journey today.',
                isNewCampaign: true,
                isSponsored: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildFeaturedCard(
                      'https://images.unsplash.com/photo-1523413651479-597eb2da0ad6?auto=format&fit=crop&w=600&q=60',
                      'Recycle More',
                      'Earn double points',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildFeaturedCard(
                      'https://images.unsplash.com/photo-1556740738-b6a63e27c4df?auto=format&fit=crop&w=600&q=60',
                      'New Arrivals',
                      'Sustainable products',
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Upcoming Events Section
          const Text(
            'Upcoming Events',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          _buildUpcomingEventCard(),

          const SizedBox(height: 28),

          // Customer Reviews Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Customer Reviews',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.green, size: 18),
                  SizedBox(width: 4),
                  Text(
                    '4.8/5.0',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 10),

          // Review Cards
          _buildCustomerReview(
            name: 'Sarah Chen',
            date: 'Nov 18, 2023',
            rating: 5,
            review:
                'Amazing eco-friendly products! The quality exceeded my expectations and delivery was super fast. Love supporting sustainable brands!',
            showButton: true,
            buttonText: 'Product Care Guide Set',
          ),
          _buildCustomerReview(
            name: 'Michael Tomas',
            date: 'Nov 17, 2023',
            rating: 5,
            review:
                'Best decision ever! These products are not only good for the environment but also incredibly mid-mass. Highly recommend!',
          ),
          _buildCustomerReview(
            name: 'Emma Wilson',
            date: 'Nov 16, 2023',
            rating: 5,
            review:
                'The packaging was thoughtful and the products arrived in perfect condition. So happy to contribute to a greener planet!',
            showButton: true,
            buttonText: 'Premium Paper Notebook',
          ),
          _buildCustomerReview(
            name: 'Lisa Anderson',
            date: 'Nov 14, 2023',
            rating: 5,
            review:
                'Absolutely love it! The customer service was exceptional and the products are top-notch. Making a positive impact feels so good!',
            showButton: true,
            buttonText: 'Glass Water Bottle',
>>>>>>> 6f00fc411f4147c759564408bbf4509cdac81465
          ),
        ],
      ),
    );
<<<<<<< HEAD
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String date;
  final String review;
  final String productTag;

  const _ReviewCard({
    required this.name,
    required this.date,
    required this.review,
    required this.productTag,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and stars
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star,
                        color: Colors.green,
                        size: 16,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 12),
              Text(
                review,
                style: const TextStyle(fontSize: 14, height: 1.3),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  productTag,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              )
            ],
          ),
        ),
      ),
    );
=======
>>>>>>> 6f00fc411f4147c759564408bbf4509cdac81465
  }
}