import 'package:fake_firebase_security_rules/fake_firebase_security_rules.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = FakeFirebaseSecurityRules();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
