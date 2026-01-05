import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final CollectionReference _orders = FirebaseFirestore.instance.collection('orders');

  // CUSTOMER: Send new order to database
  Future<void> placeOrder(Map<String, dynamic> orderData) async {
    await _orders.add({
      ...orderData,
      'status': 'Pending', // Initial status for Admin to see
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ADMIN: Accept (Integrate) Order
  Future<void> acceptOrder(String orderId) async {
    await _orders.doc(orderId).update({'status': 'Preparing'});
  }

  // ADMIN: Reject Order
  Future<void> rejectOrder(String orderId) async {
    await _orders.doc(orderId).update({'status': 'Rejected'});
  }

  // Real-time stream for the Admin page
  Stream<QuerySnapshot> getAdminOrdersStream() {
    return _orders.orderBy('createdAt', descending: true).snapshots();
  }
}