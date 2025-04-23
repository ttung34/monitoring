import 'package:flutter/material.dart';
import 'package:quan_ly_muc/model/item_model.dart';

class ItemViewModel extends ChangeNotifier {
  // Danh sách các Item
  final List<ItemModel> _itemModel = [];
  // Item đang được chọn để chỉnh sửa
  ItemModel? _selectedItem;
  //Trạng thái chỉnh sửa.
  bool _isEdding = false;

  // Getter
  List<ItemModel> get itemModel => _itemModel;
  ItemModel? get selectedItem => _selectedItem;
  bool get isEdding => _isEdding;

  Future<void> addTask(String name, String value) async {
    final newItem = ItemModel(
      id: DateTime.now().toString(),
      name: name,
      value: value,
      isMonitoring: false,
    );
    _itemModel.add(newItem);
    notifyListeners();
  }

  Future<void> update(String id, String name, String value) async {
    final index = _itemModel.indexWhere(((itemModel) => itemModel.id == id));
    try {
      if (index != -1) {
        _itemModel[index] = ItemModel(
          id: _itemModel[index].id,
          name: name,
          value: value,
          isMonitoring: _itemModel[index].isMonitoring,
        );
        _selectedItem = null;
        _isEdding = false;
        notifyListeners();
      }
    } catch (e) {
      print("lỗi update $e");
    }
  }

  void toggleItemStatus(String id) {
    final index = _itemModel.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _itemModel[index] = _itemModel[index].copyWith(
        isMonitoring: !_itemModel[index].isMonitoring,
      );
      notifyListeners();
    }
  }

  Future<void> removeItem(String id) async {
    try {
      _itemModel.removeWhere((element) => element.id == id);
      if (_selectedItem?.id == id) {
        _selectedItem = null;
        _isEdding = false;
      }
      notifyListeners();
    } catch (e) {
      print("Lỗi khi xoá giá trị $e");
    }
  }

  void selectItem(ItemModel itemModel) {
    _selectedItem = itemModel;
    _isEdding = true;
    notifyListeners();
  }
}
