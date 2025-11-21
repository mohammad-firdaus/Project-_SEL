// ignore_for_file: avoid_print, unnecessary_underscores

import 'package:flutter/material.dart';

class ManualSalesEntryPage extends StatefulWidget {
  const ManualSalesEntryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ManualSalesEntryPageState createState() => _ManualSalesEntryPageState();
}

class _ManualSalesEntryPageState extends State<ManualSalesEntryPage> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final Map<Product, int> selectedProducts = {}; // Product -> quantity

  final List<Product> products = [
    Product(
      name: 'Recycled Plastic Bottle',
      price: 2.50,
      stock: 145,
      imagePath: 'assets/images/plastic_bottle.png',
    ),
    Product(
      name: 'Glass Container Set',
      price: 15.00,
      stock: 67,
      imagePath: 'assets/images/glass_container.jpg',
    ),
    Product(
      name: 'Paper Shopping Bag',
      price: 3.50,
      stock: 289,
      imagePath: 'assets/images/paper_bag.jpg',
    ),
    Product(
      name: 'Metal Water Bottle',
      price: 18.00,
      stock: 98,
      imagePath: 'assets/images/metal_bottle.jpg',
    ),
    Product(
      name: 'Recycled Tote Bag',
      price: 8.50,
      stock: 156,
      imagePath: 'assets/images/tote_bag.jpg',
    ),
    Product(
      name: 'Eco Notebook',
      price: 6.00,
      stock: 234,
      imagePath: 'assets/images/eco_notebook.jpg',
    ),
  ];

  final Color primaryGreen = const Color(0xFF42B642);

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get allFieldsFilled =>
      _eventNameController.text.isNotEmpty &&
      _eventDateController.text.isNotEmpty &&
      _notesController.text.isNotEmpty &&
      selectedProducts.isNotEmpty;

  double get totalAmount {
    double total = 0;
    selectedProducts.forEach(
      (product, qty) => total += product.price * qty,
    );
    return total;
  }

  void _onProductTap(Product product) {
    setState(() {
      if (selectedProducts.containsKey(product)) {
        // If already selected, remove it (alternatively could ignore or update quantity)
        selectedProducts.remove(product);
      } else {
        selectedProducts[product] = 1;
      }
    });
  }

  void _incrementQuantity(Product product) {
    setState(() {
      if (selectedProducts[product]! < product.stock) {
        selectedProducts[product] = selectedProducts[product]! + 1;
      }
    });
  }

  void _decrementQuantity(Product product) {
    setState(() {
      if (selectedProducts[product]! > 1) {
        selectedProducts[product] = selectedProducts[product]! - 1;
      }
    });
  }

  void _removeProduct(Product product) {
    setState(() {
      selectedProducts.remove(product);
    });
  }

  void _recordSales() {
    // Example action: print out info or further processing
    String eventName = _eventNameController.text.trim();
    String eventDate = _eventDateController.text.trim();
    String notes = _notesController.text.trim();

    if (!allFieldsFilled) return;

    print('Recording sales for event: $eventName, date: $eventDate');
    print('Notes: $notes');
    selectedProducts.forEach((product, qty) {
      print('Product: ${product.name}, Quantity: $qty, Subtotal: RM${(product.price * qty).toStringAsFixed(2)}');
    });
    print('Total amount: RM${totalAmount.toStringAsFixed(2)}');

    // Optionally clear all inputs after recording:
    setState(() {
      _eventNameController.clear();
      _eventDateController.clear();
      _notesController.clear();
      selectedProducts.clear();
    });

    // Show confirmation snackbar:
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Sales recorded successfully!'),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manual Sales Entry',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen,
        leading: BackButton(color: Colors.white),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 16, bottom: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Record products sold during events',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // Event Details Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Event Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: _eventNameController,
                      decoration: InputDecoration(
                        labelText: 'Event Name',
                        hintText: 'e.g., Eco Fair 2024',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: _eventDateController,
                      decoration: InputDecoration(
                        labelText: 'Event Date',
                        hintText: 'YYYY-MM-DD',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          _eventDateController.text =
                              "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                          setState(() {});
                        }
                      },
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        labelText: 'Notes (Optional)',
                        hintText: 'Additional notes about the sales...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      maxLines: 4,
                      onChanged: (_) => setState(() {}),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Add Products Section Title
            const Text(
              'Add Products',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 8),

            // Product List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final product = products[index];
                final isSelected = selectedProducts.containsKey(product);
                return GestureDetector(
                  onTap: () => _onProductTap(product),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: isSelected ? 4 : 1,
                    color: isSelected ? Colors.green[50] : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade200,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                product.imagePath,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.grey[400]),
                                ),
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
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Stock: ${product.stock}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'RM ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Items to Record box if any selected
            if (selectedProducts.isNotEmpty) _buildSelectedItemsBox(),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: allFieldsFilled ? _recordSales : null,
                icon: const Icon(Icons.save_alt_outlined),
                label: const Text('Record Sales'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      allFieldsFilled ? primaryGreen : Colors.green[400],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedItemsBox() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.green[50],
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Items to Record',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            ...selectedProducts.entries.map((entry) {
              final product = entry.key;
              final qty = entry.value;
              final subtotal = product.price * qty;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Center(
                            child: Icon(Icons.image_not_supported,
                                color: Colors.grey[400]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'RM ${product.price.toStringAsFixed(2)} × $qty = RM ${subtotal.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green[700],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              _quantityButton(
                                  icon: Icons.remove,
                                  onPressed: () => _decrementQuantity(product)),
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  '$qty',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              _quantityButton(
                                  icon: Icons.add,
                                  onPressed: () => _incrementQuantity(product)),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => _removeProduct(product),
                                child: const Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Divider(color: Colors.green[200], thickness: 1),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total Amount: RM ${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quantityButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(6),
      ),
      child: IconButton(
        iconSize: 18,
        icon: Icon(icon, color: Colors.white),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final int stock;
  final String imagePath;

  Product({
    required this.name,
    required this.price,
    required this.stock,
    required this.imagePath,
  });

  // Override == and hashCode so Map keys work correctly for product objects:
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}