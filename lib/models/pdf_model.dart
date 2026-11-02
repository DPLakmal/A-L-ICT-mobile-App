import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore_for_file: camel_case_types

class PDF_model extends StatelessWidget {
  const PDF_model({Key? key, required this.pdfname}) : super(key: key);
  final String pdfname;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SfPdfViewer.asset('assets/$pdfname.pdf', password: 'syncfusion'),
      ),
    );
  }
}
