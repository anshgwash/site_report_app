// flutter
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:printing/printing.dart';
import 'package:sitereportapp/FormText.dart';

final GlobalKey<FormBuilderState> formKey2 = GlobalKey<FormBuilderState>();

class FormImages extends StatefulWidget {
  @override
  _FormImagesState createState() => _FormImagesState();
}

class _FormImagesState extends State<FormImages>
    with AutomaticKeepAliveClientMixin {
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
              key: formKey2,
              child: Column(
                children: <Widget>[
                  Header(text: 'Add Images to Report (max 8)',),
                  image(att: 'image1', label: 'Image 1',),
                  image(att: 'image2', label: 'Image 2',),
                  image(att: 'image3', label: 'Image 3',),
                  image(att: 'image4', label: 'Image 4',),
                  image(att: 'image5', label: 'Image 5',),
                  image(att: 'image6', label: 'Image 6',),
                  image(att: 'image7', label: 'Image 7',),
                  image(att: 'image8', label: 'Image 8',),
                ],
              ),
            ),
          ]),
    );
  }
}

class image extends StatelessWidget {
  final String att;
  final String label;

  image({this.att, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FormBuilderImagePicker(
          attribute: '$att',
          decoration:
              InputDecoration(labelText: '$label', border: InputBorder.none),
          iconColor: Colors.grey[500],
          imageMargin: EdgeInsets.all(5),
          maxImages: 1,
          imageQuality: 80,
        ),
        FormBuilderTextField(
          attribute: '$att-Remark',
          decoration: const InputDecoration(
            enabled: true,
            contentPadding: EdgeInsets.only(top: 0),
            labelText: 'remarks...',
          ),
          maxLengthEnforced: true,
          maxLength: 100,
        ),
      ],
    );
  }
}
