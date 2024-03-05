import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogError.dart';
import 'package:table_tap_admin/features/shared/widgets/dialogs/message_dialogSucces.dart';
import 'package:table_tap_admin/features/shared/widgets/loading_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/swich_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/provider.dart';

class TableRegisterScreen extends ConsumerStatefulWidget {
  const TableRegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TableRegisterScreenState();
}

class _TableRegisterScreenState extends ConsumerState<TableRegisterScreen> {
  final TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _statusTable = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar mesa"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Crear una nueva mesa',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldCustom(
                      text: "Numero de mesa",
                      controller: _numberController,
                      hintText: "Ingrese un numero",
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    const Text("Estado Actual"),
                    const SizedBox(height: 10),
                    SwichCustomer(
                      available: _statusTable,
                      onChange: () {
                        setState(() {
                          _statusTable = !_statusTable;
                        });
                      },
                      title: "Activar disponibilidad",
                    ),
                    const SizedBox(height: 25),
                    loading
                        ? const Center(child: LoadingCustomer())
                        : Container(),
                    const SizedBox(height: 10),
                    ButtonCustomer(text: "Guardar", press: handletSubmit)
                  ],
                )),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  handleCleantext() {
    _numberController.text = "";
    _statusTable = false;
  }

  handletSubmit() async {
    setState(() {
      loading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        final tableProvider = ref.read(tablesProvider.notifier);
        final requestTable = TableModel(
          number: int.parse(_numberController.text),
          available: _statusTable,
        );
        await tableProvider.addTable(requestTable);
      }
      messageDialogSucces(context, "mesa creada con exito", "");
    } catch (e) {
      messageDialogError(context, "Error en al actualizar la mesa", "");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
