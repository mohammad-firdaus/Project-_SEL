import 'package:flutter/material.dart';

class CorporateOrdersPage extends StatefulWidget {
  @override
  _CorporateOrdersPageState createState() => _CorporateOrdersPageState();
}

class _CorporateOrdersPageState extends State<CorporateOrdersPage> {
  final Color greenColor = const Color(0xFF42B642);

  int selectedIndex = 0;

  final List<Map<String, dynamic>> orders = [
    {
      'title': 'Bamboo Utensil Set',
      'company': 'Sustainable Cafe Chain',
      'email': 'orders@sustaincafe.my',
      'contactNumber': '+60 13-678 9012',
      'dateNeeded': '15 Jan 2026',
      'shippingAddress': '456 Green Rd, Penang',
      'itemDescription': 'Eco-friendly bamboo utensils',
      'itemMaterial': 'Bamboo',
      'quantity': '1,000 units',
      'additionalRemarks': 'Include engraved logo',
      'status': 'Pending',
      'dateSubmitted': '19 Nov',
      'estPrice': 'RM 20,000',
    },
    {
      'title': 'Recycled Plastic Water Bottle',
      'company': 'Eco Events Malaysia',
      'email': 'info@ecoevents.my',
      'contactNumber': '+60 14-987 6543',
      'dateNeeded': '01 Dec 2025',
      'shippingAddress': '123 Blue St, Kuala Lumpur',
      'itemDescription': 'Reusable water bottle made from recycled plastic',
      'itemMaterial': 'Recycled Plastic',
      'quantity': '200 units',
      'additionalRemarks': '',
      'status': 'Contacted',
      'dateSubmitted': '18 Nov',
      'estPrice': 'RM 28,000',
    },
    {
      'title': 'Eco-Friendly Tote Bag',
      'company': 'Green Tech Solutions Sdn Bhd',
      'email': 'info@greentech.com',
      'contactNumber': '+60 14-235 4321',
      'dateNeeded': '20 Dec 2025',
      'shippingAddress': '789 Renewable Ave, Johor',
      'itemDescription': 'Reusable tote bags, green',
      'itemMaterial': 'Canvas',
      'quantity': '500 units',
      'additionalRemarks': '',
      'status': 'Pending',
      'dateSubmitted': '15 Nov',
      'estPrice': 'RM 6750.00',
    },
  ];

  static const Map<String, Color> statusColors = {
    'Pending': Color(0xFFFFD965),
    'Contacted': Color(0xFF40B0FF),
    'Completed': Color(0xFF4CAF50),
    'Cancelled': Color(0xFFFF6B6B),
  };

  List<Map<String, dynamic>> get filteredOrders {
    if (selectedIndex == 0) return orders;
    String selectedStatus = [
      'Pending',
      'Contacted',
      'Completed',
      'Cancelled',
    ][selectedIndex - 1];
    return orders.where((o) => o['status'] == selectedStatus).toList();
  }

  int countStatus(String status) =>
      orders.where((o) => o['status'] == status).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corporate Orders'), 
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        backgroundColor: greenColor,
        elevation: 1,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Summary Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _summaryItem('Total', orders.length.toString(), Colors.black87),
                _summaryItem(
                  'Pending',
                  countStatus('Pending').toString(),
                  statusColors['Pending']!,
                ),
                _summaryItem(
                  'Contacted',
                  countStatus('Contacted').toString(),
                  statusColors['Contacted']!,
                ),
                _summaryItem(
                  'Completed',
                  countStatus('Completed').toString(),
                  statusColors['Completed']!,
                ),
                _summaryItem(
                  'Cancelled',
                  countStatus('Cancelled').toString(),
                  statusColors['Cancelled']!,
                ),
              ],
            ),

            SizedBox(height: 10),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterChip('All (${orders.length})', 0),
                  SizedBox(width: 8),
                  _filterChip('Pending (${countStatus('Pending')})', 1),
                  SizedBox(width: 8),
                  _filterChip('Contacted (${countStatus('Contacted')})', 2),
                  SizedBox(width: 8),
                  _filterChip('Completed (${countStatus('Completed')})', 3),
                  SizedBox(width: 8),
                  _filterChip('Cancelled (${countStatus('Cancelled')})', 4),
                ],
              ),
            ),

            SizedBox(height: 10),
            Divider(),

            // Orders List
            Expanded(
              child: ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) =>
                    _orderCard(filteredOrders[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(String label, String count, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4),
        Text(
          count,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _filterChip(String text, int index) {
    bool isSelected = selectedIndex == index;
    return FilterChip(
      label: Text(text),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          selectedIndex = index;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.green[50],
      checkmarkColor: Colors.green,
      labelStyle: TextStyle(
        color: isSelected ? Colors.green : Colors.black87,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isSelected ? BorderSide(color: Colors.green) : BorderSide.none,
      ),
    );
  }

  Widget _orderCard(Map<String, dynamic> order) {
    final statusColor = statusColors[order['status']] ?? Colors.grey;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Status row + info icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        order['company'],
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () => _showOrderDetailPopup(order),
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(Icons.info_outline, color: Colors.grey[600]),
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('Quantity', order['quantity']),
                _infoColumn('Est. Price', order['estPrice']),
              ],
            ),

            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('Date Needed', order['dateNeeded']),
                _infoColumn('Submitted', order['dateSubmitted']),
              ],
            ),

            SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.email, size: 14, color: Colors.grey[600]),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    order['email'],
                    style: TextStyle(
                      color: Colors.blue[700],
                      decoration: TextDecoration.underline,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  void _showOrderDetailPopup(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 15,
        child: Container(
          constraints: BoxConstraints(maxHeight: 500),
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with close icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.close,
                        size: 26,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                _detailRow('Company Name', order['company']),
                _detailRow('Email Address', order['email']),
                _detailRow('Contact Number', order['contactNumber']),
                _detailRow('Date Needed', order['dateNeeded']),
                _detailRow('Shipping Address', order['shippingAddress']),
                _detailRow('Item Description', order['itemDescription']),
                _detailRow('Item Material', order['itemMaterial']),
                _detailRow('Quantity', order['quantity']),
                _detailRow(
                  'Additional Remarks',
                  order['additionalRemarks'].toString().trim().isEmpty
                      ? '-'
                      : order['additionalRemarks'],
                ),

                SizedBox(height: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () {
                            _updateOrderStatus(order, 'Contacted');
                            Navigator.of(context).pop();
                          },
                          child: Text('Mark Contacted'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () {
                            _updateOrderStatus(order, 'Completed');
                            Navigator.of(context).pop();
                          },
                          child: Text('Mark Completed'),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () {
                            _updateOrderStatus(order, 'Pending');
                            Navigator.of(context).pop();
                          },
                          child: Text('Back to Pending'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () {
                            _updateOrderStatus(order, 'Cancelled');
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel Request'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 15,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  void _updateOrderStatus(Map<String, dynamic> order, String newStatus) {
    setState(() {
      int index = orders.indexWhere(
        (o) => o['title'] == order['title'] && o['company'] == order['company'],
      );
      if (index != -1) {
        orders[index]['status'] = newStatus;
      }
    });
  }
}
