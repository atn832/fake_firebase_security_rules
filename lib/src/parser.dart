import 'package:antlr4/antlr4.dart';
import 'package:cel/cel.dart';
import 'package:fake_firebase_security_rules/src/method.dart';
import 'package:fake_firebase_security_rules/src/gen/FirestoreRulesLexer.dart';
import 'package:fake_firebase_security_rules/src/gen/FirestoreRulesParser.dart';
import 'package:fake_firebase_security_rules/src/path_match.dart';
import 'package:fake_firebase_security_rules/src/path_segment.dart';
import 'package:fake_firebase_security_rules/src/service.dart';

/// Parses a [String] describing a service to a [Service] wrapping [PathMatch]
/// and compiled CEL [Program]s.
class Parser {
  List<Service> parse(String serviceDescription) {
    final input = InputStream.fromString(serviceDescription);
    final lexer = FirestoreRulesLexer(input);
    final tokens = CommonTokenStream(lexer);
    final parser = FirestoreRulesParser(tokens);
    parser.addErrorListener(DiagnosticErrorListener());
    final tree = parser.rulesDefinition();
    return tree.services().map(visit).toList();
  }
}

Service visit(ServiceContext service) {
  return Service(
      service.serviceName!.text!,
      service
          .matchers()
          .map((matchRule) => visitMatchRule(matchRule))
          .toList());
}

PathMatch visitMatchRule(MatcherContext matchRule) {
  final allows =
      matchRule.allows().map((allowRule) => visitAllowRule(allowRule)).toList();
  return PathMatch(visitPath(matchRule.path()!), allows,
      matchRule.matchers().map((match) => visitMatchRule(match)).toList());
}

AllowStatement visitAllowRule(AllowContext allow) {
  // The CEL might start with ':' and potentially 'if' and always ends with ';'.
  // Remove them.
  final celCode = cleanUpCEL(allow.CEL()?.text);
  final environment = Environment();
  final ast = environment.compile(celCode);
  final program = Program(environment, ast);
  return AllowStatement(
      allow.METHODs()
          .map((node) => Method.fromNameInFirebase(node.text!))
          .toList(),
      program);
}

String cleanUpCEL(String? cel) {
  if (cel == null) {
    return 'true';
  }
  // Remove the starting ':'.
  // Remove the starting 'if' if it exists.
  final start = cel.startsWith(': if') ? 5 : 2;
  // Remove the trailing ';'.
  final end = cel.length - 1;
  return cel.substring(start, end);
}

List<PathSegment> visitPath(PathContext path) {
  return path.pathSegments().map((s) => visitPathSegment(s)).toList();
}

PathSegment visitPathSegment(PathSegmentContext s) {
  return s.NAME() != null
      ? ConstPathSegment(s.NAME()!.text!)
      : VariablePathSegment(s.variable()!.NAME()!.text!);
}
