import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/theme.dart';

class TextAreaCustomer extends StatefulWidget {
  final String? hintText;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final String? text;
  final int multiLine;

  const TextAreaCustomer({
    super.key,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.controller,
    this.text,
    required this.multiLine,
  });

  @override
  State<TextAreaCustomer> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextAreaCustomer> {
  bool isVisiblePass = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.text != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  widget.text!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            : Container(),
        TextFormField(
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          controller: widget.controller,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: _buildInputDecoration(context),
          maxLines: widget.multiLine,
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      hintText: widget.hintText,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
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
      borderRadius: BorderRadius.circular(10.0),
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
