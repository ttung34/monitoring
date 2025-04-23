import 'package:flutter/material.dart';
import 'package:quan_ly_muc/model/item_model.dart';
import 'package:quan_ly_muc/state_manager/item_monitor_provider.dart';
import 'package:quan_ly_muc/vew_model/item_view_model.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({this.itemViewModel, this.itemModel, super.key});
  final ItemViewModel? itemViewModel;
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

  void _saveTodo() async {
    try {
      if (_formKey.currentState!.validate()) {
        final provider = ItemMonitorProvider.of(context)?.itemViewModel;
        if (provider != null) {
          if (widget.itemModel == null) {
            await provider.addTask(_nameController.text, _titelController.text);
          }
          if (context.mounted) {
            Navigator.pop(context, true);
          }
        } else {
          await provider?.update(
            widget.itemModel!.id,
            _nameController.text,
            _titelController.text,
          );
          if (context.mounted) {
            Navigator.pop(context, true);
          }
        }
      } else {
        print("Lỗi: ItemViewModel không tồn tại");
      }
    } catch (e) {
      print("Lỗi khi ấn nút thêm $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ItemMonitorProvider.of(context)?.itemViewModel;
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
              ElevatedButton(
                onPressed: _saveTodo,
                child: Text(widget.itemModel == null ? "Thêm" : "Cập nhật"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
