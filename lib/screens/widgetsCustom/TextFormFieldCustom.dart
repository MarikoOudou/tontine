import 'package:flutter/material.dart';
import 'package:tontino/services/Colors.dart';

class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom(
      {Key? key, required this.label, required this.textValidate})
      : super(key: key);
  final String label;
  final String textValidate;

  @override
  _TextFormFieldCustomState createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.textValidate}';
          }
          return null;
        },
        autofocus: false,
        textAlign: TextAlign.right,
        style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 18,
            color: ColorTheme.primaryColorWhite,
            fontWeight: FontWeight.w700),
        decoration: InputDecoration(
            floatingLabelStyle: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18,
                color: ColorTheme.primaryColorWhite,
                fontWeight: FontWeight.w700),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            isCollapsed: false,
            isDense: false,
            hintStyle: TextStyle(color: ColorTheme.primaryColorWhite),
            suffixIconColor: ColorTheme.primaryColorWhite,
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  width: 2,
                  color: ColorTheme.primaryColorWhite,
                )),
            contentPadding: EdgeInsets.all(10),
            filled: false,
            fillColor: ColorTheme.primaryColorWhite,
            focusColor: ColorTheme.primaryColorWhite,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(
                width: 2,
                color: ColorTheme.primaryColorWhite,
              ),
            ),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: ColorTheme.primaryColorWhite),
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            alignLabelWithHint: true,
            label: Text("${widget.label}"),
            labelStyle: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18,
                color: ColorTheme.primaryColorWhite,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
