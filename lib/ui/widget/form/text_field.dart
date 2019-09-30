import 'package:flutter/material.dart';

class TextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onFieldSubmitted;

  final String hintText;
  final String labelText;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Function(String) validator;
  final TextInputType keyboardType;
  final Widget suffix;
  final bool enabled;

  TextField({
    Key key,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.hintText,
    this.validator,
    this.labelText = '',
    this.suffix,
    this.textInputAction = TextInputAction.none,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.labelText,
          style: Theme.of(context).textTheme.subtitle,
        ),
        SizedBox(height: labelText.isEmpty ? 0 : 8.0),
        TextFormField(
          key: Key('text_form_field_password'),
          enabled: enabled,
          validator: this.validator,
          controller: controller,
          focusNode: focusNode,
          obscureText: this.obscureText,
          keyboardType: this.keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            contentPadding: EdgeInsets.all(14),
            fillColor: Colors.blueGrey.shade50,
            filled: true,
            hintText: hintText,
            suffix: this.suffix,
          ),
          textInputAction: this.textInputAction,
          onFieldSubmitted: this.onFieldSubmitted,
        )
      ],
    );
  }
}
