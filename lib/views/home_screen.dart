import '../controllers/budget_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/budget_list_view_widget.dart';
import '../widgets/spending_list_view_widget.dart';
import '../widgets/custom_scaffold_widget.dart';

import '../models/breakpoints.dart';

class HomeScreen extends StatelessWidget {
  final budgetController = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > Breakpoints.sm) {
            return Column(
              children: [
                AppBar(title: const Text("Expense tracker ✨")),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          onPressed: () => Get.toNamed("/addBudget"),
                          child: const Text(
                            "Set your monthly budget",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          onPressed: () => Get.toNamed("/addExpense"),
                          child: const Text(
                            "Set your monthly costs",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Row(
                  children: [
                    BudgetViewWidget(),
                    SpendingViewWidget(),
                  ],
                )),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: OutlinedButton(
                      onPressed: () => Get.toNamed("/statistics"),
                      child: const Text(
                        "Additional statistics",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                AppBar(title: const Text("Expense tracker ✨")),
                Container(
                  padding: const EdgeInsets.all(32),
                  child: TextButton(
                    onPressed: () => Get.toNamed("/addBudget"),
                    child: const Text(
                      "Set your monthly budget",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                BudgetViewWidget(),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextButton(
                    onPressed: () => Get.toNamed("/addExpense"),
                    child: const Text(
                      "Set your monthly costs",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                SpendingViewWidget(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: OutlinedButton(
                    onPressed: () => Get.toNamed("/statistics"),
                    child: const Text(
                      "Additional statistics",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
