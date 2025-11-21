import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({super.key});

  @override
  _AdminOrdersState createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  final Color greenColor = const Color(0xFF42B642);

  String _selectedStatusFilter = 'All';
  String _selectedSortFilter = 'By Date';

  final Map<String, int> statusCounts = {
    'Preparing': 1,
    'Shipped': 1,
    'Received': 8,
  };

  final List<OrderData> orders = [
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
    // You can add other orders here...
  ];

  final statusFilterOptions = ['All', 'Preparing', 'Shipped', 'Received'];
  final sortFilterOptions = ['By Date', 'By Customer', 'By Amount'];

  final Set<String> _expandedOrders =
      {}; // track expanded orders by orderNumber

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
                children: [
                  // Heading section
                  Row(
                    children: const [
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
                  const SizedBox(height: 2),
                  const Text(
                    'Manage customer orders and shipments',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
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
                        boxShadow: [
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

                    // Orange Corporate Order Requests Box inserted here
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade600,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Corporate Order Requests\n2 pending requests',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade800,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    
                    filteredOrders.isEmpty
                        ? const Center(child: Text('No orders found.'))
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredOrders.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final order = filteredOrders[index];
                              final isExpanded = _expandedOrders.contains(
                                order.orderNumber,
                              );
                              return _orderCard(order, isExpanded);
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

  Widget _orderCard(OrderData order, bool isExpanded) {
    final color = statusColor(order.status);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isExpanded) {
            _expandedOrders.remove(order.orderNumber);
          } else {
            _expandedOrders.add(order.orderNumber);
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
            // Top row info
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

            // Order number and date, with copy icon
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Order ${order.orderNumber}',
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
                    Clipboard.setData(ClipboardData(text: order.orderNumber));
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

            // Item count and price in one line
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

              // Customer Details Title
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

              // Order Items Title
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

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Add ship order logic
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
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

class OrderData {
  final String customerName;
  final String orderNumber;
  final String orderDate; // Format MM/DD/YYYY
  final int items;
  final String status;
  final double amount;

  final String? email;
  final String? phone;
  final String? address;
  final List<OrderItem>? orderItems;

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
  });
}

class OrderItem {
  final String name;
  final int qty;
  final double price;

  OrderItem({required this.name, required this.qty, required this.price});
}
