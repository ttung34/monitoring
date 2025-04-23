import 'package:flutter/material.dart';
import 'package:quan_ly_muc/state_manager/item_monitor_provider.dart';

class ItemMonitoringView extends StatefulWidget {
  const ItemMonitoringView({super.key});

  @override
  State<ItemMonitoringView> createState() => _ItemMonitoringViewState();
}

class _ItemMonitoringViewState extends State<ItemMonitoringView> {
  @override
  Widget build(BuildContext context) {
    final provider = ItemMonitorProvider.of(context)?.itemViewModel;
    // Chỉ hiển thị các item khi đang được monitoring
    final monitoringItems =
        provider?.itemModel?.where((item) => item.isMonitoring).toList() ?? [];
    return Scaffold(
      // appBar: AppBar(title: const Text("Danh sách mục")),
      body: ListView.builder(
        itemCount: provider?.itemModel.length ?? 0,
        itemBuilder: (context, index) {
          final item = provider!.itemModel[index];
          return ListTile(
            title: Text(item.name ?? ""),
            subtitle: Text(item.value ?? ""),
            trailing: Icon(
              item.isMonitoring
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
            onTap: () => provider.toggleItemStatus(item.id),
          );
        },
      ),
    );
  }
}
