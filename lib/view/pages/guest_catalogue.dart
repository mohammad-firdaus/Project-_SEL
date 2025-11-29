import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GuestCatalogue extends StatelessWidget {
  const GuestCatalogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SfPdfViewer.asset(
          'assets/catalogue/WasteToWealthCatalogue.pdf',
          canShowScrollHead: true,
          canShowScrollStatus: true,
          enableDoubleTapZooming: true,
          enableTextSelection: true,
        ),
      ),
    );
  }
}
