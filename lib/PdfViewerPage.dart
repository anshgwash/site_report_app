import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:sitereportapp/FormText.dart';
import 'package:flutter_share/flutter_share.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  final pdf;
  final shareName;

  const PdfViewerPage({Key key, this.path, this.pdf, this.shareName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('PDF output'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () async {
            //await Printing.sharePdf(bytes: pdf.save(), filename: '$shareName.pdf');
            await FlutterShare.shareFile(title: '$shareName', filePath: path);
          },)
        ],
      ),
      path: path,
    );
  }
}


