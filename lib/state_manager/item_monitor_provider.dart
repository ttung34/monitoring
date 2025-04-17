import 'package:flutter/material.dart';
import 'package:quan_ly_muc/model/item_model.dart';

class ItemMonitorProvider extends InheritedWidget {
  final List<ItemModel> itemModel;
  final List<ItemModel> monitoringItem;
  final Function(ItemModel itemModel) toggleMonitoring;

  const ItemMonitorProvider({
    super.key,
    required super.child,
    required this.itemModel,
    required this.monitoringItem,
    required this.toggleMonitoring,
  });

  static ItemMonitorProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ItemMonitorProvider>();
  }

  @override
  bool updateShouldNotify(ItemMonitorProvider oldWidget) {
    return itemModel != oldWidget.itemModel ||
        monitoringItem != oldWidget.monitoringItem;
  }
}
