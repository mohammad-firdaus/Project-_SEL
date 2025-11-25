import 'package:flutter/material.dart';

// Cart item model to manage cart data
class CartItem {
  final String name;
  final String type;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.type,
    required this.price,
    this.quantity = 1,
  });
}

// Cart service to manage cart state
class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  
  void addItem(CartItem item) {
    // Check if item already exists in cart
    final existingIndex = _items.indexWhere((cartItem) => 
        cartItem.name == item.name && cartItem.type == item.type);
    
    if (existingIndex != -1) {
      // Increase quantity if item exists
      _items[existingIndex].quantity += item.quantity;
    } else {
      // Add new item
      _items.add(item);
    }
  }
  
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }
  
  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _items.length && newQuantity > 0) {
      _items[index].quantity = newQuantity;
    }
  }
  
  void clearCart() {
    _items.clear();
  }
  
  double get subtotal => _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
}

// Payment-related models
enum PaymentMethod { ewallet, fpx }

class Bank {
  final String name;
  final String code;
  final String logo;

  Bank({required this.name, required this.code, required this.logo});
}

class EWallet {
  final String name;
  final String logo;

  EWallet({required this.name, required this.logo});
}

class CustomerShop extends StatefulWidget {
  const CustomerShop({super.key});

  @override
  _CustomerShopState createState() => _CustomerShopState();
}

class _CustomerShopState extends State<CustomerShop> {
  final Color primaryGreen = const Color(0xFF42B642);
  String _selectedFilter = 'All Collection';
  String _selectedCategory = 'Basic';
  String _selectedProductType = 'Scrunchies';
  
  final List<String> _filters = [
    'All Collection',
    'Hot Selling',
    'Basic',
    'Standard',
    'Premium',
    'Corporate',
    'Urban Compost'
  ];

  final Map<String, List<String>> _productTypes = {
    'Basic': ['Scrunchies', 'Keychain', 'Luggage Bag Tag'],
    'Standard': ['Medium String Bag', 'Large String Bag', 'Tote Bag'],
    'Premium': ['Knot Bag', 'Batwing Outwear'],
    'Corporate': ['Ecotote', 'Lanyard'],
    'Urban Compost': ['Eco-kit Bokashi', 'Ecobran'],
  };

