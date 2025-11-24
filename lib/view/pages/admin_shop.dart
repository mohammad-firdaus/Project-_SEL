import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_sel/view/pages/admin_shop_record_manual_sales_page.dart';

class AdminShop extends StatefulWidget {
  const AdminShop({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminShopState createState() => _AdminShopState();
}

class _AdminShopState extends State<AdminShop> {
  String dropdownValue = 'All Collections';
  final List<String> categories = [
    'All Collections',
    'Basic',
    'Standard',
    'Premium',
    'Corporate',
    'Urban Compost',
  ];
  final TextEditingController _searchController = TextEditingController();

  final List<Product> products = [
    Product(
      name: 'Recycled Plastic Bottle',
      price: 2.50,
      readyStock: 145,
      onSale: 50,
      sold: 95,
      imagePath: 'assets/images/plastic_bottle.png',
      category: 'Urban Compost',
      lastUpdated: DateTime.now().subtract(Duration(hours: 2)),
    ),
    Product(
      name: 'Glass Container Set',
      price: 15.00,
      readyStock: 0,
      onSale: 0,
      sold: 6,
      imagePath: 'assets/images/glass_container.jpg',
      category: 'Corporate',
      lastUpdated: DateTime.now().subtract(Duration(days: 1)),
    ),
    Product(
      name: 'Paper Shopping Bag',
      price: 3.50,
      readyStock: 97,
      onSale: 0,
      sold: 86,
      imagePath: 'assets/images/paper_bag.jpg',
      category: 'Basic',
      lastUpdated: DateTime.now().subtract(Duration(minutes: 30)),
    ),
    Product(
      name: 'Metal Water Bottle',
      price: 18.00,
      readyStock: 66,
      onSale: 0,
      sold: 58,
      imagePath: 'assets/images/metal_bottle.jpg',
      category: 'Premium',
      lastUpdated: DateTime.now().subtract(Duration(hours: 5)),
    ),
    Product(
      name: 'Recycled Tote Bag',
      price: 8.50,
      readyStock: 0,
      onSale: 0,
      sold: 0,
      imagePath: 'assets/images/tote_bag.jpg',
      category: 'Standard',
      lastUpdated: DateTime.now().subtract(Duration(days: 3)),
    ),
    Product(
      name: 'Eco Notebook',
      price: 6.00,
      readyStock: 88,
      onSale: 0,
      sold: 2,
      imagePath: 'assets/images/eco_notebook.jpg',
      category: 'Basic',
      lastUpdated: DateTime.now().subtract(Duration(hours: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF42B642);
    List<Product> filteredProducts = dropdownValue == 'All Collections'
        ? products
        : products.where((p) => p.category == dropdownValue).toList();

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          color: primaryGreen,
        ),
        Column(
          children: [
            // Fixed header section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading section
                  Row(
                    children: const [
                      Icon(Icons.shopify, color: Colors.white, size: 35),
                      SizedBox(width: 5),
                      Text(
                        'Shop Overview',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Manage products and inventory',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Summary Cards in 2x2 Grid in a Box Container
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2,
                          children: [
                            _summaryCard(
                              'Ready Stock',
                              '989',
                              Icons.inventory_2_rounded,
                              Colors.teal,
                            ),
                            _summaryCard(
                              'On Sale',
                              '375',
                              Icons.sell_outlined,
                              Colors.orange,
                            ),
                            _summaryCard(
                              'Total Sold',
                              '1461',
                              Icons.shopping_cart_outlined,
                              Colors.blue,
                            ),
                            _summaryCard(
                              'Products',
                              '6',
                              Icons.category_outlined,
                              Colors.purple,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),

                      // Search Bar
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                        ),
                        onChanged: (value) {
                          setState(
                            () {},
                          ); // To refresh filtered products if want live search
                        },
                      ),
                      SizedBox(height: 12),

                      // Category Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            items: categories
                                .map(
                                  (cat) => DropdownMenuItem<String>(
                                    value: cat,
                                    child: Text(cat),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12),

                      // Showing product count and button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Showing ${filteredProducts.length} products',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ManualSalesEntryPage();
                                  },
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.note_add_outlined,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Record Manual Sales',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.325,
                            ),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return _productCard(product);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _summaryCard(String title, String count, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 16,
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey[700])),
                SizedBox(height: 4),
                Text(
                  count,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(Product product) {
    int totalInventory = product.readyStock + product.onSale + product.sold;
    String status = _getStockStatus(product);
    Color statusColor = _getStatusColor(status);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: statusColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        // ignore: deprecated_member_use
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Status Badge
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Product Image
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(product.imagePath, fit: BoxFit.cover),
            ),
          ),

          const SizedBox(height: 12),

          // Product Name
          Text(
            product.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 6),

          // Category and Price Column
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category, size: 14, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    product.category,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'RM ${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 5),

          // Total Inventory
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inventory_2, size: 16, color: Colors.blue[700]),
                SizedBox(width: 6),
                Text(
                  'Total: $totalInventory',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 2),

          // Stock Details
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _enhancedStockRow(
                  'Ready Stock',
                  product.readyStock.toString(),
                  Colors.green,
                ),
                Divider(height: 8, thickness: 0.5),
                _enhancedStockRow(
                  'On Sale',
                  product.onSale.toString(),
                  Colors.orange,
                ),
                Divider(height: 8, thickness: 0.5),
                _enhancedStockRow('Sold', product.sold.toString(), Colors.blue),
              ],
            ),
          ),

          const SizedBox(height: 2),

          // Last Updated
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  'Updated ${_formatLastUpdated(product.lastUpdated)}',
                  style: TextStyle(color: Colors.grey[500], fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Action Buttons
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: product.readyStock > 0
                      ? () => _showInventoryDialog(product, true)
                      : null,
                  icon: const Icon(
                    Icons.sell_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                  label: const Text(
                    'Put On Sale',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: product.readyStock > 0
                        ? Colors.green[700]
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: product.onSale > 0
                      ? () => _showInventoryDialog(product, false)
                      : null,
                  icon: Icon(
                    Icons.undo,
                    color: product.onSale > 0 ? Colors.blue[700] : Colors.grey,
                    size: 16,
                  ),
                  label: Text(
                    'Move to Ready Stock',
                    style: TextStyle(
                      color: product.onSale > 0
                          ? Colors.blue[700]
                          : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: product.onSale > 0
                          ? Colors.blue[300]!
                          : Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _enhancedStockRow(String label, String count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(_getStockIcon(label), size: 14, color: color),
              SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            count,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStockIcon(String label) {
    switch (label) {
      case 'Ready Stock':
        return Icons.inventory_2;
      case 'On Sale':
        return Icons.sell;
      case 'Sold':
        return Icons.shopping_cart;
      default:
        return Icons.help;
    }
  }

  String _getStockStatus(Product product) {
    if (product.readyStock == 0 && product.onSale == 0) {
      return 'Out of Stock';
    } else if (product.readyStock < 10 && product.readyStock > 0) {
      return 'Low Stock';
    } else if (product.onSale > 0) {
      return 'On Sale';
    } else {
      return 'In Stock';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Out of Stock':
        return Colors.red;
      case 'Low Stock':
        return Colors.orange;
      case 'On Sale':
        return Colors.blue;
      case 'In Stock':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatLastUpdated(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _showInventoryDialog(Product product, bool toSale) {
    int maxQuantity = toSale ? product.readyStock : product.onSale;
    final TextEditingController qtyController = TextEditingController(
      text: '0',
    );
    int selectedQty = 0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            void updateQuantity(int val) {
              if (val < 0) val = 0;
              if (val > maxQuantity) val = maxQuantity;
              setStateDialog(() {
                selectedQty = val;
                qtyController.text = selectedQty.toString();
                qtyController.selection = TextSelection.fromPosition(
                  TextPosition(offset: qtyController.text.length),
                );
              });
            }

            Widget quickButton(String label, double percent) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: toSale
                          ? Colors.green[50]
                          : Colors.blue[50],
                      foregroundColor: toSale
                          ? Colors.green[700]
                          : Colors.blue[700],
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      int newQty = (maxQuantity * percent).round();
                      updateQuantity(newQty);
                    },
                    child: Text(label),
                  ),
                ),
              );
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              titlePadding: EdgeInsets.zero,
              title: Container(
                decoration: BoxDecoration(
                  color: toSale ? Colors.green[700] : Colors.blue[700],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Icon(
                      toSale ? Icons.sell_outlined : Icons.undo,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      toSale ? 'Put on Sale' : 'Move to Ready Stock',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product info row
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade100,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                product.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  product.category,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'RM ${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Stock boxes
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: toSale
                                    ? Colors.green[50]
                                    : Colors.blue[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    toSale ? 'Ready Stock' : 'On Sale',
                                    style: TextStyle(
                                      color: toSale
                                          ? Colors.green[700]
                                          : Colors.blue[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    maxQuantity.toString(),
                                    style: TextStyle(
                                      color: toSale
                                          ? Colors.green[900]
                                          : Colors.blue[900],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: toSale
                                    ? Colors.blue[50]
                                    : Colors.green[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    toSale ? 'On Sale' : 'Ready Stock',
                                    style: TextStyle(
                                      color: toSale
                                          ? Colors.blue[700]
                                          : Colors.green[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    (toSale
                                            ? product.onSale
                                            : product.readyStock)
                                        .toString(),
                                    style: TextStyle(
                                      color: toSale
                                          ? Colors.blue[900]
                                          : Colors.green[900],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Text(
                        'Quantity to ${toSale ? 'Put on Sale' : 'Move to Ready Stock'}',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),

                      TextField(
                        controller: qtyController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: '0',
                          counterText: 'Maximum: $maxQuantity units',
                        ),
                        maxLength: maxQuantity.toString().length,
                        onChanged: (val) {
                          int newVal = int.tryParse(val) ?? 0;
                          if (newVal > maxQuantity) newVal = maxQuantity;
                          setStateDialog(() {
                            selectedQty = newVal;
                            qtyController.text = selectedQty.toString();
                            qtyController
                                .selection = TextSelection.fromPosition(
                              TextPosition(offset: qtyController.text.length),
                            );
                          });
                        },
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          quickButton('25%', 0.25),
                          quickButton('50%', 0.50),
                          quickButton('75%', 0.75),
                          quickButton('100%', 1.0),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                side: BorderSide(color: Colors.grey.shade400),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedQty > 0
                                    ? (toSale
                                          ? Colors.green[700]
                                          : Colors.blue[700])
                                    : Colors.grey,
                              ),
                              onPressed: selectedQty > 0
                                  ? () {
                                      setState(() {
                                        if (toSale) {
                                          product.onSale += selectedQty;
                                          product.readyStock -= selectedQty;
                                        } else {
                                          product.readyStock += selectedQty;
                                          product.onSale -= selectedQty;
                                        }
                                        product.lastUpdated = DateTime.now();
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              child: Text(
                                toSale ? 'Confirm Sale' : 'Confirm Move',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Product {
  String name;
  double price;
  int readyStock;
  int onSale;
  int sold;
  String imagePath;
  String category;
  DateTime lastUpdated;

  Product({
    required this.name,
    required this.price,
    required this.readyStock,
    required this.onSale,
    required this.sold,
    required this.imagePath,
    required this.category,
    required this.lastUpdated,
  });
}
