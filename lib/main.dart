import 'package:flutter/material.dart';
import '../controllers/budget_controller.dart';
import '../controllers/spending_controller.dart';
import '../views/budget_screen.dart';
import '../views/edit_screen_budget.dart';
import '../views/edit_screen_spending.dart';
import '../views/home_screen.dart';
import '../views/statistic_screen.dart';
import '../views/expense_screen.dart';
import '../widgets/budget_list_view_widget.dart';
import '../widgets/spending_list_view_widget.dart';

import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");
  Get.lazyPut(() => BudgetController());
  Get.lazyPut(() => BudgetViewWidget());
  Get.lazyPut(() => SpendingController());
  Get.lazyPut(() => SpendingViewWidget());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => HomeScreen()),
        GetPage(name: "/addBudget", page: () => BudgetScreen()),
        GetPage(name: "/addExpense", page: () => ExpenseScreen()),
        GetPage(name: "/statistics", page: () => StatisticScreen()),
        GetPage(name: "/editScreen/:editId", page: () => EditScreen()),
        GetPage(
            name: "/editScreenSpending/:editId",
            page: () => EditScreenSpending()),
      ],
    );
  }
}
