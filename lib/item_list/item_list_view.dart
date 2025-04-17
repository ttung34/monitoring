import 'package:flutter/material.dart';
import 'package:quan_ly_muc/state_manager/item_monitor_provider.dart';

class ItemListview extends StatefulWidget {
  const ItemListview({super.key});

  @override
  State<ItemListview> createState() => _ItemListviewState();
}

class _ItemListviewState extends State<ItemListview> {
  @override
  Widget build(BuildContext context) {
    final provider = ItemMonitorProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Item List")),
      body: ListView.builder(
        itemCount: provider?.itemModel.length ?? 0,
        itemBuilder: (context, index) {
          final item = provider?.itemModel[index];
          return ListTile(
            title: Text(item?.name ?? ''),
            subtitle: Text(item?.value ?? ''),
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
