import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_sel/view/pages/admin_shop_record_manual_sales_page.dart';

class AdminShop extends StatefulWidget {
  const AdminShop({super.key});

  @override
  _AdminShopState createState() => _AdminShopState();
}

class _AdminShopState extends State<AdminShop> {
  String dropdownValue = 'All Categories';
  final List<String> categories = [
    'All Categories',
    'Plastic',
    'Paper',
    'Glass',
    'Metal',
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
      category: 'Plastic',
    ),
    Product(
      name: 'Glass Container Set',
      price: 15.00,
      readyStock: 0,
      onSale: 0,
      sold: 6,
      imagePath: 'assets/images/glass_container.jpg',
      category: 'Glass',
    ),
    Product(
      name: 'Paper Shopping Bag',
      price: 3.50,
      readyStock: 97,
      onSale: 0,
      sold: 86,
      imagePath: 'assets/images/paper_bag.jpg',
      category: 'Paper',
    ),
    Product(
      name: 'Metal Water Bottle',
      price: 18.00,
      readyStock: 66,
      onSale: 0,
      sold: 58,
      imagePath: 'assets/images/metal_bottle.jpg',
      category: 'Metal',
    ),
    Product(
      name: 'Recycled Tote Bag',
      price: 8.50,
      readyStock: 0,
      onSale: 0,
      sold: 0,
      imagePath: 'assets/images/tote_bag.jpg',
      category: 'Plastic',
    ),
    Product(
      name: 'Eco Notebook',
      price: 6.00,
      readyStock: 88,
      onSale: 0,
      sold: 2,
      imagePath: 'assets/images/eco_notebook.jpg',
      category: 'Paper',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF42B642);
    List<Product> filteredProducts = dropdownValue == 'All Categories'
        ? products
        : products.where((p) => p.category == dropdownValue).toList();

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          color: primaryGreen,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
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
                      icon: Icon(Icons.note_add_outlined, color: Colors.white),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.5,
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(product.imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            product.category,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'RM ${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          Column(
            children: [
              _stockRow('Ready Stock', product.readyStock.toString()),
              _stockRow('On Sale', product.onSale.toString()),
              _stockRow('Sold', product.sold.toString()),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showPutOnSaleDialog(product),
              icon: const Icon(Icons.sell_outlined, color: Colors.white),
              label: const Text(
                'Put On Sale',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stockRow(String label, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(
            count,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showPutOnSaleDialog(Product product) {
    int maxReadyStock = product.readyStock;
    int currentOnSale = product.onSale;
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
              if (val > maxReadyStock) val = maxReadyStock;
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
                      backgroundColor: Colors.green[50],
                      foregroundColor: Colors.green[700],
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      int newQty = (maxReadyStock * percent).round();
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
                  color: Colors.green[700],
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
                    const Icon(Icons.sell_outlined, color: Colors.white),
                    const SizedBox(width: 8),
                    const Text(
                      'Put on Sale',
                      style: TextStyle(
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

                      // Ready Stock and On Sale boxes
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ready Stock',
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    maxReadyStock.toString(),
                                    style: TextStyle(
                                      color: Colors.green[900],
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
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'On Sale',
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currentOnSale.toString(),
                                    style: TextStyle(
                                      color: Colors.blue[900],
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

                      TextButton(
                        onPressed: () {}, // Your logic here
                        child: const Text(
                          'Move items from Ready Stock to On Sale inventory',
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 20),
                          alignment: Alignment.centerLeft,
                          textStyle: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 12),

                      const Text(
                        'Quantity to Put on Sale',
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
                          counterText:
                              'Maximum: $maxReadyStock units from ready stock',
                        ),
                        maxLength: maxReadyStock.toString().length,
                        onChanged: (val) {
                          int newVal = int.tryParse(val) ?? 0;
                          if (newVal > maxReadyStock) newVal = maxReadyStock;
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
                                    ? Colors.green[700]
                                    : Colors.grey,
                              ),
                              onPressed: selectedQty > 0
                                  ? () {
                                      setState(() {
                                        product.onSale += selectedQty;
                                        product.readyStock -= selectedQty;
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              child: const Text('Confirm Sale'),
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

  Product({
    required this.name,
    required this.price,
    required this.readyStock,
    required this.onSale,
    required this.sold,
    required this.imagePath,
    required this.category,
  });
}
