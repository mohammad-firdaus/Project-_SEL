enum OrderStatus { preparing, shipped, received }

class OrderItem {
  final String name;
  final int qty;
  final int price; // RM in whole number

  OrderItem({required this.name, required this.qty, required this.price});
}

class Order {
  final String orderId;
  final DateTime dateTime;
  OrderStatus status;
  final List<OrderItem> items;

  int? rating;
  String? feedback;

  Order({
    required this.orderId,
    required this.dateTime,
    required this.status,
    required this.items,
    this.rating,
    this.feedback,
  });

  int get totalAmount =>
      items.fold(0, (sum, item) => sum + item.price * item.qty);

  int get totalItems => items.fold(0, (sum, item) => sum + item.qty);
}
