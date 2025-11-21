import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ManageFeaturedAdsPage extends StatefulWidget {
  const ManageFeaturedAdsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ManageFeaturedAdsPageState createState() => _ManageFeaturedAdsPageState();
}

class _ManageFeaturedAdsPageState extends State<ManageFeaturedAdsPage> {
  final Color greenColor = Color(0xFF42B642);

  bool showNewAdForm = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController badgeController = TextEditingController();

  String adType = 'Secondary Card';
  File? selectedImage;
  String? selectedImagePath;

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    imageUrlController.dispose();
    badgeController.dispose();
    super.dispose();
  }

  void toggleNewAdForm() {
    setState(() {
      showNewAdForm = !showNewAdForm;
    });
  }

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedImage = File(result.files.single.path!);
        selectedImagePath = result.files.single.path!;
        imageUrlController.text = selectedImagePath!;
      });
    }
  }

  void saveAd() {
    // You can add validation and saving logic here
    // ignore: avoid_print
    print('Saving Ad:');
    // ignore: avoid_print
    print('Title: ${titleController.text}');
    // ignore: avoid_print
    print('Subtitle: ${subtitleController.text}');
    // ignore: avoid_print
    print('Image: ${selectedImagePath ?? imageUrlController.text}');
    // ignore: avoid_print
    print('Type: $adType');
    // ignore: avoid_print
    print('Badge: ${badgeController.text}');

    // Clear inputs and hide form after save simulation
    titleController.clear();
    subtitleController.clear();
    imageUrlController.clear();
    badgeController.clear();

    setState(() {
      showNewAdForm = false;
      selectedImage = null;
      selectedImagePath = null;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Advertisement saved!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage Featured Ads',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Edit homepage advertisements',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height:
                MediaQuery.of(context).size.height * 0.1, // Adjustable height
            color: greenColor,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add New Advertisement button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: toggleNewAdForm,
                    icon: Icon(Icons.add, color: greenColor),
                    label: Text(
                      'Add New Advertisement',
                      style: TextStyle(
                        color: greenColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      side: BorderSide(color: greenColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Show form only if toggled
                if (showNewAdForm) _buildNewAdForm(),

                SizedBox(height: 20),

                // The rest of your existing widgets (Main Banners, Secondary Cards)
                Text(
                  'Main Banners',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                _buildMainBannerCard(
                  context,
                  imagePath: 'assets/images/main_banner.JPG',
                  campaignLabel: 'New Campaign',
                  title: 'Join the Green Revolution',
                  subtitle:
                      'Small changes, big impact. Start your eco journey today!',
                  onEdit: () {},
                  onDelete: () {},
                ),

                SizedBox(height: 30),

                Text(
                  'Secondary Cards',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildSecondaryCard(
                        context,
                        'assets/images/secondary_card1.JPG',
                        'Recycle More',
                        'Earn double points!',
                        onEdit: () {},
                        onDelete: () {},
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildSecondaryCard(
                        context,
                        'assets/images/secondary_card2.JPG',
                        'New Arrivals',
                        'Sustainable products',
                        onEdit: () {},
                        onDelete: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewAdForm() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Advertisement',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 12),

          // Title
          Text('Title *', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Enter ad title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 12),

          // Subtitle
          Text('Subtitle *', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          TextField(
            controller: subtitleController,
            decoration: InputDecoration(
              hintText: 'Enter subtitle',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 12),

          // Image Section
          Text('Image *', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: imageUrlController,
                      decoration: InputDecoration(
                        hintText: 'Enter image URL',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: pickImage,
                    icon: Icon(Icons.upload_file, color: greenColor),
                    label: Text('Upload', style: TextStyle(color: greenColor)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      side: BorderSide(color: greenColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                  ),
                ],
              ),
              if (selectedImage != null)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(selectedImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),

          // Type Dropdown
          Text('Type *', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: adType,
            items: ['Secondary Card', 'Main Banner']
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => adType = val);
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
          ),
          SizedBox(height: 12),

          // Badge (Optional)
          Text(
            'Badge (Optional)',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          TextField(
            controller: badgeController,
            decoration: InputDecoration(
              hintText: 'e.g., New Campaign',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
          SizedBox(height: 20),

          // Buttons Save & Cancel row
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.save_outlined, color: Colors.white),
                  label: Text('Save Ad', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: saveAd,
                ),
              ),
              SizedBox(width: 12),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.grey.shade300,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    setState(() {
                      showNewAdForm = false;
                      // Optionally clear inputs here:
                      titleController.clear();
                      subtitleController.clear();
                      imageUrlController.clear();
                      badgeController.clear();
                      adType = 'Secondary Card';
                      selectedImage = null;
                      selectedImagePath = null;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Your existing _buildMainBannerCard and _buildSecondaryCard implementations.
  // For brevity, you can copy those widget methods from your provided code.
  // Just make sure they are available in this class.

  Widget _buildMainBannerCard(
    BuildContext context, {
    required String imagePath,
    required String campaignLabel,
    required String title,
    required String subtitle,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    // Copy your existing main banner card code here
    // Example:
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            // ignore: deprecated_member_use
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    campaignLabel,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Row(
              children: [
                _iconCircleButton(
                  icon: Icons.edit,
                  backgroundColor: Colors.black54,
                  onPressed: onEdit,
                ),
                SizedBox(width: 8),
                _iconCircleButton(
                  icon: Icons.delete_outline,
                  backgroundColor: Colors.redAccent.shade700,
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryCard(
    BuildContext context,
    String imagePath,
    String title,
    String subtitle, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    // Copy your existing secondary card code here
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            // ignore: deprecated_member_use
            Colors.black.withOpacity(0.25),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Row(
              children: [
                _iconCircleButton(
                  icon: Icons.edit,
                  backgroundColor: Colors.black54,
                  onPressed: onEdit,
                ),
                SizedBox(width: 6),
                _iconCircleButton(
                  icon: Icons.delete_outline,
                  backgroundColor: Colors.redAccent.shade700,
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconCircleButton({
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Material(
      shape: CircleBorder(),
      color: backgroundColor,
      child: InkWell(
        customBorder: CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(icon, size: 20, color: Colors.white),
        ),
      ),
    );
  }
}
