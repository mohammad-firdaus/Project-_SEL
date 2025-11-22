// ignore_for_file: unnecessary_underscores

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_sel/view/pages/admin_corporate_order_page.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  final Color greenColor = const Color(0xFF42B642);
  final ImagePicker _picker = ImagePicker();

  String _selectedStatusFilter = 'All';
  String _selectedSortFilter = 'By Date';

  final Map<String, int> statusCounts = {
    'Preparing': 2,
    'Shipped': 3,
    'Received': 4,
  };

  List<OrderData> orders = [
    OrderData(
      customerName: 'Alex Johnson',
      orderNumber: '#WTW20241119',
      orderDate: '11/21/2025',
      items: 2,
      status: 'Preparing',
      amount: 32.00,
      email: 'alex.johnson@email.com',
      phone: '+60 12-345-6789',
      address:
          '123 Green Street, Eco Valley, Kuala Lumpur, Wilayah Persekutuan 50450, Malaysia',
      orderItems: [
        OrderItem(name: 'Glass Container Set', qty: 1, price: 15.00),
        OrderItem(name: 'Recycled Tote Bag', qty: 2, price: 17.00),
      ],
    ),
    OrderData(
      customerName: 'Maria Garcia',
      orderNumber: '#WTW20241120',
      orderDate: '11/20/2025',
      items: 1,
      status: 'Preparing',
      amount: 25.00,
      email: 'maria.garcia@email.com',
      phone: '+60 13-456-7890',
      address: '456 Eco Lane, Green City, Penang, Pulau Pinang 11800, Malaysia',
      orderItems: [OrderItem(name: 'Metal Water Bottle', qty: 1, price: 25.00)],
    ),
    OrderData(
      customerName: 'John Smith',
      orderNumber: '#WTW20241118',
      orderDate: '11/18/2025',
      items: 3,
      status: 'Shipped',
      amount: 45.00,
      email: 'john.smith@email.com',
      phone: '+60 14-567-8901',
      address:
          '789 Sustainable Ave, Eco Town, Johor Bahru, Johor 81100, Malaysia',
      orderItems: [
        OrderItem(name: 'Paper Bag Set', qty: 2, price: 10.00),
        OrderItem(name: 'Plastic Bottle', qty: 1, price: 25.00),
      ],
      trackingNumber: 'TRK123456789',
      proofImagePath: 'assets/images/sample_parcel.jpeg',
    ),
    OrderData(
      customerName: 'Emily Davis',
      orderNumber: '#WTW20241117',
      orderDate: '11/17/2025',
      items: 2,
      status: 'Shipped',
      amount: 38.00,
      email: 'emily.davis@email.com',
      phone: '+60 15-678-9012',
      address:
          '101 Green Road, Nature Valley, Kuala Lumpur, Wilayah Persekutuan 50200, Malaysia',
      orderItems: [
        OrderItem(name: 'Eco Notebook', qty: 1, price: 18.00),
        OrderItem(name: 'Tote Bag', qty: 1, price: 20.00),
      ],
      trackingNumber: 'TRK987654321',
      proofImagePath: 'assets/images/sample_parcel.jpeg',
    ),
    OrderData(
      customerName: 'David Lee',
      orderNumber: '#WTW20241116',
      orderDate: '11/16/2025',
      items: 1,
      status: 'Shipped',
      amount: 15.00,
      email: 'david.lee@email.com',
      phone: '+60 16-789-0123',
      address:
          '202 Recycle Street, Eco District, Selangor, Petaling Jaya 47800, Malaysia',
      orderItems: [OrderItem(name: 'Glass Container', qty: 1, price: 15.00)],
      trackingNumber: 'TRK456789123',
      proofImagePath: 'assets/images/sample_parcel.jpeg',
    ),
    OrderData(
      customerName: 'Sophia Brown',
      orderNumber: '#WTW20241115',
      orderDate: '11/15/2025',
      items: 4,
      status: 'Received',
      amount: 60.00,
      email: 'sophia.brown@email.com',
      phone: '+60 17-890-1234',
      address:
          '303 Earth Way, Green Hills, Penang, Pulau Pinang 11900, Malaysia',
      orderItems: [
        OrderItem(name: 'Metal Bottle', qty: 1, price: 25.00),
        OrderItem(name: 'Paper Bag', qty: 2, price: 10.00),
        OrderItem(name: 'Tote Bag', qty: 1, price: 25.00),
      ],
      trackingNumber: 'TRK111111111',
      proofImagePath: 'assets/images/sample_parcel.jpeg',
      rating: 5,
      feedback: 'Excellent service and fast delivery!',
    ),
    OrderData(
      customerName: 'Liam Wilson',
      orderNumber: '#WTW20241114',
      orderDate: '11/14/2025',
      items: 2,
      status: 'Received',
      amount: 40.00,
      email: 'liam.wilson@email.com',
      phone: '+60 18-901-2345',
      address:
          '404 Nature Path, Eco Village, Johor Bahru, Johor 81200, Malaysia',
      orderItems: [
        OrderItem(name: 'Eco Notebook', qty: 1, price: 18.00),
        OrderItem(name: 'Plastic Bottle', qty: 1, price: 22.00),
      ],
      trackingNumber: 'TRK222222222',
      proofImagePath: 'assets/images/sample_parcel.jpeg',
      rating: 5,
      feedback: 'Excellent service and fast delivery!',
    ),
    OrderData(
      customerName: 'Olivia Taylor',
      orderNumber: '#WTW20241113',
      orderDate: '11/13/2025',
      items: 1,
      status: 'Received',
      amount: 20.00,
      email: 'olivia.taylor@email.com',
      phone: '+60 19-012-3456',
      address:
          '505 Green Blvd, Sustainable City, Kuala Lumpur, Wilayah Persekutuan 50300, Malaysia',
      orderItems: [OrderItem(name: 'Tote Bag', qty: 1, price: 20.00)],
      trackingNumber: 'TRK333333333',
      proofImagePath: 'assets/images/sample_parcel.jpeg',
      rating: 5,
      feedback: 'Excellent service and fast delivery!',
    ),
    OrderData(
      customerName: 'Noah Martinez',
      orderNumber: '#WTW20241112',
      orderDate: '11/12/2025',
      items: 3,
      status: 'Received',
      amount: 55.00,
      email: 'noah.martinez@email.com',
      phone: '+60 20-123-4567',
      address: '606 Eco Drive, Green Area, Selangor, Shah Alam 40100, Malaysia',
      orderItems: [
        OrderItem(name: 'Glass Container', qty: 1, price: 15.00),
        OrderItem(name: 'Metal Bottle', qty: 1, price: 25.00),
        OrderItem(name: 'Paper Bag', qty: 1, price: 15.00),
      ],
      trackingNumber: 'TRK444444444',
      proofImagePath: 'assets/images/sample_parcel.jpeg',
      rating: 5,
      feedback: 'Excellent service and fast delivery!',
    ),
  ];

  final statusFilterOptions = ['All', 'Preparing', 'Shipped', 'Received'];
  final sortFilterOptions = ['By Date', 'By Customer', 'By Amount'];

  final Set<String> _expandedOrders =
      {}; // Track expanded orders by orderNumber
  final Set<String> _shipOrderExpanded = {}; // Track ship section visible

  final Map<String, TextEditingController> _trackingControllers = {};
  final Map<String, File?> _selectedImageFiles = {};

  bool _isConfirmEnabled(String orderNumber) {
    final trackingNumber = _trackingControllers[orderNumber]?.text.trim() ?? '';
    final imageSelected = _selectedImageFiles[orderNumber] != null;
    return trackingNumber.isNotEmpty && imageSelected;
  }

  @override
  void dispose() {
    for (var c in _trackingControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  List<OrderData> get filteredOrders {
    var list = orders;
    if (_selectedStatusFilter != 'All') {
      list = list.where((o) => o.status == _selectedStatusFilter).toList();
    }
    if (_selectedSortFilter == 'By Amount') {
      list.sort((a, b) => a.amount.compareTo(b.amount));
    } else if (_selectedSortFilter == 'By Customer') {
      list.sort((a, b) => a.customerName.compareTo(b.customerName));
    } else {
      list.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    }
    return list;
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Preparing':
        return Colors.blue;
      case 'Shipped':
        return Colors.purple;
      case 'Received':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData statusIcon(String status) {
    switch (status) {
      case 'Preparing':
        return Icons.person;
      case 'Shipped':
        return Icons.local_shipping;
      case 'Received':
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          color: greenColor,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        'Order Tracking',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Manage customer orders and shipments',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statusCountWidget(
                            'Preparing',
                            statusCounts['Preparing'] ?? 0,
                            Colors.blue,
                          ),
                          _statusCountWidget(
                            'Shipped',
                            statusCounts['Shipped'] ?? 0,
                            Colors.purple,
                          ),
                          _statusCountWidget(
                            'Received',
                            statusCounts['Received'] ?? 0,
                            Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _buildFilterChips(
                            'Filter by Status',
                            statusFilterOptions,
                            _selectedStatusFilter,
                            (val) => setState(() {
                              _selectedStatusFilter = val!;
                            }),
                          ),
                          _buildFilterChips(
                            '',
                            sortFilterOptions,
                            _selectedSortFilter,
                            (val) => setState(() {
                              _selectedSortFilter = val!;
                            }),
                            backgroundColor: Colors.grey.shade200,
                            selectedColor: Colors.black87,
                            unselectedColor: Colors.grey.shade700,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    Center(
                      child: CorporateOrderRequestCard(pendingRequests: 2),
                    ),

                    const SizedBox(height: 16),
                    filteredOrders.isEmpty
                        ? const Center(child: Text('No orders found.'))
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredOrders.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final order = filteredOrders[index];
                              final isExpanded = _expandedOrders.contains(
                                order.orderNumber,
                              );
                              final isShipExpanded = _shipOrderExpanded
                                  .contains(order.orderNumber);
                              return _orderCard(
                                order,
                                isExpanded,
                                isShipExpanded,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _orderCard(OrderData order, bool isExpanded, bool isShipExpanded) {
    final color = statusColor(order.status);

    // TODO: add onTap for corporate order request card

    _trackingControllers.putIfAbsent(
      order.orderNumber,
      () => TextEditingController(),
    );
    _selectedImageFiles.putIfAbsent(order.orderNumber, () => null);

    final orderNumber = order.orderNumber;
    final trackingController = _trackingControllers[orderNumber]!;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isExpanded) {
            _expandedOrders.remove(orderNumber);
            _shipOrderExpanded.remove(orderNumber);
            trackingController.clear();
            _selectedImageFiles[orderNumber] = null;
          } else {
            _expandedOrders.add(orderNumber);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 20, color: Colors.grey[700]),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    order.customerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: color.withOpacity(0.15),
                    border: Border.all(color: color),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Order $orderNumber',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                Text(
                  order.orderDate,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: orderNumber));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Order number copied to clipboard'),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.copy,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.items} item(s)',
                  style: const TextStyle(fontSize: 13),
                ),
                Text(
                  'RM ${order.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              const Divider(height: 32, thickness: 1.2),
              const Text(
                'Customer Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              if (order.email != null)
                Row(
                  children: [
                    const Icon(Icons.email_outlined, size: 15),
                    const SizedBox(width: 6),
                    Expanded(child: Text(order.email!)),
                  ],
                ),
              if (order.phone != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 15),
                    const SizedBox(width: 6),
                    Expanded(child: Text(order.phone!)),
                  ],
                ),
              ],
              if (order.address != null) ...[
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 15),
                    const SizedBox(width: 6),
                    Expanded(child: Text(order.address!)),
                  ],
                ),
              ],
              const SizedBox(height: 18),
              const Text(
                'Order Items',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 12),
              ...?order.orderItems?.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(item.name)),
                      Text(
                        'Qty: ${item.qty}',
                        style: const TextStyle(fontSize: 13),
                      ),
                      Text(
                        'RM ${item.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              if (order.status == 'Shipped' || order.status == 'Received') ...[
                const Text(
                  'Shipment Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 12),
                if (order.trackingNumber != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.local_shipping_outlined, size: 15),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text('Tracking: ${order.trackingNumber!}'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                if (order.proofImagePath != null) ...[
                  const Text('Proof Image', style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Image.asset(
                      order.proofImagePath!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
                if (order.rating != null && order.feedback != null) ...[
                  const SizedBox(height: 18),
                  const Text(
                    'Customer Feedback',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Rating: ${order.rating}/5',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.comment,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Feedback: ${order.feedback}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ] else if (order.status == 'Preparing' && !isShipExpanded)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _shipOrderExpanded.add(orderNumber);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2DAF47),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Ship Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              if (isShipExpanded)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 32, thickness: 1.2),
                    const Text(
                      'Ship Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: trackingController,
                      decoration: const InputDecoration(
                        labelText: 'Tracking Number',
                        hintText: 'e.g., TRK123456789',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Parcel Image (Proof)',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Choose File'),
                      onPressed: () async {
                        final XFile? pickedImage = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedImage != null) {
                          setState(() {
                            _selectedImageFiles[orderNumber] = File(
                              pickedImage.path,
                            );
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    if (_selectedImageFiles[orderNumber] != null)
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Image.file(
                          _selectedImageFiles[orderNumber]!,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _shipOrderExpanded.remove(orderNumber);
                                trackingController.clear();
                                _selectedImageFiles[orderNumber] = null;
                              });
                            },
                            child: const Text('Cancel'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isConfirmEnabled(orderNumber)
                                ? () {
                                    setState(() {
                                      final idx = orders.indexWhere(
                                        (o) => o.orderNumber == orderNumber,
                                      );
                                      if (idx != -1) {
                                        orders[idx] = orders[idx].copyWith(
                                          status: 'Shipped',
                                          trackingNumber: trackingController
                                              .text
                                              .trim(),
                                          proofImagePath:
                                              _selectedImageFiles[orderNumber]
                                                  ?.path,
                                        );
                                      }
                                      _shipOrderExpanded.remove(orderNumber);
                                      _expandedOrders.remove(orderNumber);
                                      trackingController.clear();
                                      _selectedImageFiles[orderNumber] = null;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Shipment confirmed for order $orderNumber',
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isConfirmEnabled(orderNumber)
                                  ? const Color(0xFF2DAF47)
                                  : Colors.grey,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('Confirm Shipment'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _statusCountWidget(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildFilterChips(
    String label,
    List<String> options,
    String selected,
    Function(String?) onSelected, {
    Color backgroundColor = Colors.white,
    Color selectedColor = Colors.blue,
    Color unselectedColor = Colors.black54,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
        ...options.map((option) {
          final isSelected = option == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                option,
                style: TextStyle(
                  color: isSelected ? selectedColor : unselectedColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              backgroundColor: backgroundColor,
              selectedColor: selectedColor.withOpacity(0.1),
              onSelected: (_) => onSelected(option),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class CorporateOrderRequestCard extends StatelessWidget {
  final int pendingRequests;

  const CorporateOrderRequestCard({Key? key, required this.pendingRequests})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CorporateOrdersPage();
            },
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF8A00), Color(0xFFFF7400)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              // Icon Container
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.business_center,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              SizedBox(width: 12),

              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Corporate Order Requests',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$pendingRequests pending request${pendingRequests == 1 ? '' : 's'}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // Notification Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$pendingRequests',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension OrderDataCopy on OrderData {
  OrderData copyWith({
    String? customerName,
    String? orderNumber,
    String? orderDate,
    int? items,
    String? status,
    double? amount,
    String? email,
    String? phone,
    String? address,
    List<OrderItem>? orderItems,
    String? trackingNumber,
    String? proofImagePath,
    int? rating,
    String? feedback,
  }) {
    return OrderData(
      customerName: customerName ?? this.customerName,
      orderNumber: orderNumber ?? this.orderNumber,
      orderDate: orderDate ?? this.orderDate,
      items: items ?? this.items,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      orderItems: orderItems ?? this.orderItems,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      proofImagePath: proofImagePath ?? this.proofImagePath,
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
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
  final String? proofImagePath; // Path to the proof image
  final int? rating; // Customer rating (1-5)
  final String? feedback; // Customer feedback

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
}

class OrderItem {
  final String name;
  final int qty;
  final double price;

  OrderItem({required this.name, required this.qty, required this.price});
}
