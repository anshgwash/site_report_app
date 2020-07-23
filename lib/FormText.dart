// flutter
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:printing/printing.dart';
import 'package:sitereportapp/FormImages.dart';
import 'package:sitereportapp/PdfMaker.dart';

import 'PdfViewerPage.dart';

final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

class FormText extends StatefulWidget {
  @override
  _FormTextState createState() => _FormTextState();
}

class _FormTextState extends State<FormText> with AutomaticKeepAliveClientMixin {
  // needed for AutomaticKeepAliveClientMixin
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        children: <Widget>[
          FormBuilder(
            key: formKey,
            child: Column(

              children: <Widget>[
                Header(text: 'Section 1: Site Report info'),
                FormBuilderTextField(
                  attribute: 'projectName',
                  decoration:
                  const InputDecoration(labelText: 'Project Name'),
                  maxLines: 1,
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'This field is required'),
                    FormBuilderValidators.maxLength(100,
                        errorText:
                        'This field can\'t be more than 100 characters'),
                  ],
                ),
                FormBuilderChoiceChip(
                  attribute: 'subject',
                  decoration: const InputDecoration(
                    labelText: 'Type of check',
                  ),
                  options: [
                    FormBuilderFieldOption(
                        value: 'Centerline', child: Text('Centerline')),
                    FormBuilderFieldOption(
                        value: 'Plinth', child: Text('Plinth')),
                    FormBuilderFieldOption(
                        value: 'Slab', child: Text('Slab')),
                    FormBuilderFieldOption(
                        value: 'Brick work', child: Text('Brick work')),
                  ],
                ),
                FormBuilderTextField(
                  attribute: 'archDwgNo',
                  decoration: const InputDecoration(
                      labelText: 'Architectural Dwg No.'),
                  maxLines: 1,
                  /*
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'This field is required'),
                    FormBuilderValidators.maxLength(40,
                        errorText:
                            'This field can\'t be more than 40 characters'),
                  ],
                   */
                ),
                FormBuilderTextField(
                  attribute: 'structuralDwgNo',
                  decoration:
                  const InputDecoration(labelText: 'Structural Dwg No.'),
                  maxLines: 1,
                  /*
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'This field is required'),
                    FormBuilderValidators.maxLength(40,
                        errorText:
                            'This field can\'t be more than 40 characters'),
                  ],

                   */
                ),
                FormBuilderTextField(
                  attribute: 'sectionDwgNo',
                  decoration:
                  const InputDecoration(labelText: 'Section Dwg No.'),
                  maxLines: 1,
                  /*
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'This field is required'),
                    FormBuilderValidators.maxLength(40,
                        errorText:
                            'This field can\'t be more than 40 characters'),
                  ],

                   */
                ),
                FormBuilderTextField(
                  attribute: 'elevDwgNo',
                  decoration:
                  const InputDecoration(labelText: 'Elevation Dwg No.'),
                  maxLines: 1,
                  /*
                  validators: [
                    FormBuilderValidators.required(
                        errorText: 'This field is required'),
                    FormBuilderValidators.maxLength(40,
                        errorText:
                            'This field can\'t be more than 40 characters'),
                  ],

                   */
                ),
                FormBuilderTextField(
                  attribute: 'slabLvl',
                  decoration: const InputDecoration(
                    labelText: 'Slab level (leave empty if n/a)',
                  ),
                  valueTransformer: (text) {
                    return text == null ? null : num.tryParse(text);
                  },
                  /*
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    // FormBuilderValidators.max(70),
                    FormBuilderValidators.min(1, errorText: 'Minimum is 1'),
                    FormBuilderValidators.max(100,
                        errorText: 'Maximum is 100'),
                  ],

                   */
                  keyboardType: TextInputType.number,
                ),
                FormBuilderTextField(
                  attribute: 'siteReportNo',
                  decoration: const InputDecoration(
                    labelText: 'Site Report no.',
                  ),
                  valueTransformer: (text) {
                    return text == null ? null : num.tryParse(text);
                  },
                  /*
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    // FormBuilderValidators.max(70),
                    FormBuilderValidators.min(1, errorText: 'Minimum is 1'),
                    FormBuilderValidators.max(100,
                        errorText: 'Maximum is 100'),
                  ],

                   */
                  keyboardType: TextInputType.number,
                ),
                FormBuilderChoiceChip(
                  attribute: 'reportBy',
                  decoration: const InputDecoration(
                    labelText: 'Report by',
                  ),
                  options: [
                    FormBuilderFieldOption(
                        value: 'Ansh Gwash', child: Text('Ansh G')),
                    FormBuilderFieldOption(
                        value: 'Sundeep Gwash', child: Text('Sundeep G.')),
                    FormBuilderFieldOption(
                        value: 'Vishal Shah', child: Text('Vishal S.')),
                  ],
                ),
                SizedBox(height: 50),
                Header(text: 'Section 2 - Attendance list'),
                SizedBox(height: 50),
                Header(text: 'Section 3 - Checklist'),
                SizedBox(height: 15),
                SmallerHeader(text: '1 - Drawing on site audit'),
                YesNo(
                  attribute: 'dwgUpToDate',
                  label: 'Correct and latest drawing being referred',
                  remark: false,
                ),
                SizedBox(height: 15),
                SmallerHeader(text: '2 - Site Development'),
                YesNo(
                  attribute: 'northAsPerDwg',
                  label: 'North of site as per demarcation',
                  remark: false,
                ),
                YesNo(
                  attribute: 'ugTanks',
                  label: 'UG tanks top slab level marking',
                  remark: true,
                ),
                YesNo(
                  attribute: 'roadLvl',
                  label: 'Site levels marking w.r.t road level',
                  remark: true,
                ),
                SizedBox(height: 15),
                SmallerHeader(text: '3 - Setting out & center line checking'),
                YesNo(
                  attribute: 'openOffsetDim',
                  label: 'Open offset dimension',
                  remark: true,
                ),
                YesNo(
                  attribute: 'columnMarkPcl',
                  label: 'Column marking as per centre line',
                  remark: true,
                ),
                SizedBox(height: 15),
                SmallerHeader(text: '4 - Shuttering Check'),
                YesNo(
                  attribute: 'shutteringCheck',
                  label: 'Overall checking - supporting level, no gaps etc',
                  remark: true,
                ),
                SizedBox(height: 15),
                SmallerHeader(text: '5 - Slab checking'),
                FormBuilderTextField(
                  attribute: 'lvlOfSlab',
                  decoration: const InputDecoration(
                    labelText: 'Level of slab',
                  ),
                  valueTransformer: (text) {
                    return text == null ? null : num.tryParse(text);
                  },
                  /*


                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                    // FormBuilderValidators.max(70),
                    FormBuilderValidators.min(1, errorText: 'Minimum is 1'),
                    FormBuilderValidators.max(100,
                        errorText: 'Maximum is 100'),
                  ],

                   */
                  keyboardType: TextInputType.number,
                ),
                YesNo(
                  attribute: 'cutOutLift',
                  label: 'Cut out for lift dimension',
                  remark: false,
                ),
                YesNo(
                  attribute: 'cutOutPlumb',
                  label: 'Cut out for plumbing shaft',
                  remark: false,
                ),
                YesNo(
                  attribute: 'cutOutElectrical',
                  label: 'Cut out for electrical',
                  remark: false,
                ),
                YesNo(
                  attribute: 'flowerBedSunk',
                  label: 'Flower bed sunk',
                  remark: false,
                ),
                YesNo(
                  attribute: 'toiletSunk',
                  label: 'Toilet Sunk',
                  remark: false,
                ),
                YesNo(
                  attribute: 'balconySunk',
                  label: 'Terrace/balcony sunk',
                  remark: false,
                ),
                YesNo(
                  attribute: 'terraceProj',
                  label: 'Terrace projection',
                  remark: false,
                ),
                YesNo(
                  attribute: 'basement',
                  label: 'Basement checking',
                  remark: false,
                ),
                YesNo(
                  attribute: 'columnSize',
                  label: 'Size of column',
                  remark: false,
                ),
                YesNo(
                  attribute: 'columnAlign',
                  label: 'Alignment of column',
                  remark: false,
                ),
                YesNo(
                  attribute: 'columnRed',
                  label: 'Reduction of column',
                  remark: false,
                ),
                YesNo(
                  attribute: 'beamSizeLoc',
                  label: 'Beam size and location',
                  remark: false,
                ),
                YesNo(
                  attribute: 'beamAlignInt',
                  label: 'Alignment of beam internally',
                  remark: false,
                ),
                YesNo(
                  attribute: 'beamAlignExt',
                  label: 'Alignment of beam externally',
                  remark: false,
                ),
                YesNo(
                  attribute: 'beamAlignSlab',
                  label: 'Alignment of beam w.r.t. slab level',
                  remark: false,
                ),
                YesNo(
                  attribute: 'electricalSleeves',
                  label: 'Electrical sleeves',
                  remark: false,
                ),
                YesNo(
                  attribute: 'plumbingSleeves',
                  label: 'Plumbing sleeves',
                  remark: false,
                ),
                YesNo(
                  attribute: 'hookFanLoc',
                  label: 'Hook fan location',
                  remark: false,
                ),
                YesNo(
                  attribute: 'chajjaAlign',
                  label: 'Alignment of chajja projection wrt slab level',
                  remark: false,
                ),
                YesNo(
                  attribute: 'chajjaProj',
                  label: 'Chajja projection - size and location',
                  remark: false,
                ),
                YesNo(
                  attribute: 'slabProjOther',
                  label: 'Slab Projection - any other',
                  remark: false,
                ),
                SizedBox(height: 20),
                SmallerHeader(text: '6 - Staircase'),
                YesNo(
                  attribute: 'widthStaircase',
                  label: 'Width of Staircase',
                  remark: false,
                ),
                YesNo(
                  attribute: 'dimRisers',
                  label: 'Dimensions of risers/treads',
                  remark: false,
                ),
                YesNo(
                  attribute: 'midLandingLvl',
                  label: 'Mid Landing Level of Staircase',
                  remark: false,
                ),
                YesNo(
                  attribute: 'handRailingDet',
                  label: 'Hand Railing Details',
                  remark: false,
                ),
                SizedBox(height: 20),
                SmallerHeader(text: '7 - Block work'),
                YesNo(
                  attribute: 'lineOfBrickWork',
                  label: 'Line and Level of Brick Work',
                  remark: false,
                ),
                SizedBox(height: 20),
                SmallerHeader(text: '8 - Architectural Elevation Features'),
                YesNo(
                  attribute: 'southSide',
                  label: 'South side',
                  remark: false,
                ),
                YesNo(
                  attribute: 'northSide',
                  label: 'North side',
                  remark: false,
                ),
                YesNo(
                  attribute: 'eastSide',
                  label: 'East side',
                  remark: false,
                ),
                YesNo(
                  attribute: 'westSide',
                  label: 'West side',
                  remark: false,
                ),
                /*
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        color: Theme.of(context).accentColor,
                        elevation: 0,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (formKey.currentState.saveAndValidate() && formKey2.currentState.saveAndValidate()) {
                            var value = formKey.currentState.value;
                            // new
                            var imageValue = formKey2.currentState.value;
                            // new end
                            print(value);
                            print(imageValue);
                            writeOnPdf(value, imageValue);
                            await savePdf();
                            Directory documentDirectory =
                            await getApplicationDocumentsDirectory();
                            String documentPath = documentDirectory.path;
                            String fullPath = '$documentPath/example.pdf';

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        reportPdf(path: fullPath, pdf: pdf)));
                          } else {
                            print(formKey.currentState.value);
                            print('validation failed');
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: MaterialButton(
                        elevation: 0,
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          formKey.currentState.reset();
                          formKey2.currentState.reset();
                        },
                      ),
                    ),
                  ],
                ),

                 */
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        backgroundColor: Colors.teal,
        onPressed: () async {
          if (formKey.currentState.saveAndValidate() && formKey2.currentState.saveAndValidate()) {
            var value = formKey.currentState.value;
            var valueImage = formKey2.currentState.value;
            // 1. check if all entries are valid
            PdfMaker(context, value, valueImage);
            // 2. if yes, call PdfMaker and pass in context, value, formKey2
            // 3. if no, print invalid
          } else {
            print('Invalid');
          }
        },
      ),
      // TODO add FOB for reset
    );
  }
}

