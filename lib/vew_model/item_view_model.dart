import 'package:flutter/material.dart';
import 'package:quan_ly_muc/model/item_model.dart';

class ItemViewModel extends ChangeNotifier {
  final List<ItemModel> _itemModel = [];
  List<ItemModel> get itemModel => _itemModel;

  Future<void> addTask(String name, String value) async {
    try {
      final newItem = await ItemModel(
        id: DateTime.now().toString(),
        name: name,
        value: value,
      );
      _itemModel.add(newItem);
      notifyListeners();
    } catch (e) {
      print("Lỗi khi thêm giá trị mới: $e");
    }
  }

  Future<void> update(String id, String name, String value) async {
    try {
      final index = await _itemModel.indexWhere(
        ((itemModel) => itemModel.id == id),
      );
      notifyListeners();
      if (index == -1) {
        _itemModel[index] = ItemModel(
          id: _itemModel[index].id,
          name: name,
          value: value,
          isMonitoring: _itemModel[index].isMonitoring,
        );
      }
    } catch (e) {
      print("Lỗi khi thay đổi giá trị $e");
    }
  }

  void isMonitoring(String id) async {
    try {
      final item = _itemModel.firstWhere((element) => element.id == id);
      item.toggleDone();
      notifyListeners();
    } catch (e) {
      print("Looix $e");
    }
  }

  Future<void> removeItem(String id) async {
    try {
      itemModel.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      print("Lỗi khi xoá giá trị $e");
    }
  }
}
