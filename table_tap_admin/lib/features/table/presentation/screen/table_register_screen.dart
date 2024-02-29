import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_tap_admin/config/validate/validations.dart';
import 'package:table_tap_admin/features/shared/widgets/button_customer.dart';
import 'package:table_tap_admin/features/shared/widgets/textfield_customer.dart';
import 'package:table_tap_admin/features/table/domain/models/table_model.dart';
import 'package:table_tap_admin/features/table/presentation/riverpod/table_provider.dart';
import 'package:table_tap_admin/features/table/presentation/widget/qr_details_widget.dart';

class TableRegisterScreen extends ConsumerStatefulWidget {
  const TableRegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TableRegisterScreenState();
}

class _TableRegisterScreenState extends ConsumerState<TableRegisterScreen> {
  String data = "";
  TableModel? mesa;
  final TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Validate _validate = Validate();

  Future<void> generateQrCode() async {
    if (_formKey.currentState!.validate()) {
      final tableRepository = ref.read(tableRepositoryProvider);
      final requestTable =
          TableModel(number: int.parse(_numberController.text), available: true);

      final response = await tableRepository.createTable(requestTable);
      data = "${response.number}";
      if (response != null) {
        mesa = response;
      }
      setState(() {});
    }
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text('Genera un código QR para la mesa'),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: TextFieldCustom(
              text: "Numero de mesa",
              controller: _numberController,
              hintText: "Ingrese un numero",
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 300,
            child: ButtonCustomer(
              text: "Generar code QR",
              press: generateQrCode,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: data.isEmpty ? buildForm() : QrDetailsWidget(table: mesa!),
          ),
        ],
      ),
    );
  }
}
