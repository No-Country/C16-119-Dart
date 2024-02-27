import 'package:flutter/material.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';

class FormCategory extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController;
  final TextEditingController statusController;

  FormCategory({
    Key? key,
    required this.nameController,
    required this.statusController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Text(
                        'Nueva categoria',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text('Categoria'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldCustom(
                        hintText: 'Ingrese nombre',
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                );
              },
            );
          },
          child: Text('Abrir Formulario'),
        ),
      ),
    );
  }
}
