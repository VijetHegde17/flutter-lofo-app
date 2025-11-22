import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/item_model.dart';

class ItemService {
  ItemService(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _collection(ItemType type) {
    return _firestore.collection(type.collectionName);
  }

  Stream<List<ItemModel>> watchItems(ItemType type) {
    return _collection(type)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ItemModel.fromDoc(doc, type))
              .toList(),
        );
  }

  String generateItemId(ItemType type) {
    return _collection(type).doc().id;
  }

  Future<void> addItem(ItemModel item) async {
    final collection = _collection(item.type);
    final doc = collection.doc(item.id);
    await doc.set(item.toMap());
  }
}

