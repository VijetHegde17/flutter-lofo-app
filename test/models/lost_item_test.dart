import 'package:flutter_test/flutter_test.dart';
import 'package:lost_found_app/models/lost_item.dart';

void main() {
  test('LostItem model initializes correctly', () {
    final item = LostItem(
      id: '1',
      name: 'Wallet',
      description: 'Black leather wallet',
      location: 'Gate A',
      imageUrl: 'https://example.com/img.png',
    );

    expect(item.id, '1');
    expect(item.name, 'Wallet');
    expect(item.location, isNotEmpty);
  });

  test('LostItem toJson works correctly', () {
    final item = LostItem(
      id: '2',
      name: 'Phone',
      description: 'iPhone 12',
      location: 'Library',
      imageUrl: 'image.png',
    );

    final json = item.toJson();

    expect(json['name'], 'Phone');
    expect(json['location'], 'Library');
  });
}
