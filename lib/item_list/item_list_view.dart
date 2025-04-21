import 'package:flutter/material.dart';
import 'package:quan_ly_muc/item_list/crud/add_item.dart';
import 'package:quan_ly_muc/state_manager/item_monitor_provider.dart';

class ItemListView extends StatefulWidget {
  const ItemListView({super.key});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    final provider = ItemMonitorProvider.of(context)?.itemModel;
    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách mục")),
      body: ListView.builder(
        itemCount: provider?.itemModel.length ?? 0,
        itemBuilder: (context, index) {
          final item = provider!.itemModel[index];
          return ListTile(
            title: Text(item.name ?? ""),
            subtitle: Text(item.value ?? ""),
            trailing: Icon(
              item!.isMonitoring
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
            onTap: () => provider?.isMonitoring(item.id),
          );
        },
      ),
    );
  }
}
