import '../controllers/budget_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetViewWidget extends StatelessWidget {
  final budgetController = Get.find<BudgetController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (budgetController.size == 0) {
        return const Expanded(child: Center(child: Text('No income added')));
      } else {
        return Expanded(
          // Ensure it takes available space in a Flex widget
          child: ListView.builder(
            itemCount: budgetController.budgetList.length,
            itemBuilder: (context, index) {
              final budget = budgetController.budgetList[index];
              return ListTile(
                title: Text(budget.source),
                subtitle: Text(
                  '+ ${budget.amount}€',
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => Get.toNamed("/editScreen/${budget.id}"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => budgetController.delete(budget),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    });
  }
}
