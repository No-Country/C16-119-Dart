import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';

class SelectCustomer extends StatefulWidget {
  final List<String> options;
  final String? initialValue;
  final Function(String?) onChanged;
  final IconData? icono;

  const SelectCustomer({
    Key? key,
    required this.options,
    this.initialValue,
    required this.onChanged,
    this.icono,
  }) : super(key: key);

  @override
  SelectCustomerState createState() => SelectCustomerState();
}

class SelectCustomerState extends State<SelectCustomer> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: _buildInputDecoration(context),
      child: DropdownButton<String>(
        value: _selectedOption,
        isExpanded: true,
        items: widget.options.map((opcion) {
          final selectOption = opcion == "Seleccione" ? false : true;
          return DropdownMenuItem(
            value: opcion,
            enabled: selectOption,
            child: Text(
              opcion,
              style: selectOption
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.bodySmall,
            ),
          );
        }).toList(),
        onChanged: (valor) {
          setState(() {
            _selectedOption = valor!;
            widget.onChanged(valor);
          });
        },
        style: Theme.of(context).textTheme.bodySmall,
        dropdownColor: Colors.white,
        elevation: 16,
        underline: Container(
          height: 0,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: Icon(
          widget.icono,
          color: colorPrimary,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 6.0,
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
      borderRadius: BorderRadius.circular(55.0),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
