import 'package:flutter/material.dart';

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductCatalogPageState createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  final TextEditingController _pdfUrlController = TextEditingController();
  String? _currentCatalogUrl;

  void _uploadCatalog() {
    final url = _pdfUrlController.text.trim();
    if (url.isNotEmpty && Uri.tryParse(url)?.hasAbsolutePath == true && url.endsWith('.pdf')) {
      setState(() {
        _currentCatalogUrl = url;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catalog saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid publicly accessible PDF URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Catalog'),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.picture_as_pdf, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Product Catalog',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // About Product Catalog info box
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Upload a PDF file containing your product catalog. Customers will be able to view this catalog by clicking the floating catalog button on the product page.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Current Catalog Section
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Catalog',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Center(
                      child: _currentCatalogUrl == null
                          ? Column(
                              children: [
                                Icon(Icons.picture_as_pdf_outlined, size: 60, color: Colors.grey),
                                SizedBox(height: 8),
                                Text(
                                  'No catalog uploaded',
                                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Add a PDF file below',
                                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Icon(Icons.picture_as_pdf, size: 60, color: Colors.green),
                                SizedBox(height: 8),
                                Text(
                                  'Catalog uploaded',
                                  style: TextStyle(color: Colors.green[700], fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  _currentCatalogUrl!,
                                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Upload Catalog Section
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload Catalog',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'PDF File URL:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _pdfUrlController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'https://example.com/catalog.pdf',
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Optionally implement file picker to upload file
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                          ),
                          child: Icon(Icons.upload_file),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Enter the URL of your PDF file or click upload to browse',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 12),

                    // Warning Box in Orange
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Note: make sure your PDF file is publicly accessible. The URL should end with .pdf extension and allow embedding in iframes.',
                        style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Save Catalog Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _uploadCatalog,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                        child: Text('Save Catalog', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Tips Section
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tips for Best Results',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    _buildTip('Keep your PDF file size under 5MB for faster loading'),
                    _buildTip('Use high-quality images for product photos'),
                    _buildTip('Include clear product descriptions and prices'),
                    _buildTip('Update regularly with new products and collections'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, size: 18, color: Colors.green),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
      ],
    );
  }

  @override
  void dispose() {
    _pdfUrlController.dispose();
    super.dispose();
  }
}