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
      trackingNumber: 'FDX987654321MY',
      imageProof: 'assets/images/sample_parcel.jpeg',
      rating: 5,
      feedback:
          'Excellent quality! The scrunchies are beautiful and well-made. Fast delivery too!',
    ),
    Order(
      orderId: '#WTW20241118',
      dateTime: DateTime.parse('2023-11-19 18:18:00'),
      status: OrderStatus.shipped,
      items: [
        OrderItem(name: 'Canvas Tote', qty: 2, price: 30),
        OrderItem(name: 'Medium String Bag', qty: 1, price: 15),
      ],
      trackingNumber: 'FDX123456789MY',
      imageProof: 'assets/images/sample_parcel.jpeg',
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
    Order(
      orderId: '#WTW20241110',
      dateTime: DateTime.parse('2023-11-13 18:18:00'),
      status: OrderStatus.received,
      items: [OrderItem(name: 'Knot Bag', qty: 1, price: 45)],
      trackingNumber: 'POS456789123MY',
      imageProof: 'assets/images/sample_parcel.jpeg',
      rating: 4,
      feedback:
          'Great product! Love the eco-friendly material. Highly recommended.',
    ),
  ];

  void _updateOrderStatus(
    int index,
    OrderStatus newStatus,
    int? rating,
    String? feedback,
  ) {
    setState(() {
      orders[index].status = newStatus;
      orders[index].rating = rating;
      orders[index].feedback = feedback;
    });
  }

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
                  return OrderCard(
                    order: orders[index],
                    onOrderUpdated: (status, rating, feedback) {
                      _updateOrderStatus(index, status, rating, feedback);
                    },
                  );
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
  final Function(OrderStatus, int?, String?)? onOrderUpdated;

  const OrderCard({super.key, required this.order, this.onOrderUpdated});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    IconData statusIcon;
    Color borderColor;

    if (order.status == OrderStatus.received) {
      statusColor = Colors.green.shade600;
      statusText = 'Received';
      statusIcon = Icons.check_circle;
      borderColor = Colors.green.shade300;
    } else if (order.status == OrderStatus.shipped) {
      statusColor = Colors.blue.shade600;
      statusText = 'Shipped';
      statusIcon = Icons.local_shipping;
      borderColor = Colors.blue.shade300;
    } else {
      statusColor = Colors.orange.shade600;
      statusText = 'Preparing';
      statusIcon = Icons.inventory_2;
      borderColor = Colors.orange.shade300;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor.withOpacity(0.3), width: 1.5),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 6,
      shadowColor: statusColor.withOpacity(0.3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, statusColor.withOpacity(0.02)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: Order ID + Status badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Icon(Icons.receipt_long, color: statusColor, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            order.orderId,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 0.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [statusColor, statusColor.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          statusText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDateTime(order.dateTime),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),
                ],
              ),

              const Divider(height: 24, thickness: 1),

              // List of ordered items
              ...order.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.shopping_bag,
                                size: 16,
                                color: statusColor,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Qty: ${item.qty}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'RM${item.price * item.qty}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const Divider(height: 24, thickness: 1),

              // Total amount and items
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'RM${order.totalAmount}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: statusColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Items',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          '${order.totalItems}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Additional info for received orders
              if (order.status == OrderStatus.received) ...[
                const SizedBox(height: 16),
                _buildReceivedOrderInfo(context),
              ],

              const SizedBox(height: 16),

              // View Details and Mark as Received Button block
              Align(
                alignment: Alignment.centerRight,
                child: order.status == OrderStatus.shipped
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomerOrderDetailsPage(
                                order: order,
                                onOrderReceived: (rating, feedback) {
                                  if (onOrderUpdated != null) {
                                    onOrderUpdated!(
                                      OrderStatus.received,
                                      rating,
                                      feedback,
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline, size: 18),
                        label: const Text('Mark as Received'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: statusColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
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
                        icon: const Icon(Icons.visibility, size: 18),
                        label: Text(
                          order.status == OrderStatus.received
                              ? 'View Full Details'
                              : 'View Details',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: statusColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: statusColor, width: 1.5),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceivedOrderInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade50,
            Colors.green.shade100.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tracking Number
          if (order.trackingNumber != null) ...[
            Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  size: 16,
                  color: Colors.green.shade700,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Tracking:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order.trackingNumber!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // Image Proof Thumbnail and Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Thumbnail
              if (order.imageProof != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    order.imageProof!,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(width: 12),

              // Rating and Feedback
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (order.rating != null) ...[
                      const Text(
                        'Your Rating:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < order.rating!
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber.shade600,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                    if (order.feedback != null &&
                        order.feedback!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        order.feedback!.length > 60
                            ? '${order.feedback!.substring(0, 60)}...'
                            : order.feedback!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
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
