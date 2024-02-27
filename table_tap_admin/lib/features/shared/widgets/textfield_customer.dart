import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/theme.dart';

class TextFieldCustom extends StatefulWidget {
  final String? hintText;
  final IconData? icono;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final FormFieldValidator? validator;
  final TextEditingController? controller;
  final String? text;

  const TextFieldCustom({
    super.key,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.controller,
    this.icono,
    this.text,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
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
          obscureText: widget.obscureText! && isVisiblePass,
          validator: widget.validator,
          controller: widget.controller,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: _buildInputDecoration(context),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      prefixIcon: widget.icono != null
          ? Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                widget.icono,
                color: colorPrimary,
              ),
            )
          : null,
      suffixIcon: widget.obscureText!
          ? Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: handleChangeVisibilityPass,
                icon: Icon(
                  isVisiblePass ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            )
          : null,
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
      borderRadius: BorderRadius.circular(50.0),
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
