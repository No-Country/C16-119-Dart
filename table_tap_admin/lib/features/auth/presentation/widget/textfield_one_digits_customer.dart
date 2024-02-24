import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';

class TextFieldOneDigitsCustom extends StatefulWidget {
  final TextEditingController? controller;

  const TextFieldOneDigitsCustom({
    super.key,
    this.controller,
  });

  @override
  State<TextFieldOneDigitsCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldOneDigitsCustom> {
  bool isVisiblePass = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: _buildInputDecoration(context).copyWith(
        counterText: ''
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      enabledBorder: _buildOutlineInputBorder(context),
      focusedBorder: _buildOutlineInputBorder(context).copyWith(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
      errorBorder: _buildOutlineInputBorder(context).copyWith(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
      ),
      focusedErrorBorder: _buildOutlineInputBorder(context).copyWith(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
          width: 2.0,
        ),
      ),
      focusColor: colorPrimary,
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }

  void handleChangeVisibilityPass() {
    setState(() {
      isVisiblePass = !isVisiblePass;
    });
  }
}
