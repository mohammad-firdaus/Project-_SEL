import 'dart:io';

class OrderItem {
  final String name;
  final int qty;
  final double price;

  OrderItem({required this.name, required this.qty, required this.price});

  factory OrderItem.fromMap(Map<dynamic, dynamic> map) {
    return OrderItem(
      name: map['name'] ?? '',
      qty: map['qty'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
    );
  }
}

class OrderData {
  final String customerName;
  final String orderNumber;
  final String orderDate;
  final int items;
  final String status;
  final double amount;
  final String? email;
  final String? phone;
  final String? address;
  final List<OrderItem>? orderItems;
  final String? trackingNumber;
  final String? proofImagePath;
  final int? rating;
  final String? feedback;

  OrderData({
    required this.customerName,
    required this.orderNumber,
    required this.orderDate,
    required this.items,
    required this.status,
    required this.amount,
    this.email,
    this.phone,
    this.address,
    this.orderItems,
    this.trackingNumber,
    this.proofImagePath,
    this.rating,
    this.feedback,
  });

  factory OrderData.fromMap(String id, Map<dynamic, dynamic> map) {
    return OrderData(
      orderNumber: id,
      customerName: map['customerName'] ?? 'Guest',
      orderDate: map['orderDate'] ?? '',
      items: map['items'] ?? 0,
      status: map['status'] ?? 'Pending',
      amount: (map['amount'] ?? 0).toDouble(),
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      trackingNumber: map['trackingNumber'],
      proofImagePath: map['proofImagePath'],
      rating: map['rating'],
      feedback: map['feedback'],
      orderItems: (map['orderItems'] as List?)
          ?.map((item) => OrderItem.fromMap(item))
          .toList(),
    );
  }
}

extension OrderDataCopy on OrderData {
  OrderData copyWith({String? status, String? trackingNumber, String? proofImagePath}) {
    return OrderData(
      customerName: customerName,
      orderNumber: orderNumber,
      orderDate: orderDate,
      items: items,
      status: status ?? this.status,
      amount: amount,
      email: email,
      phone: phone,
      address: address,
      orderItems: orderItems,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      proofImagePath: proofImagePath ?? this.proofImagePath,
      rating: rating,
      feedback: feedback,
    );
  }
}