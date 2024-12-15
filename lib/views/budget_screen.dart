import 'package:dad/widgets/custom_scaffold_widget.dart';

import '../controllers/budget_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../models/budget.dart';

class BudgetScreen extends StatelessWidget {
  final BudgetController budgetController = Get.find<BudgetController>();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      final parsedAmount =
          double.tryParse(_formKey.currentState!.value['amount']) ?? 0.0;
      Budget income = Budget(
        DateTime.now().millisecondsSinceEpoch,
        _formKey.currentState!.value['source'],
        parsedAmount,
      );
      budgetController.add(income);
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
              AppBar(
                title: const Text("Expense tracker "),
              ),
              FormBuilderTextField(
                name: "source",
                decoration: const InputDecoration(
                  labelText: "Income Source",
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16.0),
              FormBuilderTextField(
                name: "amount",
                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
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
