import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/app/core/utils/helper.dart';

void main() {
  test('Handle Error Method Testing', () async {
    final value = await handleFirebaseAuthError(() async {
      return true;
    });
    expect(true, value);
  });
}
