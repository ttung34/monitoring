import 'package:flutter/material.dart';
import 'package:quan_ly_muc/state_manager/item_monitor_provider.dart';

class ItemListView extends StatefulWidget {
  const ItemListView({super.key});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    final provider = ItemMonitorProvider.of(context)?.itemViewModel;
    // Chỉ hiển thị các item khi đang được monitoring
    final monitoringItems =
        provider?.itemModel.map((item) => item).toList() ?? [];
    return Scaffold(
      // appBar: AppBar(title: const Text("Danh sách mục")),
      body: ListView.builder(
        itemCount: monitoringItems.length ?? 0,
        itemBuilder: (context, index) {
          final item = monitoringItems[index];
          return ListTile(
            title: Text(item.name ?? ""),
            subtitle: Text(item.value ?? ""),
            trailing: Icon(
              item.isMonitoring
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
            onTap: () => provider?.toggleItemStatus(item.id),
          );
        },
      ),
    );
  }
}