class Header extends StatelessWidget {
  final String text;

  Header({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SmallerHeader extends StatelessWidget {
  final String text;

  SmallerHeader({this.text});

  @override
  Widget build(BuildContext context) {
    return Text('$text',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ));
  }
}

class YesNo extends StatelessWidget {
  final String attribute;
  final String label;
  bool remark;

  YesNo({this.attribute, this.label, this.remark});

  @override
  Widget build(BuildContext context) {
    if (remark == true) {
      return Column(children: <Widget>[
        FormBuilderRadioGroup(
          contentPadding: EdgeInsets.zero,
          attribute: attribute,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: label.toString(),
            labelStyle: TextStyle(
              fontSize: 18,
            ),
          ),
          options: [
            FormBuilderFieldOption(
              value: 'as per dwg',
            ),
            FormBuilderFieldOption(
              value: 'not a.p.d.',
            ),
          ],
        ),
        FormBuilderTextField(
          attribute: '$attribute-Remark',
          decoration: const InputDecoration(
            enabled: true,
            contentPadding: EdgeInsets.only(top: 0),
            labelText: 'remarks...',
          ),
          maxLengthEnforced: true,
          maxLength: 100,
        )
      ]);
    }
    if (remark == false) {
      return FormBuilderRadioGroup(
        attribute: attribute,
        decoration: InputDecoration(
            labelText: label.toString(),
            labelStyle: TextStyle(
              fontSize: 18,
            )),
        options: [
          FormBuilderFieldOption(
            value: 'as per dwg',
          ),
          FormBuilderFieldOption(
            value: 'not a.p.d.',
          ),
        ],
      );
    }
  }
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