import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'models.dart'; // Import your Order + OrderItem + OrderStatus classes

class CustomerOrderDetailsPage extends StatefulWidget {
  final Order order;

  const CustomerOrderDetailsPage({super.key, required this.order});

  @override
  State<CustomerOrderDetailsPage> createState() =>
      _CustomerOrderDetailsPageState();
}

class _CustomerOrderDetailsPageState extends State<CustomerOrderDetailsPage> {
  double rating = 0;
  final feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        backgroundColor: const Color(0xFF42B642),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusSection(order),
            const SizedBox(height: 20),
            _buildItemsSection(order),
            const SizedBox(height: 20),
            _buildPaymentSummary(order),
            const SizedBox(height: 20),

            if (order.status == OrderStatus.shipped) _buildTrackingSection(),

            if (order.status == OrderStatus.shipped) _buildImageProof(),

            if (order.status == OrderStatus.shipped)
              _buildMarkAsReceivedButton(order),

            if (order.status == OrderStatus.received)
              _buildRatingFeedbackDisplay(order),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection(Order order) {
    String statusText = {
      OrderStatus.preparing: "Preparing",
      OrderStatus.shipped: "Shipped",
      OrderStatus.received: "Received",
    }[order.status]!;

    Color badgeColor = {
      OrderStatus.preparing: Colors.orange,
      OrderStatus.shipped: Colors.blue,
      OrderStatus.received: Colors.green,
    }[order.status]!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: badgeColor),
          const SizedBox(width: 10),
          Text(
            "$statusText Status",
            style: TextStyle(
              color: badgeColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(Order order) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Items Ordered",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            ...order.items.map((item) {
              return ListTile(
                title: Text(item.name),
                trailing: Text("RM${item.price} x${item.qty}"),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary(Order order) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Payment Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Amount"),
                Text("RM${order.totalAmount}"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tracking Number",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("FDX123456789MY"),
        ),
      ],
    );
  }

  Widget _buildImageProof() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Parcel Ready to Ship",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            "assets/images/sample_parcel.jpeg",
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildMarkAsReceivedButton(Order order) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF42B642),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {
          _openRatingDialog(order);
        },
        child: const Center(
          child: Text(
            "Mark as Received",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  void _openRatingDialog(Order order) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Rate Your Order"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              minRating: 1,
              itemSize: 32,
              allowHalfRating: false,
              itemBuilder: (_, __) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (value) => rating = value,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: feedbackController,
              decoration: const InputDecoration(
                labelText: "Feedback (optional)",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                order.status = OrderStatus.received;
                order.rating = rating.toInt();
                order.feedback = feedbackController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingFeedbackDisplay(Order order) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Rating",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: List.generate(
                order.rating ?? 0,
                (index) => const Icon(Icons.star, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Feedback",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(order.feedback ?? "- No feedback provided -"),
          ],
        ),
      ),
    );
  }
}
