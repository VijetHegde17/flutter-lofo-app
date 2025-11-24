import 'package:flutter_test/flutter_test.dart';
import 'package:lost_found_app/services/auth_service.dart';

class _FakeAuth {
  bool called = false;
  String? email;
  String? password;
  Map<String, dynamic>? data;

  Future<dynamic> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    called = true;
    this.email = email;
    this.password = password;
    this.data = data;
    return null;
  }
}

class _FakeClient {
  final _FakeAuth auth = _FakeAuth();
}

void main() {
  test('signup calls supabase.auth.signUp', () async {
    final fakeClient = _FakeClient();
    final service = AuthService(client: fakeClient);

    await service.signUp(
      email: 'test@mail.com',
      password: '123456',
      username: 'TestUser',
    );

    expect(fakeClient.auth.called, isTrue);
    expect(fakeClient.auth.email, 'test@mail.com');
    expect(fakeClient.auth.password, '123456');
    expect(fakeClient.auth.data, containsPair('username', 'TestUser'));
  });
}
