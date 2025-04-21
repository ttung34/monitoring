import 'package:flutter/material.dart';
import 'package:quan_ly_muc/home/home_screen.dart';
import 'package:quan_ly_muc/model/item_model.dart';
import 'package:quan_ly_muc/state_manager/item_monitor_provider.dart';
import 'package:quan_ly_muc/vew_model/item_view_model.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({this.itemModel, super.key});
  final ItemModel? itemModel;

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  final List<ItemModel> itemModel = [];
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _titelController = TextEditingController();

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.itemModel?.name ?? "");
    _titelController = TextEditingController(
      text: widget.itemModel?.value ?? "",
    );
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titelController.dispose();
    super.dispose();
  }

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final value = _titelController.text;
      final itemModel = ItemMonitorProvider.of(context)?.itemModel;
      if (widget.itemModel == null) {
        itemModel?.addTask(name, value);
      } else {
        itemModel?.update(widget.itemModel!.id, name, value);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreenView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.itemModel == null
              ? "Thêm danh sách mới"
              : "Chỉnh sửa danh sách",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Không được để trống tiêu đề';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titelController,
                decoration: InputDecoration(labelText: 'Mô tả'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Không được để trống mô tả';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveTodo, child: Text('Lưu')),
            ],
          ),
        ),
      ),
    );
  }
}
