import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:project_sel/view/customer_widget_tree.dart';

/// ============================
/// CART MODELS & SERVICE
/// ============================
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

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    final index = _items.indexWhere(
      (e) => e.name == item.name && e.type == item.type,
    );

    if (index != -1) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
  }

  void updateQuantity(int index, int qty) {
    if (qty > 0) _items[index].quantity = qty;
  }

  void removeItem(int index) {
    _items.removeAt(index);
  }

  void clearCart() => _items.clear();

  double get subtotal =>
      _items.fold(0, (sum, e) => sum + e.price * e.quantity);

  int get totalItems =>
      _items.fold(0, (sum, e) => sum + e.quantity);
}

/// ============================
/// CART PAGE (FULL UI RESTORED)
/// ============================
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Color primaryGreen = const Color(0xFF42B642);

  double get deliveryFee => 5.00;
  double get subtotal => CartService().subtotal;
  double get total => subtotal + deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CartService().items.isEmpty
            ? _emptyCart()
            : Column(
                children: [
                  Expanded(child: _cartItems()),
                  _summary(),
                  _checkoutButton(context),
                ],
              ),
      ),
    );
  }

  Widget _emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text('Your cart is empty'),
        ],
      ),
    );
  }

  Widget _cartItems() {
    return ListView.builder(
      itemCount: CartService().items.length,
      itemBuilder: (context, index) {
        final item = CartService().items[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.shopping_bag_outlined),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                      Text(item.type),
                      Text(
                        'RM ${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: primaryGreen,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          CartService()
                              .updateQuantity(index, item.quantity - 1);
                        });
                      },
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          CartService()
                              .updateQuantity(index, item.quantity + 1);
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          CartService().removeItem(index);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _summary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row('Subtotal', subtotal),
            _row('Delivery Fee', deliveryFee),
            const Divider(),
            _row('Total', total, bold: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, double value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        Text('RM ${value.toStringAsFixed(2)}',
            style:
                TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _checkoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckoutPage()),
            );
          },
          child: const Text('Proceed to Checkout'),
        ),
      ),
    );
  }
}

/// ============================
/// CHECKOUT PAGE (TOYYIBPAY)
/// ============================
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Color primaryGreen = const Color(0xFF42B642);

  double get total => CartService().subtotal + 5;

  Future<void> _payWithToyyibPay() async {
    final response = await http.post(
      Uri.parse('https://dev.toyyibpay.com/index.php/api/createBill'),
      body: {
        'userSecretKey': 'doihxxan-9t6e-6z8k-yd2x-s0gdhm16t7os',
        'categoryCode': 'r1e003un',
        'billName': 'EcoFab Order',
        'billDescription': 'Payment',
        'billAmount': (total * 100).toInt().toString(),
        'billReturnUrl': 'https://example.com/return',
        'billCallbackUrl': 'https://example.com/callback',
      },
    );

    final data = json.decode(response.body);
    final billCode = data[0]['BillCode'];
    final url = Uri.parse('https://dev.toyyibpay.com/$billCode');

    await launchUrl(url, mode: LaunchMode.externalApplication);

    CartService().clearCart();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const OrderConfirmationPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: primaryGreen,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryGreen),
          onPressed: _payWithToyyibPay,
          child: Text('Pay Now - RM ${total.toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}

/// ============================
/// ORDER CONFIRMATION
/// ============================
class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            const Text('Order Successful!',
                style: TextStyle(fontSize: 22)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CustomerWidgetTree(),
                  ),
                );
              },
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
