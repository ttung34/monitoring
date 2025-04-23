import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quan_ly_muc/model/item_model.dart';

class FirebaseStoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _taskCollection = FirebaseFirestore.instance
      .collection('task');

  Future<void> addTask(ItemModel itemModel) async {
    try {
      await _taskCollection.add(itemModel.toFirestore());
    } catch (e) {
      print("Lỗi khi thêm giá trị lên firebase $e");
    }
  }

  Future<void> updateTask(ItemModel itemModel) async {
    try {
      await _taskCollection.doc(itemModel.id).update(itemModel.toFirestore());
    } catch (e) {
      print("Lỗi khi sửa giá trị $e");
    }
  }

  Future<void> removeTask(String id) async {
    try {
      await _taskCollection.doc(id).delete();
    } catch (e) {
      print("Lỗi khi xoá task $e");
    }
  }
}
