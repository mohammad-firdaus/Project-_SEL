import 'package:flutter/material.dart';

class AdminProducts extends StatefulWidget {
  const AdminProducts({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminProductsState createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  // Sample stock summary values - now computed dynamically
  late List<ProductStock> products = [
    ProductStock(
      name: 'Recycled Plastic Bottle',
      price: 2.50,
      category: 'Plastic',
      availableStock: 145,
      returnQty: 12,
      imagePath: 'assets/images/plastic_bottle.png',
      readyLabel: 'Ready',
      returnLabel: 'Return',
      stockNote: 'Ready Products ready for sale',
      returnNote: 'Return Products for return/repair',
      phase: 'Phase 1',
      displayName: 'Display: Eco Bottle',
    ),
    ProductStock(
      name: 'Glass Container Set',
      price: 15.00,
      category: 'Glass',
      availableStock: 67,
      returnQty: 8,
      imagePath: 'assets/images/glass_container.jpg',
      readyLabel: 'Ready',
      returnLabel: 'Return',
      stockNote: 'Stock from Glass Storage',
      returnNote: 'Return quantity',
      phase: 'Phase 1',
      displayName: 'Display: Glass Set',
    ),
    ProductStock(
      name: 'Paper Shopping Bag',
      price: 3.50,
      category: 'Paper',
      availableStock: 289,
      returnQty: 23,
      imagePath: 'assets/images/paper_bag.jpg',
      readyLabel: 'Ready',
      returnLabel: 'Return',
      stockNote: 'Paper Inventory',
      returnNote: 'Return quantity',
      phase: 'Phase 1',
      displayName: 'Display: Paper Bag',
    ),
    ProductStock(
      name: 'Metal Water Bottle',
      price: 18.00,
      category: 'Metal',
      availableStock: 98,
      returnQty: 10,
      imagePath: 'assets/images/metal_bottle.jpg',
      readyLabel: 'Ready',
      returnLabel: 'Return',
      stockNote: 'Metal items readiness',
      returnNote: 'Return quantity',
      phase: 'Phase 1',
      displayName: 'Display: Metal Bottle',
    ),
    ProductStock(
      name: 'Recycled Tote Bag',
      price: 8.50,
      category: 'Plastic',
      availableStock: 156,
      returnQty: 14,
      imagePath: 'assets/images/tote_bag.jpg',
      readyLabel: 'Ready',
      returnLabel: 'Return',
      stockNote: 'Plastic Tote Bag Stock',
      returnNote: 'Return quantity',
      phase: 'Phase 1',
      displayName: 'Display: Tote Bag',
    ),
    ProductStock(
      name: 'Eco Notebook',
      price: 6.00,
      category: 'Paper',
      availableStock: 234,
      returnQty: 11,
      imagePath: 'assets/images/eco_notebook.jpg',
      readyLabel: 'Ready',
      returnLabel: 'Return',
      stockNote: 'Eco Notebook storage',
      returnNote: 'Return quantity',
      phase: 'Phase 1',
      displayName: 'Display: Eco Notebook',
    ),
  ];

  // Computed properties for summary
  int get totalItems => products.length;
  int get ready => products.fold(0, (sum, p) => sum + p.availableStock);
  int get onReturn => products.fold(0, (sum, p) => sum + p.returnQty);

  // Editing state and text controllers
  final List<bool> isEditing = [];
  final List<TextEditingController> readyControllers = [];
  final List<TextEditingController> returnControllers = [];

  @override
  void initState() {
    super.initState();
    for (var p in products) {
      isEditing.add(false);
      readyControllers.add(
        TextEditingController(text: p.availableStock.toString()),
      );
      returnControllers.add(
        TextEditingController(text: p.returnQty.toString()),
      );
    }
  }

  // Controllers for form fields
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phaseController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _readyStockController = TextEditingController(
    text: '0',
  );
  final TextEditingController _returnStockController = TextEditingController(
    text: '0',
  );
  final TextEditingController _priceController = TextEditingController(
    text: 'RM 0.00',
  );
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedImagePath; // You can integrate image picker here

  void _showAddProductForm() {
    _nameController.clear();
    _phaseController.clear();
    _typeController.clear();
    _readyStockController.text = '0';
    _returnStockController.text = '0';
    _priceController.text = 'RM 0.00';
    _displayNameController.clear();
    _imageUrlController.clear();
    _descriptionController.clear();
    _selectedImagePath = null;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Enhanced Header with Gradient
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green.shade600, Colors.green.shade800],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Add New Product',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),

                  // Content Container with Sections
                  Container(
                    padding: const EdgeInsets.all(24),
                    color: Colors.grey.shade50,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Basic Information Section
                          _buildSectionHeader(
                            'Basic Information',
                            Icons.info_outline,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Product Name',
                                    hintText: 'e.g., Recycled Plastic Bottle',
                                    prefixIcon: const Icon(Icons.inventory_2),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Please enter product name'
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _phaseController,
                                  decoration: InputDecoration(
                                    labelText: 'Phase',
                                    hintText: 'e.g., Phase 1',
                                    prefixIcon: const Icon(Icons.timeline),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                      ? 'Please enter phase'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _typeController,
                            decoration: InputDecoration(
                              labelText: 'Product Type',
                              hintText: 'e.g., Plastic, Glass, Paper',
                              prefixIcon: const Icon(Icons.category),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter product type'
                                : null,
                          ),
                          const SizedBox(height: 24),

                          // Stock Information Section
                          _buildSectionHeader(
                            'Stock Information',
                            Icons.inventory,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _readyStockController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Ready Stock',
                                    prefixIcon: const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter ready stock';
                                    }
                                    if (int.tryParse(value) == null) {
                                      return 'Must be a number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _returnStockController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Return Stock',
                                    prefixIcon: const Icon(
                                      Icons.refresh,
                                      color: Colors.orange,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter return stock';
                                    }
                                    if (int.tryParse(value) == null) {
                                      return 'Must be a number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Pricing Section
                          _buildSectionHeader('Pricing', Icons.attach_money),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Price (RM)',
                              hintText: '0.00',
                              prefixIcon: const Icon(Icons.currency_exchange),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price';
                              }
                              final cleaned = value.replaceAll(
                                RegExp(r'[^\d.]'),
                                '',
                              );
                              if (double.tryParse(cleaned) == null) {
                                return 'Enter valid price';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          // Display Information Section
                          _buildSectionHeader(
                            'Display Information',
                            Icons.visibility,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _displayNameController,
                            decoration: InputDecoration(
                              labelText: 'Display Name (for Shop)',
                              hintText: 'e.g., Eco Bottle',
                              prefixIcon: const Icon(Icons.store),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Please enter display name'
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This name will be shown to customers in the shop',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Media Section
                          _buildSectionHeader('Product Image', Icons.image),
                          const SizedBox(height: 16),
                          // Enhanced Image Upload
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: InkWell(
                              onTap: () {
                                // Implement image picker logic here
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload,
                                    size: 48,
                                    color: Colors.green.shade400,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Click to select or drag & drop',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // OR Separator
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _imageUrlController,
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                              hintText: 'Paste image URL here',
                              prefixIcon: const Icon(Icons.link),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.url,
                          ),
                          const SizedBox(height: 24),

                          // Description Section
                          _buildSectionHeader('Description', Icons.description),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Description (Optional)',
                              hintText: 'Add product description...',
                              prefixIcon: const Icon(Icons.text_fields),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            maxLines: 4,
                          ),
                          const SizedBox(height: 32),

                          // Enhanced Buttons
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  icon: const Icon(Icons.cancel),
                                  label: const Text('Cancel'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.grey.shade700,
                                    side: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add Product'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade600,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 4,
                                    shadowColor: Colors.green.shade200,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final price =
                                          double.tryParse(
                                            _priceController.text.replaceAll(
                                              RegExp(r'[^\d.]'),
                                              '',
                                            ),
                                          ) ??
                                          0.0;
                                      final readyStock =
                                          int.tryParse(
                                            _readyStockController.text,
                                          ) ??
                                          0;
                                      final returnStock =
                                          int.tryParse(
                                            _returnStockController.text,
                                          ) ??
                                          0;

                                      final newProduct = ProductStock(
                                        name: _nameController.text.trim(),
                                        phase: _phaseController.text.trim(),
                                        category: _typeController.text.trim(),
                                        availableStock: readyStock,
                                        returnQty: returnStock,
                                        price: price,
                                        displayName: _displayNameController.text
                                            .trim(),
                                        imagePath:
                                            _selectedImagePath ??
                                            _imageUrlController.text.trim(),
                                        readyLabel: 'Ready',
                                        returnLabel: 'Return',
                                        stockNote: '',
                                        returnNote: '',
                                      );
                                      setState(() {
                                        products.add(newProduct);
                                        // Update controllers for new product
                                        isEditing.add(false);
                                        readyControllers.add(
                                          TextEditingController(
                                            text: readyStock.toString(),
                                          ),
                                        );
                                        returnControllers.add(
                                          TextEditingController(
                                            text: returnStock.toString(),
                                          ),
                                        );
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade700, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (final controller in readyControllers) {
      controller.dispose();
    }
    for (final controller in returnControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void toggleEditing(int index) {
    setState(() {
      if (isEditing[index]) {
        // Save changes
        int? readyVal = int.tryParse(readyControllers[index].text);
        int? returnVal = int.tryParse(returnControllers[index].text);
        if (readyVal != null) products[index].availableStock = readyVal;
        if (returnVal != null) products[index].returnQty = returnVal;
      } else {
        // When starting editing, ensure text controllers are updated
        readyControllers[index].text = products[index].availableStock
            .toString();
        returnControllers[index].text = products[index].returnQty.toString();
      }
      isEditing[index] = !isEditing[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with title and add button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          decoration: const BoxDecoration(color: Color(0xFF42B642)),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Stock Management',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _showAddProductForm(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text("Add"),
                  ),
                ],
              ),
              // Subtitle
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Manage product inventory & stock levels',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 3),
            ],
          ),
        ),

        const SizedBox(height: 8),

        const SizedBox(height: 12),

        // Summary info row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                // ignore: deprecated_member_use
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _summaryItem(
                  'Total Items',
                  totalItems.toString(),
                  Colors.green,
                ),
                _summaryItem('Ready', ready.toString(), Colors.green.shade700),
                _summaryItem(
                  'Return',
                  onReturn.toString(),
                  Colors.orange.shade700,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length + 1, // +1 for stock labels
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              if (index == 0) {
                // Stock labels card as before
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.green,
                        child: Text(
                          '!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Stock Labels',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade800,
                                  height: 1.3,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Ready',
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ': Products ready for sale\n',
                                  ),
                                  TextSpan(
                                    text: 'Return',
                                    style: TextStyle(
                                      color: Colors.orange.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ': Products for remake/repair',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                final p = products[index - 1];
                return productStockCard(p, index - 1);
              }
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _summaryItem(String label, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
      ],
    );
  }

  Widget productStockCard(ProductStock p, int index) {
    final editing = isEditing[index];
    final readyController = readyControllers[index];
    final returnController = returnControllers[index];

    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      p.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported, size: 40),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'RM ${p.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.phase,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Display: ${p.displayName}',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            editing
                ? editStockSection(readyController, returnController, index)
                : readOnlyStockSection(p, index),
          ],
        ),
      ),
    );
  }

  Widget readOnlyStockSection(ProductStock p, int index) {
    return Row(
      children: [
        // ignore: deprecated_member_use
        _stockQtyBox(
          p.readyLabel,
          p.availableStock,
          // ignore: deprecated_member_use
          Colors.green.withOpacity(0.15),
          Colors.green.shade800,
        ),
        const SizedBox(width: 12),
        // ignore: deprecated_member_use
        _stockQtyBox(
          p.returnLabel,
          p.returnQty,
          // ignore: deprecated_member_use
          Colors.orange.withOpacity(0.15),
          Colors.orange.shade800,
        ),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[100],
            foregroundColor: Colors.green.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(100, 36),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          onPressed: () => toggleEditing(index),
          child: const Text('Update Stock'),
        ),
      ],
    );
  }

  Widget editStockSection(
    TextEditingController readyController,
    TextEditingController returnController,
    int index,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: readyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Ready Stock',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: returnController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Return Stock',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(120, 36),
              ),
              onPressed: () => toggleEditing(index),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.cancel_outlined, color: Colors.redAccent),
              label: const Text('Cancel', style: TextStyle(color: Colors.red)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                minimumSize: const Size(120, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Revert changes
                readyControllers[index].text = products[index].availableStock
                    .toString();
                returnControllers[index].text = products[index].returnQty
                    .toString();
                setState(() => isEditing[index] = false);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _stockQtyBox(String label, int qty, Color bgColor, Color textColor) {
    return Container(
      width: 80,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: deprecated_member_use
          Text(
            label,
            // ignore: deprecated_member_use
            style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 12),
          ),
          const Spacer(),
          Text(
            qty.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductStock {
  final String name;
  final double price;
  final String category;
  int availableStock;
  int returnQty;
  final String imagePath;
  final String readyLabel;
  final String returnLabel;
  final String stockNote;
  final String returnNote;
  final String phase;
  final String displayName;

  ProductStock({
    required this.name,
    required this.price,
    required this.category,
    required this.availableStock,
    required this.returnQty,
    required this.imagePath,
    this.readyLabel = 'Ready',
    this.returnLabel = 'Return',
    this.stockNote = '',
    this.returnNote = '',
    required this.phase,
    required this.displayName,
  });
}