  // Method to show add to cart confirmation
  void _showAddToCartSnackbar(String productName, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName added to cart!'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            _navigateToCart(context);
          },
        ),
        backgroundColor: primaryGreen,
      ),
    );
  }

  // Method to navigate to cart page
  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar with Cart Icon
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[600]),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
                // Cart icon with badge
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: primaryGreen,
                      onPressed: () => _navigateToCart(context),
                    ),
                    if (CartService().totalItems > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: Text(
                            CartService().totalItems.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Advertisement Box
          Container(
            width: double.infinity,
            height: 120,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4DB6AC), primaryGreen],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 16,
                  top: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Offer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Get 20% off on all\npremium products',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'Premium';
                        _selectedCategory = 'Premium';
                        _selectedProductType = 'Knot Bag';
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Shop Now',
                        style: TextStyle(
                          color: Color(0xFF00796B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Filter Chips with better scrollable design
          Container(
            height: 60,
            margin: EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Collections',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _filters.asMap().entries.map((entry) {
                      final filter = entry.value;
                      final isFirst = entry.key == 0;
                      final isLast = entry.key == _filters.length - 1;
                      
                      return Container(
                        margin: EdgeInsets.only(
                          left: isFirst ? 0 : 4,
                          right: isLast ? 0 : 4,
                        ),
                        child: FilterChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedFilter = filter;
                              if (filter != 'All Collection' && filter != 'Hot Selling') {
                                _selectedCategory = filter;
                                // Set first product type as default when category changes
                                if (_productTypes[_selectedCategory] != null && 
                                    _productTypes[_selectedCategory]!.isNotEmpty) {
                                  _selectedProductType = _productTypes[_selectedCategory]!.first;
                                }
                              } else {
                                // For All Collection or Hot Selling, set first available product type
                                _selectedProductType = _productTypes['Basic']!.first;
                              }
                            });
                          },
                          selectedColor: primaryGreen,
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                          backgroundColor: Colors.grey[200],
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: _selectedFilter == filter ? primaryGreen : Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          
          // Products Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Expanded - Product Types
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildProductTypesList(),
                  ),
                ),
              ),
              
              SizedBox(width: 16),
              
              // Right Expanded - Product Cards
              Expanded(
                flex: 2,
                child: _buildProductCards(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  List<Widget> _buildProductTypesList() {
    List<String> types = [];
    
    if (_selectedFilter == 'All Collection' || _selectedFilter == 'Hot Selling') {
      // Show all product types from all categories
      _productTypes.forEach((category, typeList) {
        types.addAll(typeList);
      });
    } else {
      types = _productTypes[_selectedCategory] ?? [];
    }
    
    return types.map((type) {
      final isSelected = _selectedProductType == type;
      
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedProductType = type;
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? primaryGreen.withOpacity(0.1) : Colors.transparent,
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!),
              left: BorderSide(
                color: isSelected ? primaryGreen : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? primaryGreen : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  size: 16,
                  color: primaryGreen,
                ),
            ],
          ),
        ),
      );
    }).toList();
  }
  
  Widget _buildProductCards() {
    // Sample product data - in real app, this would come from your data source
    List<Map<String, dynamic>> products = [
      {
        'name': 'Eco Scrunchies',
        'price': 12.99,
        'category': 'Basic',
        'type': 'Scrunchies',
        'image': 'assets/scrunchies.jpg',
      },
      {
        'name': 'Recycled Keychain',
        'price': 8.99,
        'category': 'Basic',
        'type': 'Keychain',
        'image': 'assets/keychain.jpg',
      },
      {
        'name': 'Medium String Bag',
        'price': 24.99,
        'category': 'Standard',
        'type': 'Medium String Bag',
        'image': 'assets/string_bag.jpg',
      },
      {
        'name': 'Large String Bag',
        'price': 29.99,
        'category': 'Standard',
        'type': 'Large String Bag',
        'image': 'assets/large_string_bag.jpg',
      },
      {
        'name': 'Premium Knot Bag',
        'price': 45.99,
        'category': 'Premium',
        'type': 'Knot Bag',
        'image': 'assets/knot_bag.jpg',
      },
      {
        'name': 'Batwing Outwear',
        'price': 65.99,
        'category': 'Premium',
        'type': 'Batwing Outwear',
        'image': 'assets/batwing.jpg',
      },
      {
        'name': 'Eco-tote Bag',
        'price': 32.99,
        'category': 'Corporate',
        'type': 'Ecotote',
        'image': 'assets/ecotote.jpg',
      },
      {
        'name': 'Corporate Lanyard',
        'price': 15.99,
        'category': 'Corporate',
        'type': 'Lanyard',
        'image': 'assets/lanyard.jpg',
      },
    ];
    
    // Filter products based on selected filter and product type
    List<Map<String, dynamic>> filteredProducts = products.where((product) {
      // First filter by collection
      if (_selectedFilter == 'All Collection') {
        // Then filter by product type if one is selected
        return _selectedProductType == product['type'];
      }
      if (_selectedFilter == 'Hot Selling') {
        // Add hot selling logic - for demo, just return some products
        return true;
      }
      // Filter by category and product type
      return product['category'] == _selectedFilter && 
             (_selectedProductType == product['type'] || _selectedFilter == 'All Collection');
    }).toList();

    // If no products match the specific type, show all from the category
    if (filteredProducts.isEmpty && _selectedFilter != 'All Collection' && _selectedFilter != 'Hot Selling') {
      filteredProducts = products.where((product) => product['category'] == _selectedFilter).toList();
    }

    return Column(
      children: [
        if (_selectedProductType.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Products: $_selectedProductType',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12),
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
              child: Row(
                children: [
                  // Product Image
                  Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.shopping_bag, color: Colors.grey[400]),
                  ),
                  
                  // Product Details
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            product['type'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '\$${product['price'].toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Add to Cart Button
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      color: primaryGreen,
                      onPressed: () {
                        // Add to cart functionality
                        CartService().addItem(CartItem(
                          name: product['name'],
                          type: product['type'],
                          price: product['price'],
                        ));
                        
                        // Show confirmation snackbar
                        _showAddToCartSnackbar(product['name'], context);
                        
                        // Update UI to reflect cart changes
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// Cart Page
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Color primaryGreen = const Color(0xFF42B642);

  double get deliveryFee => 5.00;
  double get subtotal => CartService().subtotal;
  double get total => subtotal + deliveryFee;

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      CartService().updateQuantity(index, newQuantity);
    });
  }

  void _removeItem(int index) {
    setState(() {
      CartService().removeItem(index);
    });
  }

  void _proceedToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Your Cart',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 20),
            
            // Cart Items
            if (CartService().items.isEmpty)
              Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add some eco-friendly products to get started!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: CartService().items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Image Placeholder
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.grey[400],
                          ),
                        ),
                        SizedBox(width: 16),
                        
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                item.type,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'RM${item.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Quantity Controls
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, size: 18),
                                    onPressed: () => _updateQuantity(index, item.quantity - 1),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(minWidth: 36),
                                  ),
                                  Text(
                                    item.quantity.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, size: 18),
                                    onPressed: () => _updateQuantity(index, item.quantity + 1),
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(minWidth: 36),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            TextButton(
                              onPressed: () => _removeItem(index),
                              child: Text(
                                'Remove',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            
            if (CartService().items.isNotEmpty) ...[
              // Divider
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                height: 1,
                color: Colors.grey[300],
              ),
              
              // Pricing Summary
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Subtotal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'RM${subtotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    
                    // Delivery Fee
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_box_outline_blank, size: 20, color: Colors.grey[600]),
                            SizedBox(width: 8),
                            Text(
                              'Delivery Fee',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'RM${deliveryFee.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // Total
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                          Text(
                            'RM${total.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    // Thank you message
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.eco, color: Colors.green, size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Thank you for choosing eco-friendly products! 😊',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Checkout Button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _proceedToCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Checkout Page
class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Color primaryGreen = const Color(0xFF42B642);
  PaymentMethod _selectedPaymentMethod = PaymentMethod.ewallet;
  Bank? _selectedBank;
  EWallet? _selectedEWallet;
  
  final List<Bank> _banks = [
    Bank(name: 'Maybank', code: 'MB2U', logo: 'M'),
    Bank(name: 'CIMB Bank', code: 'CIMB', logo: 'C'),
    Bank(name: 'Public Bank', code: 'PBB', logo: 'P'),
    Bank(name: 'RHB Bank', code: 'RHB', logo: 'R'),
    Bank(name: 'Hong Leong Bank', code: 'HLB', logo: 'H'),
    Bank(name: 'AmBank', code: 'AMMB', logo: 'A'),
    Bank(name: 'Bank Islam', code: 'BIMB', logo: 'B'),
  ];
  
  final List<EWallet> _eWallets = [
    EWallet(name: 'Touch \'n Go', logo: 'TNG'),
    EWallet(name: 'GrabPay', logo: 'Grab'),
    EWallet(name: 'Boost', logo: 'Boost'),
    EWallet(name: 'ShopeePay', logo: 'Shopee'),
  ];

  double get deliveryFee => 5.00;
  double get subtotal => CartService().subtotal;
  double get total => subtotal + deliveryFee;

  void _processPayment() {
    if (_selectedPaymentMethod == PaymentMethod.ewallet && _selectedEWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an e-wallet'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    if (_selectedPaymentMethod == PaymentMethod.fpx && _selectedBank == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a bank'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Processing Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: primaryGreen),
            SizedBox(height: 16),
            Text('Please wait while we process your payment...'),
          ],
        ),
      ),
    );

    // Simulate payment processing
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close processing dialog
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Successful!'),
          content: Text('Thank you for your purchase. Your order has been placed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close success dialog
                _completeOrder();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  void _completeOrder() {
    CartService().clearCart();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => OrderConfirmationPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 16),
            
            // Order Items
            Container(
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
              child: Column(
                children: [
                  ...CartService().items.map((item) => ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.shopping_bag_outlined, size: 20),
                    ),
                    title: Text(item.name),
                    subtitle: Text('${item.type} • Qty: ${item.quantity}'),
                    trailing: Text(
                      'RM${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                  )).toList(),
                  
                  Divider(),
                  
                  // Pricing Summary
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal'),
                            Text('RM${subtotal.toStringAsFixed(2)}'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Fee'),
                            Text('RM${deliveryFee.toStringAsFixed(2)}'),
                          ],
                        ),
                        SizedBox(height: 12),
                        Divider(),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryGreen,
                              ),
                            ),
                            Text(
                              'RM${total.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            // Payment Method Selection
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 16),
            
            Container(
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
              child: Column(
                children: [
                  // E-Wallet Option
                  ListTile(
                    leading: Icon(Icons.wallet, color: primaryGreen),
                    title: Text('E-Wallet'),
                    trailing: Radio<PaymentMethod>(
                      value: PaymentMethod.ewallet,
                      groupValue: _selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                      activeColor: primaryGreen,
                    ),
                  ),
                  
                  if (_selectedPaymentMethod == PaymentMethod.ewallet) ...[
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select E-Wallet:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: _eWallets.map((ewallet) {
                              final isSelected = _selectedEWallet == ewallet;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedEWallet = ewallet;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryGreen.withOpacity(0.1) : Colors.grey[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected ? primaryGreen : Colors.grey[300]!,
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: primaryGreen,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            ewallet.logo.substring(0, 1),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        ewallet.name,
                                        style: TextStyle(
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  // FPX Option
                  ListTile(
                    leading: Icon(Icons.account_balance, color: primaryGreen),
                    title: Text('FPX Online Banking'),
                    trailing: Radio<PaymentMethod>(
                      value: PaymentMethod.fpx,
                      groupValue: _selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                      activeColor: primaryGreen,
                    ),
                  ),
                  
                  if (_selectedPaymentMethod == PaymentMethod.fpx) ...[
                    Divider(height: 1),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Bank:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          Column(
                            children: _banks.map((bank) {
                              final isSelected = _selectedBank == bank;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedBank = bank;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? primaryGreen.withOpacity(0.1) : Colors.grey[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected ? primaryGreen : Colors.grey[300]!,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: primaryGreen,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            bank.logo,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              bank.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              bank.code,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(Icons.check_circle, color: primaryGreen),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
            // Pay Now Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Pay Now - RM${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Order Confirmation Page with configurable navigation
class OrderConfirmationPage extends StatelessWidget {
  final Color primaryGreen = const Color(0xFF42B642);
  final VoidCallback? onContinueShopping;
  
  // Constructor with optional callback
  OrderConfirmationPage({this.onContinueShopping});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 80,
                color: primaryGreen,
              ),
              SizedBox(height: 24),
              Text(
                'Order Placed Successfully!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Thank you for your purchase. Your order has been confirmed and will be processed shortly.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (onContinueShopping != null) {
                    // Use the custom callback if provided
                    onContinueShopping!();
                  } else {
                    // Default behavior: navigate to home page
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => CustomerShop()),
                      (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text('Continue Shopping'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}