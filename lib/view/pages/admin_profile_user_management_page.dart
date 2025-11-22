import 'package:flutter/material.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final Color greenColor = const Color(0xFF42B642);
  final List<Map<String, dynamic>> _users = [
    {
      'name': 'Sarah Cher',
      'email': 'sarah.chen@email.com',
      'role': 'Customer',
      'joined': 'Oct 2024',
      'orders': 12,
    },
    {
      'name': 'Ahmad Ibrahim',
      'email': 'ahmad.ibrahim@email.com',
      'role': 'Customer',
      'joined': 'Sep 2024',
      'orders': 8,
    },
    {
      'name': 'Siti Nurhaliza',
      'email': 'siti.nurhaliza@email.com',
      'role': 'Customer',
      'joined': 'Aug 2024',
      'orders': 15,
    },
    {
      'name': 'John Doe',
      'email': 'john.doe@email.com',
      'role': 'Admin',
      'joined': 'Jan 2023',
      'orders': 0,
    },
    {
      'name': 'Mary Jane',
      'email': 'mary.jane@email.com',
      'role': 'Customer',
      'joined': 'Jul 2024',
      'orders': 5,
    },
    {
      'name': 'David Tan',
      'email': 'david.tan@email.com',
      'role': 'Customer',
      'joined': 'Mar 2024',
      'orders': 20,
    },
    {
      'name': 'Lina Wong',
      'email': 'lina.wong@email.com',
      'role': 'Admin',
      'joined': 'Feb 2024',
      'orders': 1,
    },
  ];

  List<Map<String, dynamic>> _filteredUsers = [];

  final TextEditingController _searchController = TextEditingController();
  String _selectedSort = 'All';
  final List<String> _sortOptions = ['All', 'Customer', 'Admin'];

  int get totalUsers => _users.length;
  int get totalCustomers =>
      _users.where((user) => user['role'] == 'Customer').length;
  int get totalAdmins => _users.where((user) => user['role'] == 'Admin').length;

  @override
  void initState() {
    super.initState();
    _filteredUsers = List.from(_users);
    _searchController.addListener(_onSearchChanged);
    _applyFilters();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  void _onSortChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedSort = newValue;
        _applyFilters();
      });
    }
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      List<Map<String, dynamic>> filtered = List.from(_users);

      // Apply search filter
      if (query.isNotEmpty) {
        filtered = filtered.where((user) {
          final name = user['name'].toString().toLowerCase();
          final email = user['email'].toString().toLowerCase();
          return name.contains(query) || email.contains(query);
        }).toList();
      }

      // Apply sort filter
      if (_selectedSort != 'All') {
        filtered = filtered
            .where((user) => user['role'] == _selectedSort)
            .toList();
      }

      _filteredUsers = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        backgroundColor: greenColor,
        elevation: 1,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and subtitle
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.green[700],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manage platform users',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  SizedBox(height: 16),
                  // Card with stats
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statItem('Total Users', totalUsers.toString()),
                        _verticalDivider(),
                        _statItem('Customers', totalCustomers.toString()),
                        _verticalDivider(),
                        _statItem('Admins', totalAdmins.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Search input
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey[600]),
                ),
              ),
            ),

            SizedBox(height: 12),

            // Sort dropdown
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedSort,
                  items: _sortOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: _onSortChanged,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                  isExpanded: true,
                ),
              ),
            ),

            SizedBox(height: 12),

            // Showing count
            Text(
              'Showing ${_filteredUsers.length} users',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),

            SizedBox(height: 8),

            // User list
            Expanded(
              child: ListView.separated(
                itemCount: _filteredUsers.length,
                separatorBuilder: (_, __) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  return _userCard(
                    name: user['name'],
                    email: user['email'],
                    role: user['role'],
                    joined: user['joined'],
                    orders: user['orders'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
            fontSize: 20,
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(height: 30, width: 1, color: Colors.grey[300]);
  }

  Widget _userCard({
    required String name,
    required String email,
    required String role,
    required String joined,
    required int orders,
  }) {
    final bool isCustomer = role.toLowerCase() == 'customer';

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade200),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Icon(Icons.person_outline, color: Colors.green, size: 36),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  email,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
                SizedBox(height: 2),
                Text(
                  "Joined $joined",
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Role badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCustomer ? Colors.green[100] : Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  role,
                  style: TextStyle(
                    color: isCustomer ? Colors.green[800] : Colors.blue[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text(
                '$orders orders',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
