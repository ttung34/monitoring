import 'package:flutter/material.dart';
import 'package:quan_ly_muc/item_list/crud/add_item.dart';
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
  int _seletecdIndex = 0;
  final List<ItemModel> _itemModel = [];

  void _addItem() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AddItemView(itemModel: null)),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _seletecdIndex = _tabController.index;
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
    final monitoringCount = _itemModel.where((d) => d.isMonitoring).length;
    return ItemMonitorProvider(
      // itemModel: _itemModel,
      // monitoringItems: _itemModel.where((item) => item.isMonitoring).toList(),
      toggleMonitoring: toggleMonitoring,
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
          actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [ItemListView(), ItemMonitoringView()],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _seletecdIndex,
          onTap: (index) {
            setState(() {
              _seletecdIndex = index;
              _tabController.animateTo(index);
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.devices),
              label: "Danh sách mục",
            ),
            BottomNavigationBarItem(
              icon:
                  monitoringCount > 0
                      ? Badge.count(
                        count: monitoringCount,
                        child: const Icon(Icons.bar_chart),
                      )
                      : const Icon(Icons.bar_chart),
              label: 'Theo dõi',
            ),
          ],
        ),
      ),
    );
  }
}
