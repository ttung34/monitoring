import 'package:flutter/material.dart';
import 'package:quan_ly_muc/item_list/item_list_view.dart';
import 'package:quan_ly_muc/item_list/item_monitor_view.dart';
import 'package:quan_ly_muc/model/item_model.dart';
import 'package:quan_ly_muc/state_manager/item_monitor_provider.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  final List<ItemModel> _itemModel = [
    ItemModel(name: 'Mục 1', value: 'Giá trị 1'),
    ItemModel(name: 'Mục 2', value: 'Giá trị 2'),
    ItemModel(name: 'Mục 3', value: 'Giá trị 3'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void toggleMonitoring(ItemModel itemModel) {
    setState(() {
      final index = _itemModel.indexWhere((d) => d == itemModel);
      if (index == -1) {
        _itemModel[index] = _itemModel[index].copyWith(
          isMonitoring: !_itemModel[index].isMonitoring,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final monitoredCount = _itemModel.where((d) => d.isMonitoring).length;

    return ItemMonitorProvider(
      itemModel: _itemModel,
      monitoringItem: _itemModel.where((item) => item.isMonitoring).toList(),
      toggleMonitoring: toggleMonitoring,
      child: Scaffold(
        appBar: AppBar(title: const Text("Ứng dụng của tôi")),
        body: TabBarView(
          controller: _tabController,
          children: const [ItemListview(), ItemMonitorView()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              _tabController.animateTo(index);
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.devices),
              label: 'Danh mục thiết bị',
            ),
            BottomNavigationBarItem(
              icon:
                  monitoredCount > 0
                      ? Badge.count(
                        count: monitoredCount,
                        child: const Icon(Icons.bar_chart),
                      )
                      : const Icon(Icons.bar_chart),
              label: "Theo doi",
            ),
          ],
        ),
      ),
    );
  }
}
