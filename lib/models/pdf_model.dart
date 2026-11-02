import 'package:almcq/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfname;
  final String? title;

  const PdfViewerScreen({
    super.key,
    required this.pdfname,
    this.title,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

// Backwards compatibility alias
// ignore: camel_case_types
typedef PDF_model = PdfViewerScreen;

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final displayTitle = widget.title ?? 'A/L ICT Document';

    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        title: Text(displayTitle),
        actions: [
          IconButton(
            tooltip: 'Zoom In',
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              _pdfViewerController.zoomLevel =
                  (_pdfViewerController.zoomLevel + 0.25).clamp(1.0, 3.0);
            },
          ),
          IconButton(
            tooltip: 'Zoom Out',
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              _pdfViewerController.zoomLevel =
                  (_pdfViewerController.zoomLevel - 0.25).clamp(1.0, 3.0);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.asset(
            'assets/${widget.pdfname}.pdf',
            controller: _pdfViewerController,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() => _isLoading = false);
            },
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Document preview unavailable: ${details.description}'),
                  backgroundColor: AppTheme.error,
                ),
              );
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
