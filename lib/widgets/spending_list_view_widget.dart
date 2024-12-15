import '../controllers/spending_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpendingViewWidget extends StatelessWidget {
  final spendingController = Get.find<SpendingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (spendingController.size == 0) {
        return const Expanded(child: Center(child: Text('No expenses added')));
      } else {
        return Expanded(
          // Wrap the ListView.builder with Expanded
          child: ListView.builder(
            itemCount: spendingController.spendingList.length,
            itemBuilder: (context, index) {
              final spending = spendingController.spendingList[index];
              return ListTile(
                title: Text(spending.source),
                subtitle: Text(
                  '- ${spending.amount}€',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          Get.toNamed("/editScreenSpending/${spending.id}"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => spendingController.delete(spending),
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
