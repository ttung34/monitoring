import 'package:flutter/widgets.dart';
import 'package:quan_ly_muc/model/item_model.dart';
import 'package:quan_ly_muc/vew_model/item_view_model.dart';

class ItemMonitorProvider extends InheritedWidget {
  // final List<ItemModel> itemModel;
  // final List<ItemModel> monitoringItems;
  final ItemViewModel? itemViewModel;
  final ItemViewModel? monitoringItems;
  final void Function(ItemModel itemModel) toggleMonitoring;

  const ItemMonitorProvider({
    super.key,
    required super.child,
    required this.itemViewModel,
    required this.monitoringItems,
    required this.toggleMonitoring,
  });

  static ItemMonitorProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ItemMonitorProvider>();
  }

  @override
  bool updateShouldNotify(ItemMonitorProvider oldWidget) {
    return itemViewModel != oldWidget.itemViewModel ||
        monitoringItems != oldWidget.monitoringItems;
  }
}
