import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../models/spending.dart';

class SpendingController {
  final storage = Hive.box("storage");

  RxList spendingList;

  SpendingController() : spendingList = [].obs {
    if (storage.get('spendingList') == null) {
      storage.put('spendingList', []);
    }
    spendingList.value = storage
        .get('spendingList')
        .map(
          (spending) => Spending.fromJson(spending),
        )
        .toList();
  }
  void _save() {
    storage.put(
      'spendingList',
      spendingList.map((spending) => spending.toJson()).toList(),
    );
  }

  void add(Spending spending) {
    spendingList.add(spending);
    _save();
  }

  void delete(Spending spending) {
    spendingList.remove(spending);
    spendingList.refresh();
    _save();
  }

  void edit(Spending spending) {
    int index = spendingList.indexWhere((outcome) => outcome.id == spending.id);
    spendingList[index] = spending;
    spendingList.refresh();
    _save();
  }

  get size => spendingList.length;
}
