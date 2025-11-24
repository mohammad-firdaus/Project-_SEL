// import 'package:flutter/material.dart';

// class CustomerShop extends StatefulWidget {
//   @override
//   _CustomerShopState createState() => _CustomerShopState();
// }

// class _CustomerShopState extends State<CustomerShop> {
//   final Color primaryGreen = const Color(0xFF42B642);
//   String _selectedFilter = 'All Collection';
//   String _selectedCategory = 'Basic';
  
//   final List<String> _filters = [
//     'All Collection',
//     'Hot Selling',
//     'Basic',
//     'Standard',
//     'Premium',
//     'Corporate',
//     'Urban Compost'
//   ];

//   final Map<String, List<String>> _productTypes = {
//     'Basic': ['Scrunchies', 'Keychain', 'Luggage Bag Tag'],
//     'Standard': ['Medium String Bag', 'Large String Bag', 'Tote Bag'],
//     'Premium': ['Knot Bag', 'Batwing Outwear'],
//     'Corporate': ['Ecotote', 'Lanyard'],
//     'Urban Compost': ['Eco-kit Bokashi', 'Ecobran'],
//   };

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Search Bar
//           Container(
//             margin: EdgeInsets.only(bottom: 16),
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Color(0xFFE0F7FA), // Light turquoise
//               borderRadius: BorderRadius.circular(25),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 8,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.search, color: Colors.grey[600]),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search products...',
//                       hintStyle: TextStyle(color: Colors.grey[600]),
//                       border: InputBorder.none,
//                       isDense: true,
//                     ),
//                     style: TextStyle(color: Colors.grey[800]),
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           // Advertisement Box
//           Container(
//             width: double.infinity,
//             height: 120,
//             margin: EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFF4DB6AC), primaryGreen],
//               ),
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 6,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   left: 16,
//                   top: 16,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Special Offer',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Get 20% off on all\npremium products',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   right: 16,
//                   bottom: 16,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       'Shop Now',
//                       style: TextStyle(
//                         color: Color(0xFF00796B),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           // Filter Chips
//           Container(
//             height: 50,
//             margin: EdgeInsets.only(bottom: 16),
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: _filters.map((filter) {
//                 return Padding(
//                   padding: EdgeInsets.only(right: 8),
//                   child: FilterChip(
//                     label: Text(filter),
//                     selected: _selectedFilter == filter,
//                     onSelected: (bool selected) {
//                       setState(() {
//                         _selectedFilter = filter;
//                         if (filter != 'All Collection' && filter != 'Hot Selling') {
//                           _selectedCategory = filter;
//                         }
//                       });
//                     },
//                     selectedColor: primaryGreen,
//                     checkmarkColor: Colors.white,
//                     labelStyle: TextStyle(
//                       color: _selectedFilter == filter ? Colors.white : Colors.grey[700],
//                     ),
//                     backgroundColor: Colors.grey[200],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
          
//           // Products Section
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Left Expanded - Product Types
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[50],
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: _buildProductTypesList(),
//                   ),
//                 ),
//               ),
              
//               SizedBox(width: 16),
              
//               // Right Expanded - Product Cards
//               Expanded(
//                 flex: 2,
//                 child: _buildProductCards(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
  
//   List<Widget> _buildProductTypesList() {
//     List<String> types = [];
    
//     if (_selectedFilter == 'All Collection' || _selectedFilter == 'Hot Selling') {
//       // Show all product types from all categories
//       _productTypes.forEach((category, typeList) {
//         types.addAll(typeList);
//       });
//     } else {
//       types = _productTypes[_selectedCategory] ?? [];
//     }
    
//     return types.map((type) {
//       return Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
//         ),
//         child: Text(
//           type,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[700],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       );
//     }).toList();
//   }
  
//   Widget _buildProductCards() {
//     // Sample product data - in real app, this would come from your data source
//     List<Map<String, dynamic>> products = [
//       {
//         'name': 'Eco Scrunchies',
//         'price': '\$12.99',
//         'category': 'Basic',
//         'type': 'Scrunchies',
//         'image': 'assets/scrunchies.jpg',
//       },
//       {
//         'name': 'Recycled Keychain',
//         'price': '\$8.99',
//         'category': 'Basic',
//         'type': 'Keychain',
//         'image': 'assets/keychain.jpg',
//       },
//       {
//         'name': 'Medium String Bag',
//         'price': '\$24.99',
//         'category': 'Standard',
//         'type': 'Medium String Bag',
//         'image': 'assets/string_bag.jpg',
//       },
//       {
//         'name': 'Premium Knot Bag',
//         'price': '\$45.99',
//         'category': 'Premium',
//         'type': 'Knot Bag',
//         'image': 'assets/knot_bag.jpg',
//       },
//     ];
    
//     // Filter products based on selected filter
//     List<Map<String, dynamic>> filteredProducts = products.where((product) {
//       if (_selectedFilter == 'All Collection') return true;
//       if (_selectedFilter == 'Hot Selling') return true; // Add hot selling logic
//       return product['category'] == _selectedFilter;
//     }).toList();
    
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: filteredProducts.length,
//       itemBuilder: (context, index) {
//         final product = filteredProducts[index];
//         return Container(
//           margin: EdgeInsets.only(bottom: 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               // Product Image
//               Container(
//                 width: 80,
//                 height: 80,
//                 margin: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(Icons.shopping_bag, color: Colors.grey[400]),
//               ),
              
//               // Product Details
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         product['name'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         product['type'],
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         product['price'],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: primaryGreen,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
              
//               // Add to Cart Button
//               Padding(
//                 padding: EdgeInsets.all(12),
//                 child: IconButton(
//                   icon: Icon(Icons.add_shopping_cart),
//                   color: primaryGreen,
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }