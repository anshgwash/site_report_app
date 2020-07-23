import 'dart:io';

import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter/material.dart' as material;

// dependencies
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
// sitereportapp
import 'package:sitereportapp/PdfViewerPage.dart';

PdfMaker(context, value, valueImage) async {
  final Document pdf = Document();
  List<PdfImage> imagesList = new List(10);
  List<PdfImage> elevImages = new List(4);
  PdfImage logoImage = await pdfImageFromImageProvider(pdf: pdf.document, image: widgets.AssetImage('logo.png'));

  for (var i = 1; i < 5; i++) {
    if (!valueImage['elev$i'].isEmpty) {
      print('elevation $i image is not empty');
      String imgFiles = valueImage['elev$i'].toString();
      var parsedImgFile = imgFiles.substring(8, imgFiles.length - 2);
      var pickedImage = PdfImage.file(
        pdf.document,
        bytes: File(parsedImgFile).readAsBytesSync(),
      );
      elevImages[i - 1] = pickedImage;
    }
  }

  for (var i = 1; i < 11; i++) {
    if (!valueImage['img$i'].isEmpty) {
      print('$i image is not empty');
      String imgFiles = valueImage['img$i'].toString();
      var parsedImgFile = imgFiles.substring(8, imgFiles.length - 2);
      var pickedImage = PdfImage.file(
        pdf.document,
        bytes: File(parsedImgFile).readAsBytesSync(),
      );
      imagesList[i - 1] = pickedImage;
    }
  }

  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: CrossAxisAlignment.start,
      build: (context) {
        return <Widget>[
          Header(
            textStyle: TextStyle(fontSize: 23),
            level: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${value['projectName']} - (Site Report #${value['siteReportNo']})',
                      style: TextStyle(fontSize: 25)),
                  Image(logoImage, fit: BoxFit.contain, height: 74.3, width: 60)
                ]),
          ),
          Row(children: [
            Expanded(
              child: (Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Category', 'Value'],
                  <String>['Subject:', '${value['subject']}'],
                  <String>['Arch Dwg No.:', '${value['archDwgNo']}'],
                  <String>[
                    'Structural Dwg No.:',
                    '${value['structuralDwgNo']}'
                  ],
                  <String>['Section Dwg No.:', '${value['sectionDwgNo']}'],
                  <String>['Elevation Dwg No.:', '${value['elevDwgNo']}'],
                ],
              )),
            ),
            Expanded(
              child: (Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Category', 'Value'],
                  <String>['Slab Level:', '${value['slabLvl']}'],
                  <String>['Date:', ' <Today\'s date>'],
                  <String>['Time:', '<Time>'],
                  <String>[
                    'Site Report No.:',
                    '${value['siteReportNo'].toString()}'
                  ],
                  <String>['Site Report By:', '${value['reportBy']}'],
                ],
              )),
            ),
          ]),
          SizedBox(height: 20),
          Header(
            level: 2,
            child:
            Text('Following points were observed during site visit'),
          ),
          SizedBox(height: 20),
          Table.fromTextArray(context: context, data: <List<String>>[
            <String>['Sr No', 'Description of Items', 'Y/N', 'Remarks'],
            <String>['1', 'Drawings on site- Audit', '-', '-'],
            <String>['A', 'No superseded drawings on site/correct drawings being referred', '${yesNo(text: 'dwgUpToDate', value: value)}'],
            <String>[''],
            <String>['2', 'Site Development', '-', '-'],
            <String>['A', 'North of site as per demarcation', '${yesNo(text: 'northAsPerDwg', value: value)}'],
            <String>['B', 'UG Tanks top slab level marking', '${yesNo(text: 'dwgUpToDate', value: value)}', '${value['ugTanks-Remark']}'],
            <String>['C', 'Site levels marking w.r.t. road level', '${yesNo(text: 'roadLvl', value: value)}', '${value['roadLvl-Remark']}'],
            <String>[''],
            <String>['3', 'Setting out & Centre line checking', '-', '-'],
            <String>['A', 'Open Offset Dimension', '${yesNo(text: 'openOffsetDim', value: value)}', '${value['openOffsetDim-remark']}'],
            <String>['B', 'Column marking as per centre line', '${yesNo(text: 'columnMarkPcl', value: value)}', '${value['columnMarkPcl-Remark']}'],
            <String>[''],
            <String>['4', 'Shuttering Check', '-', '-'],
            <String>['A', 'Overall Checking - Supporting lvl, no gaps etc.', '${yesNo(text: 'shutteringCheck', value: value)}', '${value['shutteringCheck-remark']}'],
            <String>[''],
            <String>['5', 'Slab Checking', '-', '-'],
            <String>['A', 'Level Of Slab', '${yesNo(text: 'lvlOfSlab', value: value)}'],
            <String>['B', 'Cutout for Lift Dimension', '${yesNo(text: 'cutoutLift', value: value)}'],
            <String>['C', 'Cutout for Plumbing Shaft', '${yesNo(text: 'cutOutPlumb', value: value)}'],
            <String>['D', 'Cutout for Electrical', '${yesNo(text: 'cutOutElectrical', value: value)}'],
            <String>['E', 'Flower Bed Sunk', '${yesNo(text: 'flowerBedSunk', value: value)}'],
            <String>['F', 'Toilet Sunk', '${yesNo(text: 'toiletSunk', value: value)}'],
            <String>['G', 'Terrace/Balcony Sunk', '${yesNo(text: 'balconySunk', value: value)}'],
            <String>['H', 'Terrace Projection', '${yesNo(text: 'terraceProj', value: value)}'],
            <String>['I', 'Basements checking', '${yesNo(text: 'basement', value: value)}'],
            <String>['J', 'Size of Column', '${yesNo(text: 'columnSize', value: value)}'],
            <String>['K', 'Alignment of Column', '${yesNo(text: 'columnAlign', value: value)}'],
            <String>['L', 'Reduction of Column', '${yesNo(text: 'columnRed', value: value)}'],
            <String>['M', 'Beam - Size and Location', '${yesNo(text: 'beamSizeLoc', value: value)}'],
            <String>['N', 'Alignment of Beam Internal', '${yesNo(text: 'beamAlignInt', value: value)}'],
            <String>['O', 'Alignment of Beam External', '${yesNo(text: 'beamAlignExt', value: value)}'],
            <String>['P', 'Alignment of Beam wrt slab lvl', '${yesNo(text: 'beamAlignSlab', value: value)}'],
            <String>['Q', 'Electrical Sleeves', '${yesNo(text: 'electricalSleeves', value: value)}'],
            <String>['R', 'Plumbing Sleeves', '${yesNo(text: 'plumbingSleeves', value: value)}'],
            <String>['S', 'Hook Fan Location', '${yesNo(text: 'hookFanLoc', value: value)}'],
            <String>['T', 'Alignment of Chajja Protection wrt slab lvl', '${yesNo(text: 'chajjaAlign', value: value)}'],
            <String>['U', 'Chajja Protection - Size and Location', '${yesNo(text: 'chajjaProj', value: value)}'],
            <String>['V', 'Slab Projection - any other', '${yesNo(text: 'slabProjOther', value: value)}'],
            <String>[''],
            <String>['6', 'Staircase', '-', '-'],
            <String>['A', 'Width of Staircase', '${yesNo(text: 'widthStaircase', value: value)}'],
            <String>['B', 'Dimension of Risers, Treads', '${yesNo(text: 'dimRisers', value: value)}'],
            <String>['C', 'Mid Landing Level of Staircase', '${yesNo(text: 'midLandingLvl', value: value)}'],
            <String>['D', 'Hand Railing Details', '${yesNo(text: 'handRailingDet', value: value)}'],
            <String>[''],
            <String>['7', 'Block Work', '-', '-'],
            <String>['A', 'Line & Level of Brickwork', '${yesNo(text: 'lineOfBrickWork', value: value)}'],
            <String>[''],
            <String>['8', 'Block Work', '-', '-'],
            <String>['A', 'South side', '${yesNo(text: 'southSide', value: value)}'],
            <String>['B', 'North side', '${yesNo(text: 'northSide', value: value)}'],
            <String>['C', 'East side', '${yesNo(text: 'eastSide', value: value)}'],
            <String>['D', 'West side', '${yesNo(text: 'westSide', value: value)}'],
          ],
            columnWidths: {0: FractionColumnWidth(0.05), 1: FractionColumnWidth(0.5), 2: FractionColumnWidth(0.05), 3: FractionColumnWidth(0.4)},
          ),
          SizedBox(height: 20),
          elevPlace(0, elevImages, valueImage, 'Front'),
          elevPlace(1, elevImages, valueImage, 'Rear'),
          elevPlace(2, elevImages, valueImage, 'Side 1'),
          elevPlace(3, elevImages, valueImage, 'Side 2'),
        ];
      }
    ),
  );

  pdf.addPage(
    MultiPage(
        pageFormat: PdfPageFormat.a4,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        build: (context) {
          return <Widget> [
            /*
            Table(
              //border: TableBorder(left: true, right: true, top: true, bottom: true, horizontalInside: true, verticalInside: true),
                children: [
                  TableRow(
                    children: [
                      imagePlace(0, imagesList, valueImage),
                      imagePlace(1, imagesList, valueImage),
                    ]
                  ),
                  TableRow(
                      children: [
                        imagePlace(2, imagesList, valueImage),
                        imagePlace(3, imagesList, valueImage),
                      ]
                  ),
                  TableRow(
                      children: [
                        imagePlace(4, imagesList, valueImage),
                        imagePlace(5, imagesList, valueImage),
                      ]
                  ),
                  TableRow(
                      children: [
                        imagePlace(6, imagesList, valueImage),
                        imagePlace(7, imagesList, valueImage),
                      ]
                  ),
                  TableRow(
                      children: [
                        imagePlace(8, imagesList, valueImage),
                        imagePlace(9, imagesList, valueImage),
                      ]
                  ),
                ]
                ),

             */
            imagePlace(0, imagesList, valueImage),
            imagePlace(1, imagesList, valueImage),
            imagePlace(2, imagesList, valueImage),
            imagePlace(3, imagesList, valueImage),
            imagePlace(4, imagesList, valueImage),
            imagePlace(5, imagesList, valueImage),
            imagePlace(6, imagesList, valueImage),
            imagePlace(7, imagesList, valueImage),
            imagePlace(8, imagesList, valueImage),
            imagePlace(9, imagesList, valueImage),
          ];
        }
    ),
  );

  String shareName = '${value['projectName']}_report${value['siteReportNo'].toString()}';

  final String dir = (await getApplicationDocumentsDirectory()).path;
  print(dir);
  final String path = '$dir/$shareName.pdf';
  final File file = File(path);
  await file.writeAsBytes(pdf.save());
  /*
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());

   */


  material.Navigator.of(context).push(
      material.MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path, pdf: pdf, shareName: shareName),
      )
  );


}

// ignore: missing_return
String yesNo({text, value}) {
  if (value[text] == 'as per dwg') {
    return 'Yes';
  }
  if (value[text] == 'not a.p.d.') {
    return 'No';
  }
}

Widget imagePlace(i, imagesList, valueImage) {
  if (imagesList[i] != null) {
    if(valueImage['img${i+1}-Remark'] != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Image(imagesList[i], fit: BoxFit.contain, height: 250),
          SizedBox(height: 2),
          Text('Image ${i+1}: ${valueImage['img${i+1}-Remark']}'),
          SizedBox(height: 2),
        ],
      );
    } else {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Image(imagesList[i], fit: BoxFit.contain, height: 250),
            SizedBox(height: 2),
            Text('Image${i+1}'),
          ]
      );

    }
  } else {
    return SizedBox(height: 0.01);
  }
}

Widget elevPlace(i, elevImages, valueImage, text) {
  if (elevImages[i] != null) {
    if(valueImage['elev${i+1}-Remark'] != '') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Expanded(child: Image(elevImages[i], height: 650, fit: BoxFit.contain), flex: 2),
          Image(elevImages[i], height: 600, fit: BoxFit.contain),
          SizedBox(height: 2),
          Text('$text: ${valueImage['elev${i+1}-Remark']}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
      ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Expanded(child: Image(elevImages[i], height: 650, fit: BoxFit.contain), flex: 2),
            Image(elevImages[i], height: 600, fit: BoxFit.contain),
            SizedBox(height: 2),
            Text('$text', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
          ]
      );

    }
  } else {
    return SizedBox(height: 0.01);
  }
}
