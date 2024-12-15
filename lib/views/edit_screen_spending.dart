import 'package:dad/widgets/custom_scaffold_widget.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: unused_import
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../controllers/spending_controller.dart';
import '../models/spending.dart';
import 'package:flutter/material.dart';

class EditScreenSpending extends StatelessWidget {
  final SpendingController spendingController = Get.find<SpendingController>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final parsedAmount =
          double.tryParse(_formKey.currentState!.value['editedAmount']) ?? 0.0;
      Spending editedSpending = Spending(
        int.parse(Get.parameters["editId"] ?? "0"),
        _formKey.currentState!.value['editedSource'],
        parsedAmount,
      );
      spendingController.edit(editedSpending);
      _formKey.currentState?.reset();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              AppBar(title: const Text("Expense tracker ")),
              FormBuilderTextField(
                name: "editedSource",
                decoration: const InputDecoration(
                  labelText: "Expense Source",
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(
                    errorText: 'This field is required.'),
              ),
              const SizedBox(height: 16.0),
              FormBuilderTextField(
                name: "editedAmount",
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'This field is required.'),
                  FormBuilderValidators.numeric(errorText: 'Must be a number.'),
                  FormBuilderValidators.min(0,
                      errorText: "Must be greater than 0"),
                ]),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text("Set", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
