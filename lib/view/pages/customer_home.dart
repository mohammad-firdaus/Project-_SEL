import 'package:flutter/material.dart';

class CustomerHome extends StatelessWidget {
  const CustomerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

          // Featured Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Featured',
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
          ),
        ],
      ),
    );
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
  }
}
