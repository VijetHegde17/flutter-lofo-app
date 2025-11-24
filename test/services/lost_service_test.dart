import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:lost_found_app/services/lost_service.dart';

// Simple Mockito-based mock for SupabaseClient
class MockSupabase extends Mock {}

// We don't implement any specific Postgrest type here to avoid tight coupling
class MockQueryBuilder extends Mock {}

void main() {
  test('addLostItem inserts into supabase (fake)', () async {
    final fakeTable = FakeTable();
    final fakeClient = FakeClient(fakeTable);

    final service = LostService(fakeClient);

    await service.addLostItem(
      name: 'Wallet',
      description: 'Black',
      location: 'Gate A',
      imageUrl: 'img.png',
    );

    expect(fakeTable.insertCalled, isTrue);
    expect(fakeTable.lastData?['name'], 'Wallet');
    expect(fakeTable.lastData?['location'], 'Gate A');
  });
}

// Lightweight fakes for testing without depending on Mockito or Supabase
class FakeTable {
  bool insertCalled = false;
  Map<String, dynamic>? lastData;

  Future<void> insert(Map<String, dynamic> data) async {
    insertCalled = true;
    lastData = data;
    return;
  }
}

class FakeClient {
  final FakeTable table;
  FakeClient(this.table);

  // returns the table-like object used in LostService
  dynamic from(String tableName) => table;
}
