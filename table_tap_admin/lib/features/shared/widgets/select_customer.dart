import 'package:flutter/material.dart';
import 'package:table_tap_admin/config/config.dart';
import 'package:table_tap_admin/features/product/domain/models/category_model.dart';

class SelectCustomer extends StatefulWidget {
  final List<CategoryModel> options;
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
    if (widget.initialValue!.isNotEmpty) {
      _selectedOption = widget.initialValue;
    } else {
      _selectedOption = null;
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: _buildInputDecoration(context),
      child: DropdownButton<CategoryModel>(
        value: _selectedOption != null
            ? widget.options
                .firstWhere((element) => element.name == _selectedOption)
            : null,
        isExpanded: true,
        items: [
          DropdownMenuItem<CategoryModel>(
            value: null,
            child: Text(
              'seleccione',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          ...widget.options.map((opcion) {
            final selectOption = opcion == "" ? false : true;
            return DropdownMenuItem(
              value: opcion,
              enabled: selectOption,
              child: Row(
                children: [
                  Text(
                    opcion.name,
                    style: selectOption
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 20),
                  _selectedOption == opcion.name
                      ? const Icon(Icons.check)
                      : Container()
                ],
              ),
            );
          }),
        ],
        onChanged: (category) {
          setState(() {
            _selectedOption = category!.name;
            widget.onChanged(category.name);
            if (category != null) {
              print(category.name);
            }
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
