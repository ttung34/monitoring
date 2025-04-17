import 'package:flutter/material.dart';
import 'package:quan_ly_muc/state_manager/item_monitor_provider.dart';

class ItemMonitorView extends StatefulWidget {
  const ItemMonitorView({super.key});

  @override
  State<ItemMonitorView> createState() => _ItemMonitorViewState();
}

class _ItemMonitorViewState extends State<ItemMonitorView> {
  @override
  Widget build(BuildContext context) {
    final provider = ItemMonitorProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Item Monitor")),
      body: ListView.builder(
        itemCount: provider?.itemModel.length ?? 0,
        itemBuilder: (context, index) {
          final item = provider?.itemModel[index];
          return ListTile(
            title: Text(item?.name ?? ""),
            subtitle: Text(item?.value ?? ""),
            trailing: Icon(
              item!.isMonitoring
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
            onTap: () => provider!.toggleMonitoring(item),
          );
        },
      ),
    );
  }
}
