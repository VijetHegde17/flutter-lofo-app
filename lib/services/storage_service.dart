import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class StorageService {
  StorageService(this._storage);

  final FirebaseStorage _storage;

  Future<String?> uploadItemImage(
    XFile? file, {
    required String ownerId,
    required String itemId,
  }) async {
    if (file == null) return null;

    final fileExtension = p.extension(file.name.isNotEmpty ? file.name : file.path);
    final fileName =
        '$ownerId-$itemId-${DateTime.now().millisecondsSinceEpoch}$fileExtension';
    final ref = _storage.ref('item_images/$fileName');

    final bytes = await file.readAsBytes();
    final metadata = SettableMetadata(
      contentType: file.mimeType ?? 'image/jpeg',
    );

    await ref.putData(bytes, metadata);

    return ref.getDownloadURL();
  }
}

