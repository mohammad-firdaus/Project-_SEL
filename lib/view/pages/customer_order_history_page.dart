import 'package:flutter/material.dart';
import 'customer_order_details_page.dart';
import 'models.dart';

class CustomerOrderHistoryPage extends StatefulWidget {
  const CustomerOrderHistoryPage({super.key});

  @override
  State<CustomerOrderHistoryPage> createState() =>
      _CustomerOrderHistoryPageState();
}

class _CustomerOrderHistoryPageState extends State<CustomerOrderHistoryPage> {
  List<Order> orders = [
    Order(
      orderId: '#WTW20241120',
      dateTime: DateTime.parse('2023-11-21 18:18:00'),
      status: OrderStatus.received,
      items: [
        OrderItem(name: 'Floral Scrunchie', qty: 1, price: 15),
        OrderItem(name: 'Velvet Scrunchie', qty: 1, price: 18),
      ],
    ),
    Order(
      orderId: '#WTW20241118',
      dateTime: DateTime.parse('2023-11-19 18:18:00'),
      status: OrderStatus.shipped,
      items: [
        OrderItem(name: 'Canvas Tote', qty: 2, price: 30),
        OrderItem(name: 'Medium String Bag', qty: 1, price: 15),
      ],
    ),
    Order(
      orderId: '#WTW20241115',
      dateTime: DateTime.parse('2023-11-17 18:18:00'),
      status: OrderStatus.preparing,
      items: [
        OrderItem(name: 'Bokashi Kit', qty: 1, price: 85),
        OrderItem(name: 'Ecobrain Mix', qty: 2, price: 18),
      ],
    ),
    /*   Removed order with actionRequired status */
    Order(
      orderId: '#WTW20241110',
      dateTime: DateTime.parse('2023-11-13 18:18:00'),
      status: OrderStatus.received,
      items: [OrderItem(name: 'Knot Bag', qty: 1, price: 45)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order History',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF42B642),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Header with orders found count
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF42B642),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${orders.length} orders found',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Info box (optional - shown only once)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF6353F3), Color(0xFF9F6FF8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Order Shipped!\nYour order is on the way. Mark as received when you get it.',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            // Expanded list of order cards
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: orders[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    if (order.status == OrderStatus.received) {
      statusColor = Colors.green.shade600;
      statusText = 'Received';
    } else if (order.status == OrderStatus.shipped) {
      statusColor = Colors.blue.shade600;
      statusText = 'Shipped';
    } else {
      statusColor = Colors.orange.shade600;
      statusText = 'Preparing';
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Order ID + Status badge + Date time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    order.orderId,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              _formatDateTime(order.dateTime),
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const Divider(height: 22),

            // List of ordered items
            ...order.items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.name, style: const TextStyle(fontSize: 14)),
                    Text(
                      'RM${item.price}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            }),

            const Divider(height: 22),

            // Total amount and items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'RM${order.totalAmount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Items'),
                Text(order.totalItems.toString()),
              ],
            ),

            const SizedBox(height: 14),

            // View Details and Mark as Received Button block
            Align(
              alignment: Alignment.centerRight,
              child: order.status == OrderStatus.shipped
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CustomerOrderDetailsPage(order: order),
                          ),
                        );
                      },
                      child: const Text('Mark as Received'),
                    )
                  : TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CustomerOrderDetailsPage(order: order),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      label: const Text(
                        'View Details',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    String day = dt.day.toString().padLeft(2, '0');
    String month = months[dt.month - 1];
    String year = dt.year.toString();

    int hour = dt.hour;
    int minute = dt.minute;
    String ampm = 'am';
    if (hour >= 12) {
      ampm = 'pm';
      if (hour > 12) hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }
    String minStr = minute.toString().padLeft(2, '0');

    return '$day $month $year, $hour:$minStr $ampm';
  }
}
