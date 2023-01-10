import 'package:fake_firebase_security_rules/src/method.dart';
import 'package:fake_firebase_security_rules/src/parser.dart';
import 'package:fake_firebase_security_rules/src/path_match.dart';
import 'package:fake_firebase_security_rules/src/service.dart';
import 'package:logger/logger.dart';

class FakeFirebaseSecurityRules {
  FakeFirebaseSecurityRules(String securityRules, {Logger? logger})
      : logger = logger ?? Logger() {
    service = Parser(logger: this.logger)
        .parse(securityRules)
        .firstWhere((service) => service.name == 'cloud.firestore');
  }

  late final Service service;
  final Logger logger;

  /// Evaluates whether an operation is allowed or not. `path` is the full path
  /// from root without a starting '/'.
  bool isAllowed(String path, Method method,
      {Map<String, dynamic> variables = const {}}) {
    assert(!path.startsWith('/'));
    for (final match in service.pathMatches) {
      if (match.isAllowed(path.concretePathSegments, method,
          variables: variables, logger: logger)) {
        return true;
      }
    }
    return false;
  }
}
