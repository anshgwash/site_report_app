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
                  Header(text: 'Elevation images',),
                  image(att: 'elev1', label: 'Front',),
                  image(att: 'elev2', label: 'Rear',),
                  image(att: 'elev3', label: 'Side 1',),
                  image(att: 'elev4', label: 'Side 2',),
                  Header(text: 'Other images'),
                  image(att: 'img1', label: 'Image 1',),
                  image(att: 'img2', label: 'Image 2',),
                  image(att: 'img3', label: 'Image 3',),
                  image(att: 'img4', label: 'Image 4',),
                  image(att: 'img5', label: 'Image 5',),
                  image(att: 'img6', label: 'Image 6',),
                  image(att: 'img7', label: 'Image 7',),
                  image(att: 'img8', label: 'Image 8',),
                  image(att: 'img9', label: 'Image 9',),
                  image(att: 'img10', label: 'Image 10',),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[
        Expanded(
          flex: 4,
          child: FormBuilderImagePicker(
            attribute: '$att',
            decoration:
            InputDecoration(labelText: '$label', border: InputBorder.none),
            iconColor: Colors.grey[500],
            imageMargin: EdgeInsets.all(5),
            maxImages: 1,
            imageQuality: 50,

          ),
        ),
        Expanded(
          flex: 5,
          child: FormBuilderTextField(
            attribute: '$att-Remark',
            decoration: const InputDecoration(
              //enabled: true,
              //contentPadding: EdgeInsets.only(top: 0),
              labelText: 'Description:',
            ),
            maxLengthEnforced: true,
            maxLength: 60,
          ),
        ),
      ],
    );
  }
}
