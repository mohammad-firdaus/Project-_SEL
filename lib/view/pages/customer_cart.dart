import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Product {
  final String name;
  final String description;
  final String price;

  Product({required this.name, required this.description, required this.price});
}

class CustomerCart extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: 'Luggage Bag Tag',
      description:
          'Eco-friendly travel essentials made from upcycled fabric, combining style, function, and sustainability. Handcrafted, durable, and unique.',
      price: 'RM7 (Buy 5 for RM30)',
    ),
    Product(
      name: 'Keychain Wrist Strap',
      description:
          'Lightweight and comfy for carrying keys or pouches hands-free during errands or travel.',
      price: 'RM3 (Buy 5 for RM12.50)',
    ),
    Product(
      name: 'Scrunchies (Basic)',
      description:
          'Soft, upcycled fabric scrunchies gentle on hair, reduce breakage, perfect for everyday wear.',
      price: 'RM3 (Buy 5 for RM12.50)',
    ),
    Product(
      name: 'Tote Bag',
      description:
          'Spacious, sturdy eco-friendly tote bag for everyday use and travel, made from recycled fabric.',
      price: 'RM15 (Buy 5 for RM35)',
    ),
    Product(
      name: 'Medium String Bag',
      description:
          'Perfect for essentials when exploring, made from recycled materials, compact and durable.',
      price: 'RM8 (Buy 5 for RM40)',
    ),
    Product(
      name: 'Premium Knot Bag',
      description:
          'Stylish upcycled jeans bag with unique knot-handle design, perfect for casual or formal use.',
      price: 'RM25-RM35',
    ),
  ];

  // Facebook URL from user request (adjust as necessary)
  final String facebookUrl = 'https://www.youtube.com';

  void _launchFacebook() async {
    final Uri url = Uri.parse(facebookUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Handle cannot launch scenario if needed
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 16.0, // Spacing between columns
                mainAxisSpacing: 16.0, // Spacing between rows
                childAspectRatio: 0.75, // Aspect ratio for each grid item (adjust as needed for content)
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            product.description,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4, // Limit lines to fit in grid
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Price: ${product.price}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: _launchFacebook,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Follow us on Facebook',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}