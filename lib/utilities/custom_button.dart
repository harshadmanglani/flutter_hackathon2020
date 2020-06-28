import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  final BuildContext originalContext;
  final String routeName;
  final String text;
  final fontSizeForText;

  CustomButton(
      {this.originalContext,
      this.routeName,
      this.text,
      this.fontSizeForText = 17.0});
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  BuildContext originalContext;
  String text;
  String routeName;
  double fontSizeForText;

  @override
  void initState() {
    super.initState();
    routeName = widget.routeName;
    text = widget.text;
    fontSizeForText = widget.fontSizeForText;
    originalContext = widget.originalContext;
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
              child: Text(text,
                  style: GoogleFonts.ibmPlexMono(
                      textStyle: TextStyle(fontSize: fontSizeForText))),
            ),
          ],
        ));
  }
}
