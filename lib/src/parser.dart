import 'package:antlr4/antlr4.dart';
import 'package:cel/cel.dart';
import 'package:fake_firebase_security_rules/src/method.dart';
import 'package:fake_firebase_security_rules/src/gen/FirestoreRulesLexer.dart';
import 'package:fake_firebase_security_rules/src/gen/FirestoreRulesParser.dart';
import 'package:fake_firebase_security_rules/src/path_match.dart';
import 'package:fake_firebase_security_rules/src/path_segment/const_path_segment.dart';
import 'package:fake_firebase_security_rules/src/path_segment/path_segment.dart';
import 'package:fake_firebase_security_rules/src/path_segment/variable_path_segment.dart';
import 'package:fake_firebase_security_rules/src/path_segment/wildcard_path_segment.dart';
import 'package:fake_firebase_security_rules/src/service.dart';
import 'package:logger/logger.dart';

final Map<String, RegExp> unsupportedFeatures = {
  'resource': RegExp(r'[^.]resource'),
  'request.resource': RegExp(r'request\.resource'),
  'get': RegExp(r'get\('),
  'functions': RegExp(r'function [\w\d_-]+\('),
  'timestamp': RegExp(r'timestamp\.')
};

/// Parses a [String] describing a service to a [Service] wrapping [PathMatch]
/// and compiled CEL [Program]s.
class Parser {
  Parser({Logger? logger}) : logger = logger ?? Logger();

  final Logger logger;
  List<Service> parse(String serviceDescription) {
    for (final feature in unsupportedFeatures.entries) {
      if (feature.value.hasMatch(serviceDescription)) {
        logger.w(
            'fake_firebase_security_rules does not support `${feature.key}` yet.');
      }
    }
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
  final environment = Environment.standard();
  final ast = environment.compile(celCode);
  final program = environment.makeProgram(ast);
  return AllowStatement(
      allow.METHODs()
          .map((node) => Method.fromNameInFirebase(node.text!))
          .toList(),
      program);
}

/// Extensions to help clean up CEL.
extension on String {
  String removeStarting(String s) {
    return startsWith(s) ? substring(s.length, length).trim() : this;
  }

  String removeTrailing(String s) {
    return endsWith(s) ? substring(0, length - s.length).trim() : this;
  }
}

String cleanUpCEL(String? cel) {
  if (cel == null || cel.removeTrailing(';').isEmpty) {
    return 'true';
  }
  return cel.removeStarting(':').removeStarting('if').removeTrailing(';');
}

List<PathSegment> visitPath(PathContext path) {
  return path.pathSegments().map((s) => visitPathSegment(s)).toList();
}

PathSegment visitPathSegment(PathSegmentContext s) {
  if (s.NAME() != null) {
    return ConstPathSegment(s.NAME()!.text!);
  }
  final variableName = s.variable()!.NAME()!.text!;
  return s.variable()!.wildcard != null
      ? WildcardPathSegment(variableName)
      : VariablePathSegment(variableName);
}
