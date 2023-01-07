import 'package:antlr4/antlr4.dart';
import 'package:cel/cel.dart';
import 'package:fake_firebase_security_rules/src/access_type.dart';
import 'package:fake_firebase_security_rules/src/gen/FirestoreRulesLexer.dart';
import 'package:fake_firebase_security_rules/src/gen/FirestoreRulesParser.dart';
import 'package:fake_firebase_security_rules/src/path_match.dart';
import 'package:fake_firebase_security_rules/src/service.dart';

/// Parses a [String] describing a service to a [Service] wrapping [PathMatch]
/// and compiled CEL [Program]s.
class Parser {
  Service parse(String serviceDescription) {
    final input = InputStream.fromString(serviceDescription);
    final lexer = FirestoreRulesLexer(input);
    final tokens = CommonTokenStream(lexer);
    final parser = FirestoreRulesParser(tokens);
    parser.addErrorListener(DiagnosticErrorListener());
    final tree = parser.rulesDefinition();
    final service = tree.service();
    if (service == null) {
      throw StateError('Expected at one service description.');
    }
    return visit(service);
  }
}

Service visit(ServiceContext service) {
  return Service(service
      .matchRules()
      .map((matchRule) => visitMatchRule(matchRule))
      .toList());
}

PathMatch visitMatchRule(MatchRuleContext matchRule) {
  final allows =
      matchRule.allows().map((allowRule) => visitAllowRule(allowRule)).toList();
  return PathMatch(allows, []);
}

AllowStatement visitAllowRule(AllowContext allow) {
  final celCode = allow.CES_EXPRESSION()!.text!;
  final environment = Environment();
  final ast = environment.compile(celCode);
  final program = Program(environment, ast);
  return AllowStatement(
      allow.ACCESSs()
          .map((node) => AccessType.fromNameInFirebase(node.text!))
          .toList(),
      program);
}
